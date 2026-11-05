-- chunkname: @modules/logic/versionactivity4_1/peishita/controller/PeiShiTaController.lua

module("modules.logic.versionactivity4_1.peishita.controller.PeiShiTaController", package.seeall)

local PeiShiTaController = class("PeiShiTaController", BaseController)

function PeiShiTaController:onInit()
	self._curEpisodeCo = nil
end

function PeiShiTaController:reInit()
	self:onInit()
end

function PeiShiTaController:addConstEvents()
	self:addEventCb(DungeonController.instance, DungeonEvent.OnEndDungeonPush, self.onEndDungeonPush, self)
end

function PeiShiTaController:getActId()
	return VersionActivity4_1Enum.ActivityId.PeiShiTa
end

function PeiShiTaController:onEndDungeonPush(msg)
	local actId = self:getActId()
	local characterCo = DungeonConfig.instance:getChapterCO(msg.chapterId)

	if characterCo and msg.star > 0 and characterCo.actId == actId then
		self.recordEpisodeId = Activity220Config.instance:get220EpisodeIdByFightEpisodeId(actId, msg.episodeId)
	end
end

function PeiShiTaController:onGameFinish(isSuccess)
	if isSuccess then
		if self._curEpisodeCo then
			self:finishEpisodeLevel(self._curEpisodeCo.episodeId)

			local storyClear = self._curEpisodeCo and self._curEpisodeCo.storyClear
			local notStoryClear = not storyClear or storyClear == 0

			if notStoryClear then
				ViewMgr.instance:closeView(ViewName.PeiShiTaGameView)
			end
		end
	else
		ViewMgr.instance:closeView(ViewName.PeiShiTaGameView)
	end
end

function PeiShiTaController:enterEpisodeLevelView()
	local actId = self:getActId()

	Activity220Rpc.instance:sendGetAct220InfoRequest(actId, self._openEpisodeLevelViewAfterGetInfo, self)
end

function PeiShiTaController:_openEpisodeLevelViewAfterGetInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local actId = self:getActId()
	local activityMo = ActivityModel.instance:getActMO(actId)

	if activityMo and msg.activityId == actId then
		local storyId = activityMo.config and activityMo.config.storyId

		if storyId and storyId > 0 and not StoryModel.instance:isStoryFinished(storyId) then
			local storyParam = {}

			storyParam.mark = true

			StoryController.instance:playStory(storyId, storyParam, self.openEpisodeLevelView, self)
		else
			self:openEpisodeLevelView()
		end
	end
end

function PeiShiTaController:openEpisodeLevelView()
	ViewMgr.instance:openView(ViewName.PeiShiTaLevelView)
end

function PeiShiTaController:clickEpisodeLevel(episodeId)
	local actId = self:getActId()
	local act220MO = Activity220Model.instance:getById(actId)
	local episodeMO = act220MO and act220MO:getEpisodeInfo(episodeId)

	if not episodeMO then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	local episodeCfg = episodeMO.config
	local storyBefore = episodeCfg.storyBefore
	local param = {
		episodeCfg = episodeCfg
	}

	if storyBefore and storyBefore > 0 then
		local storyParam = {}

		storyParam.mark = true

		StoryController.instance:playStory(storyBefore, storyParam, self._afterPlayLevelBeforeStory, self, param)
	else
		self:_afterPlayLevelBeforeStory(param)
	end
end

function PeiShiTaController:_afterPlayLevelBeforeStory(param)
	local cfg = param and param.episodeCfg

	if not cfg then
		return
	end

	self._curEpisodeCo = cfg

	local episodeId220 = cfg.episodeId

	if cfg.fightEpisodeId ~= 0 then
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(cfg.fightEpisodeId)

		if not episodeConfig then
			logError("副本表_关卡表不存在关卡配置" .. cfg.fightEpisodeId)

			return
		end

		local chapterId = episodeConfig.chapterId
		local battleId = episodeConfig.battleId

		if chapterId and episodeConfig.id and battleId > 0 then
			DungeonFightController.instance:enterFightByBattleId(chapterId, episodeConfig.id, battleId)

			local fightParam = FightModel.instance:getFightParam()

			if fightParam then
				fightParam:setShowSettlement(false)
			end
		end
	elseif cfg.gameId ~= 0 then
		self:startGame(cfg.gameId)
	else
		self:finishEpisodeLevel(episodeId220)
	end
end

function PeiShiTaController:finishEpisodeLevel(episodeId)
	if not episodeId then
		return
	end

	local actId = self:getActId()

	Activity220Controller.instance:onGameFinished(actId, episodeId)
end

function PeiShiTaController:checkLastFight()
	if self.recordEpisodeId then
		self:finishEpisodeLevel(self.recordEpisodeId)

		self.recordEpisodeId = nil
	end
end

function PeiShiTaController:startGame(gameId)
	self.startTime = ServerTime.now()
	self.totalRevertTimes = 0
	self.totalResetTimes = 0

	local actId = self:getActId()

	PeiShiTaGameController.instance:startGame(actId, gameId)
	self:dispatchEvent(PeiShiTaEvent.ZTriggerStartGame, gameId)
end

function PeiShiTaController:reportGameEnd(result)
	local useTime = ServerTime.now() - self.startTime
	local episodeId = self._curEpisodeCo and self._curEpisodeCo.episodeId

	StatController.instance:track(StatEnum.EventName.PeiShiTaGame, {
		[StatEnum.EventProperties.EpisodeId] = tostring(episodeId),
		[StatEnum.EventProperties.UseTime] = useTime,
		[StatEnum.EventProperties.OperationType] = StatEnum.Result2Cn[result]
	})

	self.startTime = ServerTime.now()
end

PeiShiTaController.instance = PeiShiTaController.New()

return PeiShiTaController
