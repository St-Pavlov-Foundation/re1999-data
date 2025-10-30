﻿-- chunkname: @modules/logic/versionactivity2_4/common/EnterActivityViewOnExitFightSceneHelper2_4.lua

module("modules.logic.versionactivity2_4.common.EnterActivityViewOnExitFightSceneHelper2_4", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

local function _openPermanent_EnterView(viewParam)
	PermanentController.instance:jump2Activity(VersionActivity2_4Enum.ActivityId.EnterView, viewParam)
end

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12404(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		local actId = VersionActivity2_4Enum.ActivityId.Pinball

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, RoleActivityEnum.LevelView[actId])
		_openPermanent_EnterView()
		RoleActivityController.instance:openLevelView({
			needShowFight = true,
			actId = actId
		})
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12405(forceStarting, exitFightGroup)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		local actId = VersionActivity2_4Enum.ActivityId.MusicGame

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, RoleActivityEnum.LevelView[actId])
		_openPermanent_EnterView()
		RoleActivityController.instance:openLevelView({
			needShowFight = true,
			actId = actId
		})
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12400(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight12400, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivityDungeonAterFight12400(tarClass, param)
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

	VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Season166Controller.instance:openSeasonView({
			actId = actId,
			jumpId = jumpId,
			jumpParam = jumpParam
		})
	end, nil, VersionActivity2_4Enum.ActivityId.Season)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12402(forceStarting, exitFightGroup)
	EnterActivityViewOnExitFightSceneHelper.enterVersionActivityDungeonCommon(EnterActivityViewOnExitFightSceneHelper._enterActivity12402, forceStarting, exitFightGroup)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivity12402(cls, param)
	local episodeId = param.episodeId
	local episodeCo = param.episodeCo

	if not episodeCo then
		return
	end

	if EnterActivityViewOnExitFightSceneHelper.sequence then
		EnterActivityViewOnExitFightSceneHelper.sequence:destroy()

		EnterActivityViewOnExitFightSceneHelper.sequence = nil
	end

	local needLoadMapLevel = false

	if DungeonModel.instance.curSendEpisodePass then
		needLoadMapLevel = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_4DungeonMapView)
	else
		needLoadMapLevel = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_4DungeonMapLevelView)
	end

	local sequence = FlowSequence.New()

	sequence:addWork(OpenViewWork.New({
		openFunction = _openPermanent_EnterView,
		openFunctionObj = VersionActivityFixedHelper.getVersionActivityEnterController().instance,
		waitOpenViewName = VersionActivityFixedHelper.getVersionActivityEnterViewName()
	}))
	sequence:registerDoneListener(function()
		if needLoadMapLevel then
			VersionActivity2_4DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_4DungeonMapLevelView, {
					episodeId = episodeId
				})
			end, nil)
		else
			VersionActivity2_4DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId)
		end
	end)
	sequence:start()

	EnterActivityViewOnExitFightSceneHelper.sequence = sequence
end

function EnterActivityViewOnExitFightSceneHelper.open3_1ReactivityEnterView()
	VersionActivityFixedHelper.getVersionActivityEnterController():directOpenVersionActivityEnterView(VersionActivity3_1Enum.ActivityId.Reactivity)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity12410(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = stage,
				layer = layer
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

return EnterActivityViewOnExitFightSceneHelper
