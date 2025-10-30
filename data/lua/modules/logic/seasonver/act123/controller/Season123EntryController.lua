﻿-- chunkname: @modules/logic/seasonver/act123/controller/Season123EntryController.lua

module("modules.logic.seasonver.act123.controller.Season123EntryController", package.seeall)

local Season123EntryController = class("Season123EntryController", BaseController)

function Season123EntryController:onOpenView(actId)
	Season123EntryModel.instance:init(actId)
	Activity123Rpc.instance:sendGet123InfosRequest(actId)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Season123
	})
end

function Season123EntryController:onCloseView()
	Season123EntryModel.instance:release()
end

function Season123EntryController:openStage(stage)
	local actId = Season123EntryModel.instance.activityId
	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return
	end

	local stageMO = seasonMO:getStageMO(stage)

	if not stageMO then
		return
	end

	local rs, reason, value = Season123ProgressUtils.isStageUnlock(actId, stage)

	if not rs then
		local stageCO = Season123Config.instance:getStageCo(actId, stage)

		GameFacade.showToast(ToastEnum.SeasonStageLockTip, stageCO.name)

		return
	end

	if stageMO.episodeMap[1] and not stageMO.episodeMap[1]:isFinished() and stage ~= seasonMO.stage then
		if seasonMO.stage ~= 0 and stage ~= seasonMO.stage and not Season123ProgressUtils.checkStageIsFinish(actId, seasonMO.stage) then
			GameFacade.showMessageBox(MessageBoxIdDefine.Season123WarningCleanStage, MsgBoxEnum.BoxType.Yes_No, self.cleanAndStartPickHero, nil, nil, self)
		else
			self:startPickHero()
		end
	else
		return true
	end
end

function Season123EntryController:startPickHero()
	ViewMgr.instance:openView(Season123Controller.instance:getPickHeroEntryViewName(), {
		actId = Season123EntryModel.instance.activityId,
		stage = Season123EntryModel.instance:getCurrentStage(),
		finishCall = self.handlePickHeroSuccess,
		finishCallObj = self
	})
end

function Season123EntryController:cleanAndStartPickHero()
	local seasonMO = Season123Model.instance:getActInfo(Season123EntryModel.instance.activityId)

	if seasonMO then
		Activity123Rpc.instance:sendAct123EndStageRequest(Season123EntryModel.instance.activityId, seasonMO.stage, self.onReceiveReset, self)
	end
end

function Season123EntryController:onReceiveReset(cmd, resultCode, msg)
	if resultCode == 0 then
		GameFacade.showToast(ToastEnum.WeekwalkResetLayer)
	end

	Activity123Rpc.instance:sendGet123InfosRequest(Season123EntryModel.instance.activityId, self.startPickHero, self)
end

function Season123EntryController:openStageRecords(stage)
	local actId = Season123EntryModel.instance.activityId

	Season123RecordModel.instance:setServerDataVerifiableId(actId, stage)
	Activity123Rpc.instance:sendGetAct123StageRecordRequest(actId, stage, self._realOpenStageRecords, self)
end

function Season123EntryController:processJumpParam(viewParam)
	if viewParam.jumpId == Activity123Enum.JumpId.Market or viewParam.jumpId == Activity123Enum.JumpId.MarketNoResult then
		local battleContext = Season123Model.instance:getBattleContext()

		Season123Controller.instance:dispatchEvent(Season123Event.OtherViewAutoOpened)
		ViewMgr.instance:openView(Season123Controller.instance:getEpisodeListViewName(), {
			actId = Season123EntryModel.instance.activityId,
			stage = battleContext.stage,
			jumpId = viewParam.jumpId,
			jumpParam = viewParam.jumpParam
		})
	elseif viewParam.jumpId == Activity123Enum.JumpId.Retail then
		Season123Controller.instance:dispatchEvent(Season123Event.OtherViewAutoOpened)
		Season123Controller.instance:openSeasonRetail({
			actId = Season123EntryModel.instance.activityId
		})
	elseif viewParam.jumpId == Activity123Enum.JumpId.ForStage then
		self:goToStage(viewParam.jumpParam.stage)
	elseif viewParam.jumpId == Activity123Enum.JumpId.MarketStageFinish then
		self:goToStage(viewParam.jumpParam.stage)
		Season123Controller.instance:dispatchEvent(Season123Event.OtherViewAutoOpened)
		ViewMgr.instance:openView(Season123Controller.instance:getStageFinishViewName(), {
			actId = Season123EntryModel.instance.activityId,
			stage = viewParam.jumpParam.stage
		})
	end
end

function Season123EntryController:_realOpenStageRecords()
	local season123RecordViewName = Season123Controller.instance:getRecordWindowViewName()

	ViewMgr.instance:openView(season123RecordViewName)
end

function Season123EntryController:switchStage(isNext)
	local stageId

	if isNext then
		stageId = Season123EntryModel.instance:getNextStage()
	else
		stageId = Season123EntryModel.instance:getPrevStage()
	end

	if stageId then
		Season123Controller.instance:dispatchEvent(Season123Event.LocateToStage, {
			actId = Season123EntryModel.instance.activityId,
			stageId = stageId
		})
	end
end

function Season123EntryController:goToStage(stage)
	Season123EntryModel.instance:setCurrentStage(stage)
	Season123EntryController.instance:dispatchEvent(Season123Event.EntryStageChanged)
end

function Season123EntryController:handlePickHeroSuccess()
	local actId = Season123EntryModel.instance.activityId

	Activity123Rpc.instance:sendGet123InfosRequest(actId, self.handleEnterStage, self)
end

function Season123EntryController:handleEnterStage()
	ViewMgr.instance:openView(Season123Controller.instance:getStageLoadingViewName(), {
		actId = Season123EntryModel.instance.activityId,
		stage = Season123EntryModel.instance:getCurrentStage()
	})
end

function Season123EntryController:enterTrailFightScene()
	local trailCO = Season123EntryModel.instance:getTrialCO()

	if trailCO then
		self:startBattle(Season123EntryModel.instance.activityId, trailCO.episodeId)
	end
end

function Season123EntryController:startBattle(actId, episodeId)
	logNormal(string.format("startBattle with actId = %s, episodeId = %s", actId, episodeId))

	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	Season123Model.instance:setBattleContext(actId, nil, nil, episodeId)
	DungeonFightController.instance:enterSeasonFight(episodeCo.chapterId, episodeId)
end

Season123EntryController.instance = Season123EntryController.New()

LuaEventSystem.addEventMechanism(Season123EntryController.instance)

return Season123EntryController
