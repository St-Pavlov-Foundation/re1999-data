-- chunkname: @modules/common/activity/EnterActivityViewOnExitFightSceneHelper.lua

module("modules.common.activity.EnterActivityViewOnExitFightSceneHelper", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = class("EnterActivityViewOnExitFightSceneHelper")

function EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight()
	EnterActivityViewOnExitFightSceneHelper.recordMO = FightModel.instance:getRecordMO()

	local chapterId = DungeonModel.instance.curSendChapterId

	return EnterActivityViewOnExitFightSceneHelper.checkIsActivityFight(chapterId)
end

function EnterActivityViewOnExitFightSceneHelper.checkIsActivityFight(chapterId)
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)
	local actId = chapterCo and chapterCo.actId or 0

	if BossRushController.instance:isInBossRushFight() then
		return true
	end

	local activityConfig = ActivityConfig.instance:getActivityCo(actId, true)

	if not activityConfig then
		return
	end

	if activityConfig.typeId == ActivityEnum.ActivityTypeID.Season123 then
		return true
	end

	if AbyssConfig.instance:getActivityId() == actId then
		return EnterActivityViewOnExitFightSceneHelper.enterAbyss()
	end

	return EnterActivityViewOnExitFightSceneHelper["enterActivity" .. actId]
end

function EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(forceStarting, exitFightGroup)
	local chapterId = DungeonModel.instance.curSendChapterId
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)
	local actId = chapterCo and chapterCo.actId or 0

	EnterActivityViewOnExitFightSceneHelper.enterActivity(actId, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity(actId, forceStarting, exitFightGroup)
	if BossRushController.instance:isInBossRushFight() then
		EnterActivityViewOnExitFightSceneHelper.enterActivityBossRush(forceStarting, exitFightGroup)

		return
	end

	local status = ActivityHelper.getActivityStatus(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		DungeonModel.instance.curSendEpisodeId = nil

		MainController.instance:enterMainScene(forceStarting)

		return
	end

	if actId == 0 then
		return
	end

	local activityConfig = ActivityConfig.instance:getActivityCo(actId)

	if not activityConfig then
		return
	end

	local typeId = activityConfig.typeId
	local enterFunc = EnterActivityViewOnExitFightSceneHelper["enterActivity" .. actId]

	if not enterFunc and typeId == ActivityEnum.ActivityTypeID.Season123 then
		enterFunc = EnterActivityViewOnExitFightSceneHelper.enterActivitySeason123
	end

	if not exitFightGroup then
		local checkFunc = EnterActivityViewOnExitFightSceneHelper["checkFightAfterStory" .. actId]

		if not checkFunc and typeId == ActivityEnum.ActivityTypeID.Season123 then
			checkFunc = EnterActivityViewOnExitFightSceneHelper.checkFightAfterStorySeason123
		end

		if checkFunc and checkFunc(enterFunc, forceStarting, exitFightGroup) then
			return
		end
	end

	if enterFunc then
		enterFunc(forceStarting, exitFightGroup)
	end
end

function EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(callBack, forceStarting, exitFightGroup)
	local chapterId = DungeonModel.instance.curSendChapterId
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local isReplay = FightController.instance:isReplayMode(episodeId)
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)
	local actId = chapterConfig.actId
	local activityState = ActivityHelper.getActivityStatus(actId)

	if ActivityEnum.ActivityStatus.Normal ~= activityState then
		MainController.instance:enterMainScene(forceStarting)

		return
	end

	local activityConfig = ActivityConfig.instance:getActivityCo(actId)
	local typeId = activityConfig.typeId

	if not exitFightGroup and isReplay then
		local enterFunc = EnterActivityViewOnExitFightSceneHelper["enterFightAgain" .. actId]

		if not enterFunc then
			if typeId == ActivityEnum.ActivityTypeID.Season123 then
				enterFunc = EnterActivityViewOnExitFightSceneHelper.enterFightAgainSeason123
			else
				enterFunc = EnterActivityViewOnExitFightSceneHelper.enterFightAgain
			end
		end

		if enterFunc and enterFunc() then
			return
		end
	end

	DungeonModel.instance.versionActivityChapterType = nil
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)

	local param = {
		episodeId = episodeId,
		episodeCo = episodeCo,
		exitFightGroup = exitFightGroup
	}

	SceneHelper.instance:waitSceneDone(SceneType.Main, callBack, EnterActivityViewOnExitFightSceneHelper, param)
end

function EnterActivityViewOnExitFightSceneHelper.enterFightAgain()
	GameSceneMgr.instance:closeScene(nil, nil, nil, true)

	local chapterId = DungeonModel.instance.curSendChapterId
	local episodeId = DungeonModel.instance.curSendEpisodeId

	DungeonFightController.instance:enterFight(chapterId, episodeId, DungeonModel.instance.curSelectTicketId)
end

function EnterActivityViewOnExitFightSceneHelper.activeExtend()
	ActivityHelper.activateClass("EnterActivityViewOnExitFightSceneHelper%d_%d", 1, 1)

	local _ = _G.EnterActivityViewOnExitFightSceneHelper2_9
	local spVersion = 2

	while true do
		local cls = _G[string.format("EnterActivityViewOnExitFightSceneHelper_Sp%02d", spVersion)]

		if not cls then
			break
		else
			spVersion = spVersion + 1
		end
	end
end

function EnterActivityViewOnExitFightSceneHelper.enterActivityBossRush(forceStarting, exitFightGroup)
	local stage, layer, actId = BossRushModel.instance:getBattleStageAndLayer()

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		local isCurSeason = V4a1_BossRushModel.instance:isCurSeason(actId)

		if isCurSeason then
			local param = {
				isOpenLevelDetail = true,
				stage = stage,
				layer = layer,
				actId = actId
			}

			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V4a1_BossRush_LevelDetailView)

			local function cb()
				V4a1_BossRushController.instance:openMainView(param)
			end

			VersionActivityFixedEnterController.instance:openVersionActivityEnterViewIfNotOpened(cb, nil, BossRushConfig.instance:getActivityId())
		else
			local handbookMo = V4a1_BossRushModel.instance:getHandBookMoByActStage(actId, stage)
			local param = {
				handbookMo = handbookMo,
				stage = stage,
				layer = layer,
				actId = actId
			}

			if handbookMo then
				GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V4a1_BossRush_LevelReviewView)

				local function cb()
					V4a1_BossRushController.instance:openMainView(param)
				end

				VersionActivityFixedEnterController.instance:openVersionActivityEnterViewIfNotOpened(cb, nil, BossRushConfig.instance:getActivityId())
			end
		end
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterAbyss(forceStarting, exitFightGroup)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)

	local actId = AbyssConfig.instance:getActivityId()

	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.AbyssMainView)
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			AbyssController.instance:openMainView(actId, true)
		end, nil, actId, true)
	end)
end

return EnterActivityViewOnExitFightSceneHelper
