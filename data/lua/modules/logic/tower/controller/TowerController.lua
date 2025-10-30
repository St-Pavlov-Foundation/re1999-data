﻿-- chunkname: @modules/logic/tower/controller/TowerController.lua

module("modules.logic.tower.controller.TowerController", package.seeall)

local TowerController = class("TowerController", BaseController)

function TowerController:onInit()
	self.jumpFlow = nil
end

function TowerController:reInit()
	if self.jumpFlow then
		self.jumpFlow:onDestroyInternal()
	end

	self.jumpFlow = nil
end

function TowerController:addConstEvents()
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self.onUpdateTaskList, self)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, self.onSetTaskList, self)
	self:registerCallback(TowerEvent.DailyReresh, self.dailyReddotRefresh, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, self._trySendTowerDeepRPC, self)
end

function TowerController:jumpView(param)
	if not ViewMgr.instance:isOpen(ViewName.TowerMainView) then
		self.jumpFlow = FlowSequence.New()

		local towerEnterWork = TowerEnterWork.New()

		self.jumpFlow:addWork(towerEnterWork)
		self.jumpFlow:addWork(FunctionWork.New(self.realJumpTowerView, self, param))
		self.jumpFlow:registerDoneListener(self.flowDone, self)
		self.jumpFlow:start()
	else
		self:realJumpTowerView(param)
	end
end

function TowerController:realJumpTowerView(param)
	local towerType = param.towerType
	local towerId = param.towerId

	if towerType == TowerEnum.TowerType.Boss then
		self:openBossTowerEpisodeView(towerType, towerId)
	elseif towerType == TowerEnum.TowerType.Limited then
		self:openTowerTimeLimitLevelView()
	elseif towerType == TowerEnum.TowerType.Normal then
		self:openTowerPermanentView()
	end

	if self.jumpFlow then
		self.jumpFlow:onDone(true)
	end
end

function TowerController:flowDone(isSuccess)
	self.jumpFlow = nil
end

function TowerController:openMainView(param)
	self._mainviewParam = param

	TowerRpc.instance:sendGetTowerInfoRequest(self._openMainView, self)
end

function TowerController:_openMainView(_, resultCode, _)
	if resultCode ~= 0 then
		return
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Tower,
		TaskEnum.TaskType.TowerPermanentDeep
	}, function(_, taskCode, _)
		if taskCode == 0 then
			StoreRpc.instance:sendGetStoreInfosRequest(StoreEnum.TowerStore, function(_, storeCode, _)
				if storeCode == 0 then
					local isDeepLayerUnlock = TowerPermanentDeepModel.instance:checkDeepLayerUnlock()

					if isDeepLayerUnlock then
						TowerDeepRpc.instance:sendTowerDeepGetInfoRequest(function(_, towerDeepCode, _)
							if towerDeepCode == 0 then
								ViewMgr.instance:openView(ViewName.TowerMainView, self._mainviewParam)
							end
						end)
					else
						ViewMgr.instance:openView(ViewName.TowerMainView, self._mainviewParam)
					end
				end
			end)
		end
	end)
end

function TowerController:openBossTowerEpisodeView(towerType, towerId, param)
	if not towerType or not towerId then
		return
	end

	local episodeMo = TowerModel.instance:getEpisodeMoByTowerType(towerType)
	local towerInfo = TowerModel.instance:getTowerInfoById(towerType, towerId)
	local openInfo = TowerModel.instance:getTowerOpenInfo(towerType, towerId)

	if not openInfo then
		return
	end

	local passLayerId = towerInfo and towerInfo.passLayerId or 0
	local curLayerId = episodeMo:getNextEpisodeLayer(towerId, passLayerId) or passLayerId
	local curEpisodeConfig = episodeMo:getEpisodeConfig(towerId, curLayerId)

	if curEpisodeConfig then
		local viewParam = param or {}

		viewParam.episodeConfig = curEpisodeConfig

		if curEpisodeConfig.openRound > 0 then
			if towerInfo:isSpLayerOpen(curEpisodeConfig.layerId) then
				ViewMgr.instance:openView(ViewName.TowerBossSpEpisodeView, viewParam)
			else
				viewParam.episodeConfig = episodeMo:getEpisodeConfig(towerId, passLayerId)

				if viewParam.episodeConfig.openRound > 0 then
					ViewMgr.instance:openView(ViewName.TowerBossSpEpisodeView, viewParam)
				else
					ViewMgr.instance:openView(ViewName.TowerBossEpisodeView, viewParam)
				end
			end
		else
			ViewMgr.instance:openView(ViewName.TowerBossEpisodeView, viewParam)
		end

		TowerModel.instance:setCurTowerType(TowerEnum.TowerType.Boss)
	end
