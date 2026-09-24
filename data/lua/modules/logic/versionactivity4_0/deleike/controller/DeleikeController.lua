-- chunkname: @modules/logic/versionactivity4_0/deleike/controller/DeleikeController.lua

module("modules.logic.versionactivity4_0.deleike.controller.DeleikeController", package.seeall)

local DeleikeController = class("DeleikeController", BaseController)

function DeleikeController:onInit()
	self:reInit()
end

function DeleikeController:reInit()
	self._curEpisodeCo = nil
end

function DeleikeController:addConstEvents()
	self:addEventCb(DungeonController.instance, DungeonEvent.OnEndDungeonPush, self.onEndDungeonPush, self)
end

function DeleikeController:onEndDungeonPush(msg)
	if self._curEpisodeCo and msg.episodeId == self._curEpisodeCo.fightEpisodeId then
		self:finishEpisodeLevel(self._curEpisodeCo.episodeId)
	end
end

function DeleikeController:onGameFinish()
	if self._curEpisodeCo then
		self:finishEpisodeLevel(self._curEpisodeCo.episodeId)
	end
end

function DeleikeController:enterEpisodeLevelView(actId)
	self.actId = actId

	Activity220Rpc.instance:sendGetAct220InfoRequest(actId, self._openEpisodeLevelViewAfterGetInfo, self)
end

function DeleikeController:_openEpisodeLevelViewAfterGetInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityMo = ActivityModel.instance:getActMO(self.actId)

	if activityMo and msg.activityId == self.actId then
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

function DeleikeController:openEpisodeLevelView()
	ViewMgr.instance:openView(ViewName.DeleikeLevelView)
end

function DeleikeController:openTaskView()
	ViewMgr.instance:openView(ViewName.DeleikeTaskView, {
		actId = self.actId
	})
end

function DeleikeController:clickEpisodeLevel(episodeId)
	local act220MO = Activity220Model.instance:getById(self.actId)
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

function DeleikeController:_afterPlayLevelBeforeStory(param)
	local cfg = param and param.episodeCfg

	if not cfg then
		return
	end

	local episodeId220 = cfg.episodeId

	if cfg.fightEpisodeId ~= 0 then
		self._curEpisodeCo = cfg

		local episodeConfig = DungeonConfig.instance:getEpisodeCO(cfg.fightEpisodeId)

		if not episodeConfig then
			logError("副本表_关卡表不存在关卡配置" .. cfg.fightEpisodeId)

			return
		end

		local chapterId = episodeConfig.chapterId
		local battleId = episodeConfig.battleId

		if chapterId and episodeConfig.id and battleId > 0 then
			DungeonFightController.instance:enterFightByBattleId(chapterId, episodeConfig.id, battleId)
		end
	elseif cfg.gameId ~= 0 then
		self._curEpisodeCo = cfg

		DeleikeGameMgr.instance:startGame(cfg.gameId)
	else
		self:finishEpisodeLevel(episodeId220)
	end
end

function DeleikeController:finishEpisodeLevel(episodeId)
	if not episodeId then
		return
	end

	local actId = self.actId

	Activity220Controller.instance:onGameFinished(actId, episodeId)
end

DeleikeController.instance = DeleikeController.New()

return DeleikeController
