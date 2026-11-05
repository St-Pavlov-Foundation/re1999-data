-- chunkname: @modules/logic/bossrush/controller/V4a1_BossRushController.lua

module("modules.logic.bossrush.controller.V4a1_BossRushController", package.seeall)

local V4a1_BossRushController = class("V4a1_BossRushController", BaseController)

function V4a1_BossRushController:onInit()
	self:reInit()
end

function V4a1_BossRushController:reInit()
	return
end

function V4a1_BossRushController:openMainView(viewParam, isJustOpen)
	if isJustOpen then
		ViewMgr.instance:openView(ViewName.V4a1_BossRush_MainView, viewParam)

		return
	end

	if not V3a9_BossRushModel.instance:isActOnLine() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.BossRushEnter
	})
	ViewMgr.instance:openTabView(ViewName.V4a1_BossRush_MainView, viewParam)
end

function V4a1_BossRushController:sendRequestActInfos(callback, cbObj)
	local seasonMos = V4a1_BossRushModel.instance:getSeasonMos()
	local curId = BossRushConfig.instance:getActivityId()
	local actIds = {
		curId
	}

	if seasonMos then
		for season in pairs(seasonMos) do
			local actId = V3a9_BossRushModel.instance:getActIdBySeason(season)

			if not LuaUtil.tableContains(actIds, actId) then
				table.insert(actIds, actId)
			end
		end
	end

	if actIds and #actIds > 0 then
		BossRushRpc.instance:sendGet128ActIdsInfosRequest(actIds, callback, cbObj)
	end
end

function V4a1_BossRushController:openLevelDetailView(viewParam, isOpenMain)
	local stage = viewParam.stage
	local actId = viewParam.actId
	local stageMo = V3a9_BossRushModel.instance:getStageMo(actId, stage)

	if not stageMo or not stageMo:isOpen() then
		GameFacade.showToast(ToastEnum.V1a4_BossRushBossLockTip)

		return
	end

	if isOpenMain then
		self:openMainView(nil, true)
	end

	V3a9_BossRushModel.instance:setEnterActStage(actId, stage)
	ViewMgr.instance:openView(ViewName.V4a1_BossRush_LevelDetailView, stageMo)
end

function V4a1_BossRushController:openLevelReviewView(handbookMo)
	local stage = handbookMo.stage
	local actId = handbookMo.actId
	local stageMo = V3a9_BossRushModel.instance:getStageMo(actId, stage)

	V3a9_BossRushModel.instance:setEnterActStage(actId, stage)
	ViewMgr.instance:openView(ViewName.V4a1_BossRush_LevelReviewView, stageMo)
end

function V4a1_BossRushController:openRankView(season)
	local param = {
		season = season
	}

	if season == 1 then
		ViewMgr.instance:openView(ViewName.V3a2_BossRush_RankView, param)
	else
		ViewMgr.instance:openView(ViewName.V4a1_BossRush_RankView, param)
	end
end

function V4a1_BossRushController:openHankBookView(handbookMo, isEnterLevelReviewView)
	local actId = BossRushConfig.instance:getActivityId()

	BossRushRpc.instance:sendGetGalleryInfosRequest(actId, function()
		if not handbookMo then
			handbookMo = V3a2_BossRush_HandBookListModel.instance:getFirstCanClaimHandBookMo()
		end

		local param = {
			handbookMo = handbookMo,
			isEnterLevelReviewView = isEnterLevelReviewView
		}

		ViewMgr.instance:openView(ViewName.V4a1_BossRush_HandBookView, param)
	end)
end

function V4a1_BossRushController:enterEpisode(episodeId)
	local dungeonEpisodeCO = episodeId and lua_episode.configDict[episodeId]

	if not dungeonEpisodeCO then
		return
	end

	local chapterId = dungeonEpisodeCO.chapterId
	local battleId = dungeonEpisodeCO.battleId
	local fightParam = FightController.instance:setFightParamByBattleId(battleId)

	fightParam.episodeId = episodeId
	fightParam.chapterId = chapterId
	FightResultModel.instance.episodeId = episodeId

	DungeonModel.instance:SetSendChapterEpisodeId(chapterId, episodeId)
	fightParam:setPreload()
	FightController.instance:enterFightScene()
end

function V4a1_BossRushController:openSkillBuffView(score, episodeId, monsterId)
	local param = {
		score = score,
		episodeId = episodeId,
		monsterId = monsterId
	}

	ViewMgr.instance:openView(ViewName.V4a1_BossRush_SkillBuffView, param)
end

function V4a1_BossRushController:checkExitFight(chapterId, episodeId)
	local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)
	local actId = chapterCo and chapterCo.actId or 0

	if actId and actId == BossRushConfig.instance.getActivityId() then
		return true
	end
end

function V4a1_BossRushController:onEnterActivityBossRush(episodeId, forceStarting, exitFightGroup)
	local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(episodeId)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(forceStarting)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V3a2_BossRush_LevelDetailView)
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openV3a2MainView({
				isOpenLevelDetail = true,
				stage = stage,
				layer = layer
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

V4a1_BossRushController.instance = V4a1_BossRushController.New()

return V4a1_BossRushController