end

function TowerController:openAssistBossView(bossId, isFromHeroGroup, towerType, towerId, otherParam)
	local param = {
		bossId = bossId,
		isFromHeroGroup = isFromHeroGroup,
		towerType = towerType,
		towerId = towerId
	}

	if otherParam then
		param.otherParam = otherParam
	end

	ViewMgr.instance:openView(ViewName.TowerAssistBossView, param)
end

function TowerController:enterFight(param)
	if not param then
		return
	end

	self.enterFightParam = param

	local snapshotId = ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit

	if param.towerType == TowerEnum.TowerType.Boss then
		snapshotId = ModuleEnum.HeroGroupSnapshotType.TowerBoss
	end

	HeroGroupRpc.instance:sendGetHeroGroupSnapshotListRequest(snapshotId, self._enterFight, self)
end

function TowerController:_enterFight()
	local param = self.enterFightParam

	if not param then
		return
	end

	local episodeId = param.episodeId

	TowerModel.instance:setRecordFightParam(param.towerType, param.towerId, param.layerId, param.difficulty, episodeId)

	local speed = param.speed or 1
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	DungeonFightController.instance:enterFight(config.chapterId, episodeId, speed)
end

function TowerController:startFight(param, callback, callbackObj)
	if not param then
		return
	end

	DungeonModel.instance:SetSendChapterEpisodeId(param.chapterId, param.episodeId)
	TowerRpc.instance:sendStartTowerBattleRequest(param, callback, callbackObj)
end

function TowerController:restartStage()
	local param = {}
	local fightParam = FightModel.instance:getFightParam()

	param.fightParam = fightParam
	param.chapterId = fightParam.chapterId
	param.episodeId = fightParam.episodeId
	param.useRecord = fightParam.isReplay
	param.multiplication = fightParam.multiplication
	param.isRestart = true

	self:startFight(param)
end

function TowerController:openTowerMopUpView(param)
	ViewMgr.instance:openView(ViewName.TowerMopUpView, param)
end

function TowerController:openTowerPermanentView(param)
	TowerPermanentModel.instance:onInit()
	TowerPermanentModel.instance:InitData()

	local isDeepLayer = false

	if param and tabletool.len(param) > 0 then
		local isDeepEpisode = TowerPermanentDeepModel.instance:checkIsDeepEpisode(param.episodeId)

		TowerPermanentDeepModel.instance:setInDeepLayerState(isDeepEpisode)
		TowerPermanentDeepModel.instance:setIsSelectDeepCategory(isDeepEpisode)

		isDeepLayer = isDeepEpisode

		if not isDeepLayer then
			local towerConfig = TowerConfig.instance:getPermanentEpisodeCo(param.layerId)
			local stage = towerConfig.stageId
			local layerIndex = towerConfig.index

			TowerPermanentModel.instance:setCurSelectLayer(layerIndex, stage)
			TowerPermanentModel.instance:setCurSelectStage(stage)
		end
	else
		local isDeepLayerUnlock = TowerPermanentDeepModel.instance:checkDeepLayerUnlock()
		local isEnterDeepGuideFinish = TowerPermanentDeepModel.instance:checkEnterDeepLayerGuideFinish()
		local isInDeepLayer = isDeepLayerUnlock and isEnterDeepGuideFinish

		isDeepLayer = isInDeepLayer

		TowerPermanentDeepModel.instance:setInDeepLayerState(isInDeepLayer)
		TowerPermanentDeepModel.instance:setIsSelectDeepCategory(isInDeepLayer)
	end

	TowerPermanentModel.instance:initStageUnFoldState()

	if isDeepLayer then
		TowerDeepRpc.instance:sendTowerDeepGetInfoRequest(function()
			ViewMgr.instance:openView(ViewName.TowerPermanentView, param)
		end, self)
	else
		ViewMgr.instance:openView(ViewName.TowerPermanentView, param)
	end

	TowerModel.instance:setCurTowerType(TowerEnum.TowerType.Normal)
