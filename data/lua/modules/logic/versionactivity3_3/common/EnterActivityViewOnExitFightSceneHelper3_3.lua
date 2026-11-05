-- chunkname: @modules/logic/versionactivity3_3/common/EnterActivityViewOnExitFightSceneHelper3_3.lua

module("modules.logic.versionactivity3_3.common.EnterActivityViewOnExitFightSceneHelper3_3", package.seeall)

local EnterActivityViewOnExitFightSceneHelper = EnterActivityViewOnExitFightSceneHelper

local function _openPermanent_EnterView(viewParam)
	PermanentController.instance:jump2Activity(VersionActivity3_3Enum.ActivityId.EnterView, viewParam)
end

function EnterActivityViewOnExitFightSceneHelper.activate()
	return
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13315(forceStarting, exitFightGroup)
	local episodeId = DungeonModel.instance.curSendEpisodeId
	local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V3a2_BossRush_LevelDetailView)
		VersionActivity3_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openV3a2MainView({
				isOpenLevelDetail = true,
				stage = stage,
				layer = layer
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13310(forceStarting, exitFightGroup)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		local actId = VersionActivity3_3Enum.ActivityId.Marsha

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, RoleActivityEnum.LevelView[actId])
		_openPermanent_EnterView()
		MarshaController.instance:enterLevelView()
	end)
end

function EnterActivityViewOnExitFightSceneHelper.enterActivity13313(forceStarting, exitFightGroup)
	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		local actId = VersionActivity3_3Enum.ActivityId.Igor

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, RoleActivityEnum.LevelView[actId])
		_openPermanent_EnterView()
		IgorController.instance:enterEpisodeLevelView(actId)
	end)
end

function EnterActivityViewOnExitFightSceneHelper._enterActivity13306(cls, param)
	local episodeId = param.episodeId
	local exitFightGroup = param.exitFightGroup

	if not episodeId then
		return
	end

	local layer = Activity104Model.instance:getBattleFinishLayer()
	local actId = Activity104Model.instance:getCurSeasonId()
	local fightResult = EnterActivityViewOnExitFightSceneHelper.recordMO and EnterActivityViewOnExitFightSceneHelper.recordMO.fightResult
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local episodeType = episodeCo and episodeCo.type
	local levelUpStage = Activity104Model.instance:canPlayStageLevelup(fightResult, episodeType, exitFightGroup, actId, layer)
	local jumpId, jumpParam
	local isFirstPassSeason = Activity104Model.instance:canMarkFightAfterStory(fightResult, episodeType, exitFightGroup, actId, layer)

	if isFirstPassSeason then
		Activity104Rpc.instance:sendMarkEpisodeAfterStoryRequest(actId, layer)
	end

	if episodeCo then
		if not fightResult or fightResult == -1 or fightResult == 0 then
			if episodeType == DungeonEnum.EpisodeType.Season then
				jumpId = Activity104Enum.JumpId.Market
				jumpParam = {
					tarLayer = layer
				}
			elseif episodeType == DungeonEnum.EpisodeType.SeasonRetail then
				jumpId = Activity104Enum.JumpId.Retail
			elseif episodeType == DungeonEnum.EpisodeType.SeasonSpecial then
				jumpId = Activity104Enum.JumpId.Discount
				jumpParam = {
					defaultSelectLayer = layer,
					directOpenLayer = layer
				}
			end
		elseif fightResult == 1 then
			if not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount) then
				if episodeType == DungeonEnum.EpisodeType.Season then
					if not levelUpStage then
						local curLayer = layer + 1
						local next_config = SeasonConfig.instance:getSeasonEpisodeCo(actId, curLayer)

						if next_config then
							jumpId = Activity104Enum.JumpId.Market
							jumpParam = {
								tarLayer = curLayer
							}
						end
					end
				elseif episodeType == DungeonEnum.EpisodeType.SeasonRetail then
					jumpId = Activity104Enum.JumpId.Retail
				elseif episodeType == DungeonEnum.EpisodeType.SeasonSpecial then
					jumpId = Activity104Enum.JumpId.Discount
				end
			end

			if isFirstPassSeason and layer == 1 then
				jumpId = nil
				jumpParam = nil
			end
		elseif episodeType == DungeonEnum.EpisodeType.SeasonSpecial then
			jumpId = Activity104Enum.JumpId.Discount
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", episodeId))
	end

	local openViewName = Activity104Enum.ViewName.MainView
	local waitViewName = SeasonViewHelper.getViewName(actId, openViewName, true)

	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, waitViewName)

	local function openFunc()
		Activity104Controller.instance:openSeasonMainView({
			levelUpStage = levelUpStage,
			jumpId = jumpId,
			jumpParam = jumpParam
		})
	end

	VersionActivity3_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(openFunc, nil, actId, true)
end

return EnterActivityViewOnExitFightSceneHelper
