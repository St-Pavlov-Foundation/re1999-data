-- chunkname: @modules/logic/versionactivity4_1/common/VersionActivity4_1CanJumpFunc.lua

module("modules.logic.versionactivity4_1.common.VersionActivity4_1CanJumpFunc", package.seeall)

local VersionActivity4_1CanJumpFunc = class("VersionActivity4_1CanJumpFunc")

function VersionActivity4_1CanJumpFunc:canJumpTo14102(jumpParamArray)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity4_1Enum.ActivityId.EnterView)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	local actId = VersionActivity4_1Enum.ActivityId.Dungeon
	local actStatus, actToastId, actToastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if actStatus ~= ActivityEnum.ActivityStatus.Normal then
		return false, actToastId, actToastParamList
	end

	local episodeId = jumpParamArray[3]

	if episodeId then
		local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

		if not episodeCo then
			logError("not found episode : " .. episodeId)

			return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
		end

		local activityDungeonConfig = ActivityConfig.instance:getActivityDungeonConfig(actId)

		if activityDungeonConfig and activityDungeonConfig.hardChapterId and episodeCo.chapterId == activityDungeonConfig.hardChapterId and not VersionActivityDungeonBaseController.instance:isOpenActivityHardDungeonChapter(actId) then
			return false, ToastEnum.ActivityHardDugeonLockedWithOpenTime, JumpController.DefaultToastParam
		end

		local episodeInfo = DungeonModel.instance:getEpisodeInfo(episodeId)

		if not episodeInfo then
			return false, ToastEnum.WarmUpGotoOrder, JumpController.DefaultToastParam
		end
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

function VersionActivity4_1CanJumpFunc:canJumpTo14104(jumpParamArray)
	local status, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity4_1Enum.ActivityId.EnterView)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		return false, toastId, toastParamList
	end

	local dungeonStatus, dungeonToastId, dungeonToastParamList = ActivityHelper.getActivityStatusAndToast(VersionActivity4_1Enum.ActivityId.Dungeon)

	if dungeonStatus ~= ActivityEnum.ActivityStatus.Normal then
		return false, dungeonToastId, dungeonToastParamList
	end

	local actId = Act248Model.instance:getActId()
	local actStatus, actToastId, actToastParamList = ActivityHelper.getActivityStatusAndToast(actId)

	if actStatus ~= ActivityEnum.ActivityStatus.Normal then
		return false, actToastId, actToastParamList
	end

	if not Act248Model.instance:isUnlockAct248() then
		local normalEpisodeId = Act248Model.instance:getNormalEpisodeId()
		local episodeDisplay = DungeonConfig.instance:getEpisodeDisplay(normalEpisodeId)
		local actCo = ActivityConfig.instance:getActivityCo(VersionActivity4_1Enum.ActivityId.Dungeon)

		return false, ToastEnum.ActivityDungeon1, {
			actCo.name,
			episodeDisplay
		}
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

return VersionActivity4_1CanJumpFunc