end

function TowerController:openTowerStoreView()
	StoreRpc.instance:sendGetStoreInfosRequest(StoreEnum.TowerStore, function()
		local viewParam = {}

		ViewMgr.instance:openView(ViewName.TowerStoreView, viewParam)
	end, self)
end

function TowerController:openTowerHeroTrialView(param)
	ViewMgr.instance:openView(ViewName.TowerHeroTrialView, param)
end

function TowerController:openTowerBossTeachView(param)
	ViewMgr.instance:openView(ViewName.TowerBossTeachView, param)
end

function TowerController:openTowerTaskView(param)
	local curOpenTimeLimitTowerMo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()
	local timeLimitTowerId = curOpenTimeLimitTowerMo and curOpenTimeLimitTowerMo.towerId or 1
	local viewParam = param or {}

	viewParam.towerType = param and param.towerType
	viewParam.towerId = param and param.towerId

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Tower
	}, function()
		ViewMgr.instance:openView(ViewName.TowerTaskView, viewParam)
	end)
end

function TowerController:selectDefaultTowerTask()
	local curOpenTimeLimitTowerMo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()
	local timeLimitTowerId = curOpenTimeLimitTowerMo and curOpenTimeLimitTowerMo.towerId or 1

	TowerTaskModel.instance:setCurSelectTowerTypeAndId(TowerEnum.TowerType.Limited, timeLimitTowerId)
end

function TowerController:onUpdateTaskList(msg)
	local isChange = TowerTaskModel.instance:updateTaskInfo(msg.taskInfo)

	if isChange then
		TowerTaskModel.instance:refreshList()
	end

	local isDeepChange = TowerDeepTaskModel.instance:updateTaskInfo(msg.taskInfo)

	if isDeepChange then
		TowerDeepTaskModel.instance:refreshList()
	end

	self:dispatchEvent(TowerEvent.TowerTaskUpdated)
end

function TowerController:onSetTaskList()
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.TowerTask
	})

	local towerTasks = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Tower) or {}

	TowerTaskModel.instance:setTaskInfoList(towerTasks)
	TowerDeepTaskModel.instance:setTaskInfoList()

	local curTaskSelectType = TowerTaskModel.instance.curSelectTowerType

	TowerTaskModel.instance:refreshList(curTaskSelectType)
	TowerDeepTaskModel.instance:refreshList()
	self:dispatchEvent(TowerEvent.TowerTaskUpdated)
end

function TowerController:openTowerTimeLimitLevelView(param)
	ViewMgr.instance:openView(ViewName.TowerTimeLimitLevelView, param)
	TowerModel.instance:setCurTowerType(TowerEnum.TowerType.Limited)
end

function TowerController:getRecommendList(battleId)
	local recommendedList = {}
	local battleConfig = lua_battle.configDict[battleId]

	if battleConfig and not string.nilorempty(battleConfig.monsterGroupIds) then
		local monsterGroupIds = string.splitToNumber(battleConfig.monsterGroupIds, "#")

		for i, v in ipairs(monsterGroupIds) do
			local ids = string.splitToNumber(lua_monster_group.configDict[v].monster, "#")

			for index, id in ipairs(ids) do
				local enemy_career = lua_monster.configDict[id].career

				if not tabletool.indexOf(recommendedList, enemy_career) then
					table.insert(recommendedList, enemy_career)
				end
			end
		end

		recommendedList = FightHelper.getAttributeCounter(monsterGroupIds, false)
	end

	return recommendedList
