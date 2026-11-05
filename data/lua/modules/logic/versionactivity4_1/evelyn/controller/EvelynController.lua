-- chunkname: @modules/logic/versionactivity4_1/evelyn/controller/EvelynController.lua

module("modules.logic.versionactivity4_1.evelyn.controller.EvelynController", package.seeall)

local EvelynController = class("EvelynController", BaseController)

function EvelynController:onInit()
	return
end

function EvelynController:onInitFinish()
	return
end

function EvelynController:addConstEvents()
	self:addEventCb(DungeonController.instance, DungeonEvent.OnEndDungeonPush, self.onEndDungeonPush, self)
end

function EvelynController:onEndDungeonPush(msg)
	if self._curEpisodeCo and msg.episodeId == self._curEpisodeCo.fightEpisodeId then
		self:finishEpisodeLevel(self._curEpisodeCo.episodeId)
	end
end

function EvelynController:reInit()
	self._curEpisodeCo = nil
end

function EvelynController:getAct220EvelynInfo(cb, cbObj)
	local actId = EvelynModel.instance:getActId()

	Activity220Rpc.instance:sendGetAct220InfoRequest(actId, cb, cbObj)
end

function EvelynController:enterEpisodeLevelView()
	self:getAct220EvelynInfo(self._openEpisodeLevelViewAfterGetInfo, self)
end

function EvelynController:_openEpisodeLevelViewAfterGetInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local curActId = EvelynModel.instance:getActId()
	local activityMo = ActivityModel.instance:getActMO(curActId)

	if activityMo and msg.activityId == curActId then
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

function EvelynController:openEpisodeLevelView()
	ViewMgr.instance:openView(ViewName.EvelynLevelView)
end

function EvelynController:openTaskView()
	local actId = EvelynModel.instance:getActId()

	ViewMgr.instance:openView(ViewName.EvelynTaskView, {
		actId = actId
	})
end

function EvelynController:openPanelView(param)
	ViewMgr.instance:openView(ViewName.EvelynPanelView, param)
end

function EvelynController:clickEpisodeLevel(episodeId, index)
	local actId = EvelynModel.instance:getActId()
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

	RoleActivityController.instance:dispatchEvent(RoleActivityEvent.StoryItemClick, index)
end

function EvelynController:_afterPlayLevelBeforeStory(param)
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

		ViewMgr.instance:openView(ViewName.EvelynGameView, {
			episodeId = cfg.episodeId,
			gameId = cfg.gameId
		})
	else
		self:finishEpisodeLevel(episodeId220)
	end
end

function EvelynController:finishEpisodeLevel(episodeId)
	if not episodeId then
		return
	end

	local actId = EvelynModel.instance:getActId()

	Activity220Controller.instance:onGameFinished(actId, episodeId)
end

EvelynController.instance = EvelynController.New()

return EvelynController
