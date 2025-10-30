﻿-- chunkname: @modules/logic/versionactivity2_6/common/EnterActivityViewOnExitFightSceneHelper2_6.lua

module("modules.logic.versionactivity2_6.common.EnterActivityViewOnExitFightSceneHelper2_6", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12210(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight12210, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12606(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_6EnterView)
		VersionActivity2_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_6Enum.ActivityId.DiceHero, true)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12605(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_6EnterView)
		VersionActivity2_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity2_6Enum.ActivityId.Xugouji, true)
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12617(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = stage,
				layer = layer
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12618(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight12618, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight12618(tarClass, param)
	local episodeId = param.episodeId
	local exitFightGroup = param.exitFightGroup

	if not episodeId then
		return
	end

	local context = Season166Model.instance:getBattleContext()

	if not context then
		return false
	end

	local trainId = context.trainId
	local baseId = context.baseId
	local actId = context.actId
	local fightResult = EnterActivityViewOnExitFightSceneHelper.recordMO and EnterActivityViewOnExitFightSceneHelper.recordMO.fightResult
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local episodeType = episodeCo and episodeCo.type
	local jumpId, jumpParam

	if episodeCo then
		if not fightResult or fightResult == -1 or fightResult == 0 then
			if episodeType == DungeonEnum.EpisodeType.Season166Base then
				jumpId = Season166Enum.JumpId.BaseSpotEpisode
				jumpParam = {
					baseId = baseId
				}
			elseif episodeType == DungeonEnum.EpisodeType.Season166Train then
				jumpId = Season166Enum.JumpId.TrainEpisode
				jumpParam = {
					trainId = trainId
				}
			elseif episodeType == DungeonEnum.EpisodeType.Season166Teach then
				jumpId = Season166Enum.JumpId.TeachView
			end
		elseif fightResult == 1 then
			if episodeType == DungeonEnum.EpisodeType.Season166Base then
				jumpId = Season166Enum.JumpId.MainView
			elseif episodeType == DungeonEnum.EpisodeType.Season166Train then
				jumpId = Season166Enum.JumpId.TrainView
			elseif episodeType == DungeonEnum.EpisodeType.Season166Teach then
				jumpId = Season166Enum.JumpId.TeachView
			end
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", episodeId))
	end

	VersionActivity2_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Season166Controller.instance:openSeasonView({
			actId = actId,
			jumpId = jumpId,
			jumpParam = jumpParam
		})
	end, nil, VersionActivity2_6Enum.ActivityId.Season)
end

return EnterActivityViewOnExitFightSceneHelper