end

function TowerController:setPlayerPrefs(key, value)
	if string.nilorempty(key) or not value then
		return
	end

	local isNumber = type(value) == "number"

	if isNumber then
		GameUtil.playerPrefsSetNumberByUserId(key, value)
	else
		GameUtil.playerPrefsSetStringByUserId(key, value)
	end

	self:dispatchEvent(TowerEvent.LocalKeyChange)
end

function TowerController:getPlayerPrefs(key, defaultValue)
	local value = defaultValue or ""

	if string.nilorempty(key) then
		return value
	end

	local isNumber = type(value) == "number"

	if isNumber then
		value = GameUtil.playerPrefsGetNumberByUserId(key, value)
	else
		value = GameUtil.playerPrefsGetStringByUserId(key, value)
	end

	return value
end

function TowerController:isOpen()
	return OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Tower)
end

function TowerController:isBossTowerOpen()
	local layerNum = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BossTowerOpen)
	local towerInfo = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Normal, 0)
	local passLayer = towerInfo and towerInfo.passLayerId or 0
	local isOpen = passLayer >= tonumber(layerNum)

	return isOpen
end

function TowerController:isTimeLimitTowerOpen()
	local layerNum = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.TimeLimitOpenLayerNum)
	local towerInfo = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Normal, 0)
	local passLayer = towerInfo and towerInfo.passLayerId or 0
	local isOpen = passLayer >= tonumber(layerNum)

	return isOpen
end

function TowerController:isTowerStoreOpen()
	local storeOpenLayer = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.StoreOpen)
	local towerInfo = TowerModel.instance:getTowerInfoById(TowerEnum.TowerType.Normal, 0)
	local passLayer = towerInfo and towerInfo.passLayerId or 0
	local isStoreOpen = passLayer >= tonumber(storeOpenLayer)

	return isStoreOpen
end

function TowerController:checkMopUpReddotShow()
	local needShowRedDot = TowerPermanentModel.instance:checkCanShowMopUpReddot() and 1 or 0
	local redDotInfoList = {
		{
			uid = 0,
			id = RedDotEnum.DotNode.TowerMopUp,
			value = needShowRedDot
		}
	}

	RedDotRpc.instance:clientAddRedDotGroupList(redDotInfoList, true)
end

function TowerController:checkReddotHasNewUpdateTower()
	local isTimeLimitOpen = self:isTimeLimitTowerOpen()
	local curTimeLimitTowerOpenMo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()
	local localTimeNewState = TowerEnum.LockKey

	if curTimeLimitTowerOpenMo then
		localTimeNewState = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.ReddotNewTimeLimitOpen, curTimeLimitTowerOpenMo.id, curTimeLimitTowerOpenMo, TowerEnum.LockKey)
	end

	local hasNewTimeLimitOpen = isTimeLimitOpen and curTimeLimitTowerOpenMo and (not localTimeNewState or localTimeNewState == TowerEnum.LockKey)
	local isBossOpen = self:isBossTowerOpen()
	local hasNewBossOpen = false
	local list = TowerModel.instance:getTowerListByStatus(TowerEnum.TowerType.Boss, TowerEnum.TowerStatus.Open)

	for i, v in ipairs(list) do
		local newState = TowerModel.instance:getLocalPrefsState(TowerEnum.LocalPrefsKey.ReddotNewBossOpen, v.towerId, v, TowerEnum.LockKey)
		local curNewState = TowerEnum.UnlockKey
		local canShowNew = newState == TowerEnum.LockKey and curNewState == TowerEnum.UnlockKey

		if canShowNew then
			hasNewBossOpen = true

			break
		end
	end

	return hasNewTimeLimitOpen or hasNewBossOpen and isBossOpen
end

function TowerController:checkNewUpdateTowerRddotShow()
	local hasNewUpdateTower = self:checkReddotHasNewUpdateTower() and 1 or 0
	local redDotInfoList = {
		{
			uid = 0,
			id = RedDotEnum.DotNode.TowerNewUpdate,
			value = hasNewUpdateTower
		}
	}

	RedDotRpc.instance:clientAddRedDotGroupList(redDotInfoList, true)
