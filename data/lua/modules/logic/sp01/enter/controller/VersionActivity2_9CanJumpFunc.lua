module("modules.logic.sp01.enter.controller.VersionActivity2_9CanJumpFunc", package.seeall)

local var_0_0 = class("VersionActivity2_9CanJumpFunc")

function var_0_0.canJumpTo130502(arg_1_0, arg_1_1)
	local var_1_0, var_1_1, var_1_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_9Enum.ActivityId.EnterView)

	if var_1_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_1_1, var_1_2
	end

	local var_1_3 = VersionActivity2_9Enum.ActivityId.Dungeon
	local var_1_4, var_1_5, var_1_6 = ActivityHelper.getActivityStatusAndToast(var_1_3)

	if var_1_4 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_1_5, var_1_6
	end

	local var_1_7 = arg_1_1[3]

	if var_1_7 then
		local var_1_8 = DungeonConfig.instance:getEpisodeCO(var_1_7)

		if not var_1_8 then
			logError("not found episode : " .. var_1_7)

			return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
		end

		local var_1_9 = ActivityConfig.instance:getActivityDungeonConfig(var_1_3)

		if var_1_9 and var_1_9.hardChapterId and var_1_8.chapterId == var_1_9.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(var_1_3) then
			return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, JumpController.DefaultToastParam
		end

		if not DungeonModel.instance:getEpisodeInfo(var_1_7) then
			return false, ToastEnum.WarmUpGotoOrder, JumpController.DefaultToastParam
		end
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

function var_0_0.canJumpTo130507(arg_2_0, arg_2_1)
	local var_2_0, var_2_1, var_2_2 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_9Enum.ActivityId.EnterView)

	if var_2_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_2_1, var_2_2
	end

	local var_2_3 = VersionActivity2_9Enum.ActivityId.Dungeon2
	local var_2_4, var_2_5, var_2_6 = ActivityHelper.getActivityStatusAndToast(var_2_3)

	if var_2_4 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_2_5, var_2_6
	end

	local var_2_7 = arg_2_1[3]

	if var_2_7 then
		local var_2_8 = DungeonConfig.instance:getEpisodeCO(var_2_7)

		if not var_2_8 then
			logError("not found episode : " .. var_2_7)

			return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
		end

		local var_2_9 = ActivityConfig.instance:getActivityDungeonConfig(var_2_3)

		if var_2_9 and var_2_9.hardChapterId and var_2_8.chapterId == var_2_9.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(var_2_3) then
			return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, JumpController.DefaultToastParam
		end

		if not DungeonModel.instance:getEpisodeInfo(var_2_7) then
			return false, ToastEnum.WarmUpGotoOrder, JumpController.DefaultToastParam
		end
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

return var_0_0
