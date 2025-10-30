﻿-- chunkname: @modules/logic/survival/controller/SurvivalController.lua

module("modules.logic.survival.controller.SurvivalController", package.seeall)

local SurvivalController = class("SurvivalController", BaseController)

function SurvivalController:reInit()
	if self._settleFlow then
		self._settleFlow:destroy()

		self._settleFlow = nil
	end

	TaskDispatcher.cancelTask(self.onDelayPopupFinishEvent, self)
end

function SurvivalController:addConstEvents()
	OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, self._onGetOpenInfoSuccess, self)
	MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, self._onGetOpenInfoSuccess, self)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, self._newFuncUnlock, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._checkActivityInfo, self)

	if isDebugBuild then
		GMController.instance:registerCallback(GMController.Event.OnRecvGMMsg, self._onRecvGMMsg, self)
	end
end

function SurvivalController:_onGetOpenInfoSuccess()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Survival) then
		self:_getInfo()
	end
end

function SurvivalController:_newFuncUnlock(newIds)
	for i, id in ipairs(newIds) do
		if id == OpenEnum.UnlockFunc.Survival then
			self:_getInfo()

			break
		end
	end
end

function SurvivalController:_checkActivityInfo(activityId)
	if not activityId or activityId == VersionActivity3_1Enum.ActivityId.Survival then
		self:_getInfo()
	end
end

function SurvivalController:_getInfo()
	if not ActivityHelper.isOpen(VersionActivity3_1Enum.ActivityId.Survival) then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Survival) then
		return
	end

	SurvivalOutSideRpc.instance:sendSurvivalOutSideGetInfo()
end

function SurvivalController:openSurvivalView(isRpc)
	if isRpc then
		SurvivalOutSideRpc.instance:sendSurvivalOutSideGetInfo(self._openSurvivalView, self)
	else
		self:_openSurvivalView()
	end
end

function SurvivalController:_openSurvivalView()
	ViewMgr.instance:openView(ViewName.SurvivalView)
end

function SurvivalController:enterSurvivalMap(initGroupMo)
	SurvivalInteriorRpc.instance:sendEnterSurvival(initGroupMo, self._onEnterSurvival, self)
end

function SurvivalController:_onRecvGMMsg()
	SurvivalMapHelper.instance:tryStartFlow("")
end

function SurvivalController:_onEnterSurvival(cmd, resultCode, msg)
	if resultCode == 0 then
		if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Survival then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.SurvivalLoadingView)
			GameSceneMgr.instance:startScene(SceneType.Survival, 280001, 280001, true, true)
		else
			logError("重复进入探索场景")
		end
	elseif GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		self:exitMap()
	end
end

function SurvivalController:enterShelterMap(isExitFight)
	self._isExitFight = isExitFight

	local info = SurvivalModel.instance:getSurvivalSettleInfo()

	if info ~= nil and self._isExitFight then
		self:enterSurvivalShelterScene()

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalGetWeekInfo(self._onEnterShelter, self)
end

function SurvivalController:_onEnterShelter(cmd, resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo.inSurvival then
			self:enterSurvivalMap()
		else
			self:enterSurvivalShelterScene()
		end
	end
end

function SurvivalController:enterSurvivalShelterScene()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local fight = weekInfo.intrudeBox.fight
	local info = SurvivalModel.instance:getSurvivalSettleInfo()

	if self._isExitFight and fight and fight:isFighting() and not info then
		SurvivalModel.instance:setBossFightLastIndex(fight.currRound - 1)

		local preSceneType = GameSceneMgr.instance:getPreSceneType()
		local preSceneId = GameSceneMgr.instance:getPreSceneId()
		local preLevelId = GameSceneMgr.instance:getPreLevelId()

		GameSceneMgr.instance:closeScene(nil, nil, nil, true)
		GameSceneMgr.instance:setPrevScene(preSceneType, preSceneId, preLevelId)
		self:tryEnterShelterFight()
	elseif SurvivalController.instance:isPlaySummaryAct() then
		if GameSceneMgr.instance:getCurSceneType() ~= SceneType.SurvivalSummaryAct then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.SurvivalLoadingView)
			GameSceneMgr.instance:startScene(SceneType.SurvivalSummaryAct, 280001, 280001, true, true)
		else
			logError("重复加载SurvivalSummaryAct场景")
		end
	elseif GameSceneMgr.instance:getCurSceneType() ~= SceneType.SurvivalShelter then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.SurvivalLoadingView)
		GameSceneMgr.instance:startScene(SceneType.SurvivalShelter, 280001, 280001, true, true)
	else
		logError("重复加载避难所场景")
	end
end

function SurvivalController:showToast(msg)
	if not ViewMgr.instance:isOpen(ViewName.SurvivalToastView) then
		table.insert(SurvivalMapModel.instance.showToastList, msg)
		ViewMgr.instance:openView(ViewName.SurvivalToastView)
	elseif ViewMgr.instance:isOpening(ViewName.SurvivalToastView) then
		table.insert(SurvivalMapModel.instance.showToastList, msg)
	else
		self:dispatchEvent(SurvivalEvent.ShowToast, msg)
	end
