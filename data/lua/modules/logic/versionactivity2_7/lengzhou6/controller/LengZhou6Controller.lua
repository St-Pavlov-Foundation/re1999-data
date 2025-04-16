module("modules.logic.versionactivity2_7.lengzhou6.controller.LengZhou6Controller", package.seeall)

slot0 = class("LengZhou6Controller", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
	slot0.showEpisodeId = nil
end

function slot0.enterLevelView(slot0, slot1)
	LengZhou6Rpc.instance:sendGetAct190InfoRequest(slot1)
end

function slot0.clickEpisode(slot0, slot1)
	slot2 = LengZhou6Model.instance:getAct190Id()

	if not LengZhou6Model.instance:isAct190Open(true) then
		return
	end

	if not LengZhou6Model.instance:isUnlockEpisode(slot1) then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		return
	end

	slot0:dispatchEvent(LengZhou6Event.OnClickEpisode, slot2, slot1)
end

function slot0.enterEpisode(slot0, slot1)
	LengZhou6Enum.enterGM = false

	if not LengZhou6Model.instance:getCurActId() or slot1 == nil then
		return
	end

	LengZhou6Model.instance:setCurEpisodeId(slot1)

	if LengZhou6Config.instance:getEpisodeConfig(slot2, slot1).storyBefore ~= 0 then
		StoryController.instance:playStory(slot4, nil, slot0._enterGame, slot0)
	else
		slot0:_enterGame()
	end
end

function slot0._enterGame(slot0)
	if LengZhou6Config.instance:getEpisodeConfig(LengZhou6Model.instance:getCurActId(), LengZhou6Model.instance:getCurEpisodeId()).eliminateLevelId ~= 0 then
		LengZhou6GameController.instance:enterLevel(slot1, slot2)
	else
		slot0:finishLevel(slot2)
		slot0:dispatchEvent(LengZhou6Event.OnClickCloseGameView)
	end
end

function slot0.restartGame(slot0)
	if LengZhou6Config.instance:getEpisodeConfig(LengZhou6Model.instance:getCurActId(), LengZhou6Model.instance:getCurEpisodeId()).eliminateLevelId ~= 0 then
		LengZhou6GameController.instance:restartLevel(slot1, slot2)
	end
end

function slot0.openLengZhou6LevelView(slot0)
	slot0.showEpisodeId = nil

	ViewMgr.instance:openView(ViewName.LengZhou6LevelView)
end

function slot0.finishLevel(slot0, slot1, slot2)
	if LengZhou6Model.instance:getEpisodeInfoMo(slot1) ~= nil then
		LengZhou6Rpc.instance:sendAct190FinishEpisodeRequest(slot1, slot2)
	end

	if slot3 ~= nil and slot2 ~= nil then
		slot3:setProgress(slot2)
	end
end

function slot0.onFinishEpisode(slot0, slot1)
	if not slot1 then
		return
	end

	slot0.showEpisodeId = slot1.episodeId

	LengZhou6Model.instance:onFinishActInfo(slot1)

	if slot1.activityId == LengZhou6Model.instance:getAct190Id() then
		slot0:_playStoryClear(slot3)
	end
end

function slot0._playStoryClear(slot0, slot1)
	if not LengZhou6Model.instance:isFinishedEpisode(slot1) then
		return
	end

	slot4 = LengZhou6Model.instance:getCurEpisodeId()

	if LengZhou6Model.instance:getCurActId() == nil then
		return
	end

	slot5 = 0

	if slot4 ~= nil then
		slot5 = LengZhou6Config.instance:getEpisodeConfig(slot3, slot4).storyClear
	end

	if slot5 ~= 0 then
		StoryController.instance:playStory(slot5, nil, slot0.showFinishEffect, slot0)
	else
		slot0:showFinishEffect()
	end
end

function slot0.showFinishEffect(slot0)
	slot0:dispatchEvent(LengZhou6Event.OnFinishEpisode, slot0.showEpisodeId)

	slot0.showEpisodeId = nil
end

function slot0.openTaskView(slot0)
	LengZhou6TaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity190
	}, slot0._realOpenTaskView, slot0)
end

function slot0._realOpenTaskView(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	LengZhou6TaskListModel.instance:init()
	ViewMgr.instance:openView(ViewName.LengZhou6TaskView)
end

function slot0.isNeedForceDrop(slot0)
	return GuideModel.instance:isGuideRunning(27201)
end

function slot0.getFixChessPos(slot0)
	if GuideModel.instance:isGuideRunning(27202) then
		return true, {
			x = 2,
			y = 2
		}
	end

	return false, nil
end

slot0.instance = slot0.New()

return slot0
