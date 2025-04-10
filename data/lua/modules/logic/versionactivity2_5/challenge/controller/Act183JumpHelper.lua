module("modules.logic.versionactivity2_5.challenge.controller.Act183JumpHelper", package.seeall)

slot0 = _M

function slot0.activate()
end

slot1 = VersionActivity2_7Enum.ActivityId.Challenge
slot2 = VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.EnterView

function slot0.fightExitHandleFunc(slot0, slot1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Act183MainView)
		VersionActivityFixedEnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , Act183Config.instance:getEpisodeCo(uv0) and slot0.activityId)
		Act183Controller.instance:openAct183MainView(nil, function ()
			Act183Controller.instance:openAct183DungeonView(Act183Helper.generateDungeonViewParams2(uv0))
		end)
	end)
end

function slot0.canJumpToAct183(slot0, slot1)
	slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(uv0)

	if slot2 ~= ActivityEnum.ActivityStatus.Normal then
		return false, slot3, slot4
	end

	slot5, slot6, slot7 = ActivityHelper.getActivityStatusAndToast(uv1)

	if slot5 ~= ActivityEnum.ActivityStatus.Normal then
		return false, slot6, slot7
	end

	if not Act183Config.instance:isGroupExist(uv1, string.splitToNumber(slot1, "#") and slot8[2]) then
		return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
	end

	if (Act183Model.instance:getActInfo():getGroupEpisodeMo(slot9) and slot12:getStatus()) == Act183Enum.GroupStatus.Locked then
		return false, ToastEnum.Act183GroupNotOpen, JumpController.DefaultToastParam
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

function slot0.jumpToAct183(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	table.insert(slot0.waitOpenViewNames, ViewName.Act183MainView)
	table.insert(slot0.waitOpenViewNames, ViewName.Act183DungeonView)
	table.insert(slot0.closeViewNames, ViewName.Act183TaskView)
	VersionActivityFixedEnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		slot2 = Act183Helper.generateDungeonViewParams3(uv1, string.splitToNumber(uv0, "#") and slot0[2])

		if not ViewMgr.instance:isOpen(ViewName.Act183MainView) then
			Act183Controller.instance:openAct183MainView(nil, function ()
				Act183Controller.instance:openAct183DungeonView(uv0)
			end)
		else
			Act183Controller.instance:openAct183DungeonView(slot2)
		end
	end)

	return JumpEnum.JumpResult.Success
end

slot3 = {
	[VersionActivity2_7Enum.ActivityId.Challenge] = slot0.fightExitHandleFunc
}

function slot4()
	for slot3, slot4 in pairs(uv0) do
		EnterActivityViewOnExitFightSceneHelper["enterActivity" .. slot3] = slot4
	end
end

function ()
	uv0()
end()

return slot0