end

function TowerController:dailyReddotRefresh()
	self:checkMopUpReddotShow()
	self:checkNewUpdateTowerRddotShow()
end

function TowerController:_onDailyRefresh()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Tower) then
		TowerRpc.instance:sendGetTowerInfoRequest(self.towerTaskDataRequest, self)
	end
end

function TowerController:towerTaskDataRequest()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Tower
	}, self.dailyRefresh, self)
end

function TowerController:dailyRefresh()
	StoreRpc.instance:sendGetStoreInfosRequest(StoreEnum.TowerStore)
	TowerController.instance:dispatchEvent(TowerEvent.DailyReresh)
end

function TowerController:saveNewUpdateTowerReddot()
	local curOpenTimeLimitMo = TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower()

	if curOpenTimeLimitMo then
		TowerModel.instance:setLocalPrefsState(TowerEnum.LocalPrefsKey.ReddotNewTimeLimitOpen, curOpenTimeLimitMo.id, curOpenTimeLimitMo, TowerEnum.UnlockKey)
	end

	local bossTowerOpenList = TowerModel.instance:getTowerOpenList(TowerEnum.TowerType.Boss)

	for i, openInfoMO in ipairs(bossTowerOpenList) do
		TowerModel.instance:setLocalPrefsState(TowerEnum.LocalPrefsKey.ReddotNewBossOpen, openInfoMO.towerId, openInfoMO, TowerEnum.UnlockKey)
	end
end

function TowerController:checkTowerIsEnd(towerType, towerId)
	local openInfo = TowerModel.instance:getTowerOpenInfo(towerType, towerId)

	if not openInfo or openInfo.status ~= TowerEnum.TowerStatus.Open then
		local boxId = towerType == TowerEnum.TowerType.Boss and MessageBoxIdDefine.TowerEnd or MessageBoxIdDefine.TimeLimitTowerEnd

		MessageBoxController.instance:showSystemMsgBox(boxId, MsgBoxEnum.BoxType.Yes, TowerController.yesCallback)
	end
end

function TowerController.yesCallback()
	NavigateButtonsView.homeClick()
	TowerController.instance:openMainView()
end

function TowerController:openTowerDeepTeamSaveView(viewParam)
	ViewMgr.instance:openView(ViewName.TowerDeepTeamSaveView, viewParam)
end

function TowerController:openTowerDeepTaskView(viewParam)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.TowerPermanentDeep
	}, function()
		ViewMgr.instance:openView(ViewName.TowerDeepTaskView, viewParam)
	end)
end

function TowerController:endFightEnterTowerDeepHeroGroup(episodeCO)
	local battleId = DungeonConfig.instance:getEpisodeBattleId(episodeCO.id)

	HeroGroupModel.instance:setParam(battleId, episodeCO.id)

	local preSceneType = GameSceneMgr.instance:getPreSceneType()
	local preSceneId = GameSceneMgr.instance:getPreSceneId()
	local preLevelId = GameSceneMgr.instance:getPreLevelId()

	GameSceneMgr.instance:closeScene(nil, nil, nil, true)
	GameSceneMgr.instance:setPrevScene(preSceneType, preSceneId, preLevelId)
	TowerPermanentDeepModel.instance:setIsFightFailNotEndState(true)
	TowerPermanentDeepModel.instance:setInDeepLayerState(true)
	DungeonFightController.instance:enterFight(episodeCO.chapterId, episodeCO.id, DungeonModel.instance.curSelectTicketId)
end

function TowerController:_trySendTowerDeepRPC()
	local isDeepLayerUnlock = TowerPermanentDeepModel.instance:checkDeepLayerUnlock()

	if isDeepLayerUnlock then
		TowerDeepRpc.instance:sendTowerDeepGetInfoRequest()
	end
end

TowerController.instance = TowerController.New()

return TowerController