end

function SurvivalController:exitMap()
	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if curSceneType == SceneType.SurvivalSummaryAct then
		self:enterSurvivalShelterScene()

		return
	end

	local outsideMo = SurvivalModel.instance:getOutSideInfo()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local inSurvival = weekInfo and weekInfo.inSurvival

	DungeonModel.instance.curSendEpisodeId = nil

	if curSceneType == SceneType.Survival and outsideMo.inWeek and not inSurvival then
		self:enterShelterMap()

		return
	end

	MainController.instance:enterMainScene()
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.SurvivalView)
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity3_1Enum.ActivityId.Survival, true)
		SurvivalController.instance:openSurvivalView(true)
	end)
end

function SurvivalController:openEquipView()
	SurvivalWeekRpc.instance:sendSurvivalGetEquipInfo(self.onRecvEquipInfo, self)
end

function SurvivalController:onRecvEquipInfo(cmd, resultCode, msg)
	ViewMgr.instance:openView(ViewName.SurvivalEquipView)
end

function SurvivalController:tryEnterSurvivalFight(callback, callobj)
	self._callback = callback
	self._callobj = callobj

	local outInfo = SurvivalModel.instance:getOutSideInfo()

	if not outInfo or not outInfo.inWeek then
		logError("不在避难所中，重连不了战斗！！！！")
		self:callBackReconnectFight()

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalGetWeekInfo(self._onRecvWeekInfo, self)
end

function SurvivalController:_onRecvWeekInfo(cmd, resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if weekInfo.inSurvival then
			SurvivalInteriorRpc.instance:sendEnterSurvival(nil, self._onRecvMapInfo, self)
		else
			local fightCo = weekInfo.intrudeBox.fight.fightCo
			local battleId = fightCo and fightCo.battleId or 0

			FightController.instance:setFightParamByEpisodeBattleId(SurvivalConst.Shelter_EpisodeId, battleId)
			self:callBackReconnectFight()
		end
	else
		self:callBackReconnectFight()
	end
end

function SurvivalController:_onRecvMapInfo(cmd, resultCode, msg)
	if resultCode == 0 then
		local sceneMo = SurvivalMapModel.instance:getSceneMo()
		local battleId = sceneMo.battleInfo.battleId

		if battleId == 0 then
			logError("没有battleId，为什么会有战斗！！！！")
		else
			FightController.instance:setFightParamByEpisodeBattleId(SurvivalConst.Survival_EpisodeId, battleId)
		end

		self:callBackReconnectFight()
	else
		self:callBackReconnectFight()
	end
end

function SurvivalController:callBackReconnectFight()
	if self._callback then
		self._callback(self._callobj)
	end

	self._callback = nil
	self._callobj = nil
end

function SurvivalController:openDecreeSelectView()
	local decreeBox = SurvivalShelterModel.instance:getWeekInfo():getDecreeBox()
	local curIndex

	for i = 1, 3 do
		local decreeInfo = decreeBox:getDecreeInfo(i)

		if not decreeInfo or decreeInfo:isCurPolicyEmpty() then
			curIndex = i

			break
		end
	end

	if not curIndex then
		return
	end

	local decreeInfo = decreeBox:getDecreeInfo(curIndex)

	if decreeInfo and decreeInfo:hasOptions() then
		ViewMgr.instance:openView(ViewName.SurvivalDecreeSelectView, {
			decreeInfo = decreeInfo
		})
	else
		SurvivalWeekRpc.instance:sendSurvivalDecreePromulgateRequest(curIndex, self._openDecreeSelectView, self)
	end
end

function SurvivalController:_openDecreeSelectView(cmd, resultCode, msg)
	if resultCode == 0 then
		local decreeBox = SurvivalShelterModel.instance:getWeekInfo():getDecreeBox()
		local decreeInfo = decreeBox:getDecreeInfo(msg.decree.no)

		ViewMgr.instance:openView(ViewName.SurvivalDecreeSelectView, {
			decreeInfo = decreeInfo
		})
	end
end

function SurvivalController:startDecreeVote(decreeInfo)
	ViewMgr.instance:closeAllModalViews()
	ViewMgr.instance:closeAllPopupViews()
	PopupController.instance:setPause(ViewName.SurvivalDecreeVoteView, true)

	if not decreeInfo then
		local decreeBox = SurvivalShelterModel.instance:getWeekInfo():getDecreeBox()
		local result, index = decreeBox:isCurAllPolicyNotFinish()

		decreeInfo = decreeBox:getDecreeInfo(index)
	end

	ViewMgr.instance:openView(ViewName.SurvivalDecreeVoteView, {
		decreeInfo = decreeInfo
	})
end

function SurvivalController:enterSurvival()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if weekInfo:isInFight() then
		GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalHaveBossFightSure, MsgBoxEnum.BoxType.Yes_No, self._sendAbandon, nil, nil, self, nil, nil)

		return
	end

	self:openSurvivalInitTeamView()
