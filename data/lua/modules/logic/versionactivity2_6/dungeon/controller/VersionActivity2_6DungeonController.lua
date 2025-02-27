module("modules.logic.versionactivity2_6.dungeon.controller.VersionActivity2_6DungeonController", package.seeall)

slot0 = class("VersionActivity2_6DungeonController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openVersionActivityDungeonMapView(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_6Enum.ActivityId.EnterView)

	if slot1 ~= ActivityEnum.ActivityStatus.Normal then
		if slot2 then
			GameFacade.showToast(slot2, slot3)
		end

		return
	end

	slot4, slot5, slot6 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_6Enum.ActivityId.Dungeon)

	if slot4 == ActivityEnum.ActivityStatus.Normal then
		ActivityEnterMgr.instance:enterActivity(VersionActivity2_6Enum.ActivityId.Dungeon)
		ActivityRpc.instance:sendActivityNewStageReadRequest({
			VersionActivity2_6Enum.ActivityId.Dungeon
		})
	end

	if DungeonModel.instance:chapterIsLock(DungeonEnum.ChapterId.Main1_9) then
		DungeonController.instance:enterDungeonView(true, true)
	else
		JumpController.instance:jumpTo("3#" .. tostring(DungeonEnum.ChapterId.Main1_9))
	end
end

function slot0.openTaskView(slot0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, slot0._openTaskViewAfterRpc, slot0)
end

function slot0._openTaskViewAfterRpc(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivity2_6TaskView)
end

function slot0.openStoreView(slot0)
	if not VersionActivityEnterHelper.checkCanOpen(VersionActivity2_6Enum.ActivityId.DungeonStore) then
		return
	end

	Activity107Rpc.instance:sendGet107GoodsInfoRequest(slot1, slot0._openStoreViewAfterRpc, slot0)
end

function slot0._openStoreViewAfterRpc(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivity2_6StoreView)
end

slot0.instance = slot0.New()

return slot0
