module("modules.logic.versionactivity2_7.common.EnterActivityViewOnExitFightSceneHelper2_7", package.seeall)

slot0 = EnterActivityViewOnExitFightSceneHelper

function slot0.activate()
end

function slot0.enterActivity12701(slot0, slot1)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_7EnterView)
		VersionActivityFixedEnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			Activity191Controller.instance:openMainView({
				exitFromFight = true
			})
		end, nil, VersionActivity2_7Enum.ActivityId.Act191, true)
	end)
end

function slot0.enterActivity12703(slot0, slot1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_7EnterView)
		VersionActivityFixedEnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , VersionActivity2_7Enum.ActivityId.CooperGarland, true)
	end)
end

function slot0.enterActivity12702(slot0, slot1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_7EnterView)
		VersionActivityFixedEnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , VersionActivity2_7Enum.ActivityId.LengZhou6, true)
	end)
end

function slot0.enterActivity12706(slot0, slot1)
	uv0.enterVersionActivityDungeonCommon(uv0._enterActivity12706, slot0, slot1)
end

function slot0._enterActivity12706(slot0, slot1)
	slot2 = slot1.episodeId

	if not slot1.episodeCo then
		return
	end

	if uv0.sequence then
		uv0.sequence:destroy()

		uv0.sequence = nil
	end

	slot4 = false
	slot5 = VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName()
	slot7 = VersionActivityFixedHelper.getVersionActivityEnterViewName()

	if DungeonModel.instance.curSendEpisodePass then
		slot4 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, VersionActivityFixedHelper.getVersionActivityDungeonMapViewName())
	else
		slot4 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, slot5)
	end

	slot8 = FlowSequence.New()

	slot8:addWork(OpenViewWork.New({
		openFunction = VersionActivityFixedHelper.getVersionActivityEnterController().exitFightEnterView,
		openFunctionObj = VersionActivityFixedHelper.getVersionActivityEnterController().instance,
		waitOpenViewName = slot7
	}))
	slot8:registerDoneListener(function ()
		if uv0 then
			VersionActivityFixedHelper.getVersionActivityDungeonController().instance:openVersionActivityDungeonMapView(nil, uv1, function ()
				ViewMgr.instance:openView(uv0, {
					episodeId = uv1
				})
			end, nil)
		else
			slot0.instance:openVersionActivityDungeonMapView(nil, uv1)
		end
	end)
	slot8:start()

	uv0.sequence = slot8
end

return slot0