end

function SurvivalController:openSurvivalInitTeamView()
	SurvivalMapModel.instance:getInitGroup():init()
	ViewMgr.instance:openView(ViewName.SurvivalInitTeamView)
end

function SurvivalController:_sendAbandon()
	UIBlockHelper.instance:startBlock(SurvivalEnum.SurvivalIntrudeAbandonBlock)
	SurvivalWeekRpc.instance:sendSurvivalIntrudeAbandonExterminateRequest()
end

function SurvivalController:startNewWeek()
	local outSideInfo = SurvivalModel.instance:getOutSideInfo()

	if outSideInfo then
		outSideInfo.inWeek = true
	end
end

function SurvivalController:enterSurvivalSettle()
	local info = SurvivalModel.instance:getSurvivalSettleInfo()

	if info ~= nil then
		ViewMgr.instance:openView(ViewName.SurvivalCeremonyClosingView, {
			isWin = info.win,
			score = info.score,
			report = info.report
		})
		SurvivalModel.instance:setSurvivalSettleInfo(nil)
	end
end

function SurvivalController:tryEnterShelterFight(callBack, callObj)
	self._shelterCallBack = callBack
	self._shelterCallObj = callObj

	HeroGroupRpc.instance:sendGetHeroGroupSnapshotListRequest(ModuleEnum.HeroGroupSnapshotType.Shelter, self._onRecvMsg, self)
end

function SurvivalController:_onRecvMsg(cmd, resultCode, msg)
	if resultCode == 0 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
		local fight = weekInfo.intrudeBox.fight
		local fightCo = fight.fightCo
		local episodeId = SurvivalConst.Shelter_EpisodeId
		local config = DungeonConfig.instance:getEpisodeCO(episodeId)
		local lastIndex = SurvivalModel.instance:getBossFightLastIndex()
		local curRound = lastIndex == nil and fight.currRound or lastIndex

		HeroGroupSnapshotModel.instance:setSelectIndex(ModuleEnum.HeroGroupSnapshotType.Shelter, curRound)

		local info = HeroGroupSnapshotModel.instance:getHeroGroupInfo(ModuleEnum.HeroGroupSnapshotType.Shelter, fight.currRound)

		if info then
			for i = 1, #info.heroList do
				local round = fight:getUseRoundByHeroUid(info.heroList[i])

				if round and round ~= fight.currRound then
					info.heroList[i] = "0"
				end
			end
		end

		DungeonFightController.instance:enterFightByBattleId(config.chapterId, episodeId, fightCo.battleId)
		self:callShelterBackFight()
	else
		self:callShelterBackFight()
	end
end

function SurvivalController:callShelterBackFight()
	if self._shelterCallBack then
		self._shelterCallBack(self._shelterCallObj)
	end

	self._shelterCallBack = nil
	self._shelterCallObj = nil
end

function SurvivalController:playSettleWork(msg)
	if self._settleFlow then
		self._settleFlow:destroy()

		self._settleFlow = nil
	end

	self._settleFlow = FlowSequence.New()

	self._settleFlow:addWork(SurvivalSettleWeekPushWork.New(msg))
	self._settleFlow:start()
end

function SurvivalController:tryShowTaskEventPanel(moduleId, taskId)
	if moduleId ~= SurvivalEnum.TaskModule.StoryTask then
		return
	end

	ViewMgr.instance:openView(ViewName.SurvivalEventPanelView, {
		moduleId = moduleId,
		taskId = taskId
	})
end

function SurvivalController:sendOpenSurvivalRewardInheritView(handbookType, param)
	self.inheritViewParam = param or {}
	self.inheritViewParam.handbookType = handbookType

	SurvivalOutSideRpc.instance:sendSurvivalOutSideGetInfo(self._openSurvivalRewardInheritView, self)
end

function SurvivalController:_openSurvivalRewardInheritView()
	ViewMgr.instance:openView(ViewName.SurvivalRewardInheritView, self.inheritViewParam)
end

function SurvivalController:isPlaySummaryAct()
	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	return curSceneType == SceneType.Survival and #SurvivalMapModel.instance.resultData.afterNpcs > 0
end

function SurvivalController:playSummaryAct()
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalSummaryActView)
end

function SurvivalController:onScenePopupFinish()
	TaskDispatcher.runDelay(self.onDelayPopupFinishEvent, self, 0.767)
end

function SurvivalController:onDelayPopupFinishEvent()
	self:dispatchEvent(SurvivalEvent.OnDelayPopupFinishEvent)

	local weekMo = SurvivalShelterModel.instance:getWeekInfo()
	local clientData = weekMo.clientData

	clientData:saveDataToServer()
end

SurvivalController.instance = SurvivalController.New()

return SurvivalController
