module("modules.logic.versionactivity2_7.common.VersionActivity2_7CanJumpFunc", package.seeall)

slot0 = class("VersionActivity2_7CanJumpFunc")

function slot0.canJumpTo12003(slot0, slot1)
	slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_7Enum.ActivityId.EnterView)

	if slot2 ~= ActivityEnum.ActivityStatus.Normal then
		return false, slot3, slot4
	end

	slot6, slot7, slot8 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_7Enum.ActivityId.Reactivity)

	if slot6 ~= ActivityEnum.ActivityStatus.Normal then
		return false, slot7, slot8
	end

	if slot1[3] then
		if not DungeonConfig.instance:getEpisodeCO(slot9) then
			logError("not found episode : " .. slot9)

			return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
		end

		if ActivityConfig.instance:getActivityDungeonConfig(slot5) and slot11.hardChapterId and slot10.chapterId == slot11.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(slot5) then
			return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, JumpController.DefaultToastParam
		end

		if not DungeonModel.instance:getEpisodeInfo(slot9) then
			return false, ToastEnum.WarmUpGotoOrder, JumpController.DefaultToastParam
		end
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

function slot0.canJumpTo12005(slot0, slot1)
	slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_7Enum.ActivityId.DungeonGraffiti)

	if slot2 ~= ActivityEnum.ActivityStatus.Normal then
		return false, slot3, slot4
	end

	if not VersionActivity2_0DungeonModel.instance:getGraffitiEntranceUnlockState() then
		return false, ToastEnum.GraffitiLock
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

function slot0.canJumpTo12706(slot0, slot1)
	slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_7Enum.ActivityId.EnterView)

	if slot2 ~= ActivityEnum.ActivityStatus.Normal then
		return false, slot3, slot4
	end

	slot6, slot7, slot8 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_7Enum.ActivityId.Dungeon)

	if slot6 ~= ActivityEnum.ActivityStatus.Normal then
		return false, slot7, slot8
	end

	if slot1[3] then
		if not DungeonConfig.instance:getEpisodeCO(slot9) then
			logError("not found episode : " .. slot9)

			return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
		end

		if ActivityConfig.instance:getActivityDungeonConfig(slot5) and slot11.hardChapterId and slot10.chapterId == slot11.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(slot5) then
			return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, JumpController.DefaultToastParam
		end

		if not DungeonModel.instance:getEpisodeInfo(slot9) then
			return false, ToastEnum.WarmUpGotoOrder, JumpController.DefaultToastParam
		end
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

return slot0
