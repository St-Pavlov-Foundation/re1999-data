-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/ArcadeSurvivorGameController.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.ArcadeSurvivorGameController", package.seeall)

local ArcadeSurvivorGameController = class("ArcadeSurvivorGameController", BaseController)

function ArcadeSurvivorGameController:onInit()
	self:reInit()
end

function ArcadeSurvivorGameController:onInitFinish()
	return
end

function ArcadeSurvivorGameController:addConstEvents()
	return
end

function ArcadeSurvivorGameController:reInit()
	if self._respawnMO then
		self:_clearRespawn()
	end

	self._isFinishingLevel = nil
	self._tmpInsideInfo = nil
	self._tmpResultInfo = nil

	self:_setIsCanBeginNewRound()
end

function ArcadeSurvivorGameController:getGameScene()
	return self._gameScene
end

function ArcadeSurvivorGameController:restartGameOrEnterHall()
	local isOpen = ArcadeSurvivorModel.instance:isAct247Open(true)

	if not isOpen then
		return
	end

	ArcadeSurvivorRpc.instance:sendArcadeSurvivorGetInsideInfoRequest(self._onGetInsideInfo, self)
end

function ArcadeSurvivorGameController:_onGetInsideInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if msg.hasSaveGame then
		self._tmpInsideInfo = msg.info

		local prop = self._tmpInsideInfo.prop
		local difficulty = prop and prop.difficulty
		local isInGuide = ArcadeSurvivorGameModel.instance:getIsInGuideLevel(difficulty)

		if isInGuide then
			self:_confirmRestart()
		else
			GameFacade.showMessageBox(MessageBoxIdDefine.ContinueArcadeGame, MsgBoxEnum.BoxType.Yes_No, self._confirmRestart, self._confirmAbandon, nil, self, self, nil)
		end
	else
		ArcadeSurvivorController.instance:openHallView()
	end
end

function ArcadeSurvivorGameController:_confirmRestart()
	local prop = self._tmpInsideInfo and self._tmpInsideInfo.prop
	local difficulty = prop and prop.difficulty

	if difficulty then
		self:enterGame(difficulty, true)
	else
		self._tmpInsideInfo = nil

		ArcadeSurvivorController.instance:openHallView()
	end
end

function ArcadeSurvivorGameController:_confirmAbandon()
	ArcadeSurvivorController.instance:openHallView()
	self:endGame(ArcadeSurvivorGameEnum.SettleType.Abandon, false, false, self._tmpInsideInfo)

	self._tmpInsideInfo = nil
end

function ArcadeSurvivorGameController:enterGame(difficulty, isRestart)
	if not difficulty then
		return
	end

	ArcadeSurvivorGameModel.instance:clearAllData()

	if isRestart then
		ArcadeSurvivorGameModel.instance:setDifficulty(difficulty)
		ArcadeSurvivorHallModel.instance:initInteractiveMODict()
		ArcadeSurvivorRpc.instance:sendArcadeSurvivorGetOutsideInfoRequest(self._restartGameAfterGetOutsideInfo, self)
	else
		local isFinishGuide = ArcadeSurvivorGameModel.instance:isFinishGameGuide()

		if not isFinishGuide then
			difficulty = ArcadeSurvivorGameEnum.Const.GuideDifficulty
		end

		ArcadeSurvivorGameModel.instance:setDifficulty(difficulty)
		ArcadeSurvivorRpc.instance:sendArcadeSurvivorGetOutsideInfoRequest(self._enterGameAfterGetOutsideInfo, self)
	end
end

function ArcadeSurvivorGameController:_restartGameAfterGetOutsideInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:_enterGameInternal(true)
end

function ArcadeSurvivorGameController:_enterGameAfterGetOutsideInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:_enterGameInternal()
end

function ArcadeSurvivorGameController:_enterGameInternal(isRestart)
	if isRestart and self._tmpInsideInfo then
		local restartInsideInfo = self._tmpInsideInfo

		self._tmpInsideInfo = nil

		ArcadeSurvivorGameModel.instance:onRestartGame(restartInsideInfo)
	else
		ArcadeSurvivorGameModel.instance:onEnterGame()
	end

	self._gameScene = ArcadeSurvivorGameScene.New()

	self._gameScene:onEnterGame(isRestart)
	ViewMgr.instance:openView(ViewName.ArcadeSurvivorGameView)
end

function ArcadeSurvivorGameController:startGame(isRestart, isReset)
	self._isFinishingLevel = nil

	ArcadeSurvivorGameTriggerController.instance:clearTriggerChain()

	if not self._isRunning then
		self._isRunning = true

		UpdateBeat:Add(self._onUpdate, self)
	end

	if not self._roundFlow then
		self:_initRoundFlow()
	else
		self:_resetRoundFlow()
	end

	self:pauseGame(ArcadeSurvivorGameEnum.StopSource.GameTransfer)

	if isRestart then
		self:_enterStage(self._restartAfterEnterStage, self)
	else
		ArcadeSurvivorGameModel.instance:triggerGameStart()
		self:_enterNextStage(isReset)
	end

	ArcadeSurvivorStatHelper.instance:sendStartGame(isRestart, isReset)
end

function ArcadeSurvivorGameController:_restartAfterEnterStage()
	local strRestartShopStatus = ArcadeSurvivorGameModel.instance:getRestartShopStatus()
	local restartOpenEventSelect = ArcadeSurvivorGameModel.instance:getRestartOpenEventSelect()

	ArcadeSurvivorGameModel.instance:setRestartShopStatus()
	ArcadeSurvivorGameModel.instance:setRestartOpenEventSelect()

	if not string.nilorempty(strRestartShopStatus) then
		self:_enterLevel(true)

		local shopDataArr = string.split(strRestartShopStatus, "_")
		local shopId = tonumber(shopDataArr[1])
		local consumeRefreshCount = tonumber(shopDataArr[2])
		local goodsIdList = string.splitToNumber(shopDataArr[3], "#")

		self:openShopView(shopId, nil, nil, goodsIdList, consumeRefreshCount)
	elseif restartOpenEventSelect then
		self:_openStageEventView(true)
	else
		self:_enterLevel()
		self:_playLevelOpening()
	end
end

function ArcadeSurvivorGameController:pauseGame(sourceKey)
	ArcadeSurvivorGameModel.instance:requestStopGame(sourceKey)
end

function ArcadeSurvivorGameController:resumeGame(sourceKey)
	ArcadeSurvivorGameModel.instance:requestResumeGame(sourceKey)
end

function ArcadeSurvivorGameController:resetPlayerTurnCountdown()
	local model = ArcadeSurvivorGameModel.instance

	if model:getGameIsEnd() or not model:getIsPlayerTurn() or not self._roundFlow then
		return
	end

	local workList = self._roundFlow:getWorkList()
	local curWork = workList[self._roundFlow._curIndex]

	if curWork and curWork.status == WorkStatus.Running and curWork.resetCountdown then
		curWork:resetCountdown()
	end
end

function ArcadeSurvivorGameController:resetGame()
	ArcadeSurvivorRpc.instance:sendArcadeSurvivorGetOutsideInfoRequest(self._resetGameAfterGetOutsideInfo, self)
end

function ArcadeSurvivorGameController:_resetGameAfterGetOutsideInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:_clearRespawn()
	self:_clearBossDeath()

	local scene = self:getGameScene()
	local entityMgr = scene and scene.entityMgr
	local characterEntity = entityMgr and entityMgr:getCharacterEntity()

	if characterEntity then
		characterEntity:removeAllShow()
	end

	local effectMgr = scene and scene.effectMgr

	if effectMgr then
		effectMgr:clearAllShow()
	end

	self:removeAllEntity()
	ArcadeSurvivorGameModel.instance:onResetGame()
	self:startGame(nil, true)
	self:dispatchEvent(ArcadeSurvivorEvent.OnResetGame)
end

function ArcadeSurvivorGameController:saveGame(strShopStatus, openEventSelect)
	local saveInfo = ArcadeSurvivorGameHelper.getServerInstructionData(false, strShopStatus, openEventSelect)

	ArcadeSurvivorRpc.instance:sendArcadeSurvivorSaveGameRequest(saveInfo)
end

function ArcadeSurvivorGameController:endGame(settleType, isWin, isReset, serverSaveInfo)
	local isGameEnd = ArcadeSurvivorGameModel.instance:getGameIsEnd()

	if isGameEnd then
		return
	end

	self:_clearRespawn()
	self:_clearBossDeath()

	if not serverSaveInfo and settleType ~= ArcadeSurvivorGameEnum.SettleType.Abandon then
		if not ArcadeSurvivorGameModel.instance:isRoundScoreCalculated() then
			ArcadeSurvivorGameModel.instance:calcRoundScore()
		end

		ArcadeSurvivorGameModel.instance:commitLevelScore()
		self:_dispatchScoreChange()
	end

	ArcadeSurvivorGameModel.instance:setGameIsEnd(true)

	if isWin then
		local difficulty = ArcadeSurvivorGameModel.instance:getDifficulty()

		self:_checkCharacterUnlock(ArcadeSurvivorGameEnum.CharacterUnlockType.PassDifficulty, difficulty)

		local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
		local usedCharacterId = characterMO and characterMO:getId()

		self:_checkCharacterUnlock(ArcadeSurvivorGameEnum.CharacterUnlockType.UseCharacterWin, usedCharacterId)
	end

	self._tmpResultInfo = ArcadeSurvivorGameHelper.getResultViewInfo(isWin, isReset, serverSaveInfo)

	local settleInfo = serverSaveInfo or ArcadeSurvivorGameHelper.getServerInstructionData(isWin)

	ArcadeSurvivorRpc.instance:sendArcadeSurvivorSettleGameRequest(settleType, settleInfo, self._openResultViewAfterSettle, self)
	ArcadeSurvivorStatHelper.instance:sendEndGame(settleType, isReset, serverSaveInfo)
end

function ArcadeSurvivorGameController:_openResultViewAfterSettle(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if msg then
		self._tmpResultInfo.bookAddScore = msg.bookAddScore or 0
		self._tmpResultInfo.hasUnlockCharacter = msg.unlockRoleIds and #msg.unlockRoleIds > 0
	end

	ViewMgr.instance:openView(ViewName.ArcadeSurvivorGameResultView, self._tmpResultInfo)

	self._tmpResultInfo = nil
end

function ArcadeSurvivorGameController:onGameViewDestroy()
	ArcadeSurvivorGameTriggerController.instance:clearTriggerChain()
	self:_clearRespawn()

	self._isFinishingLevel = nil

	self:_clearBossDeath()
	self:_disposeRoundFlow()

	if self._isRunning then
		UpdateBeat:Remove(self._onUpdate, self)
	end

	self._isRunning = false

	if self._gameScene then
		self._gameScene:clear()
	end

	self._gameScene = nil
	self._tmpResultInfo = nil
	self._tmpInsideInfo = nil

	ArcadeSurvivorGameModel.instance:clearAllData()
end

function ArcadeSurvivorGameController:_checkLevelFinish(deadEntityType, deadEntityId)
	if self:isPlayingRespawn() then
		self._respawnPendingFinish = {
			deadEntityType,
			deadEntityId
		}

		return
	end

	if self._isFinishingLevel then
		return
	end

	if self:isPlayingBossDeath() then
		return
	end

	local isGameEnd = ArcadeSurvivorGameModel.instance:getGameIsEnd()

	if isGameEnd then
		return
	end

	local monsterEntityType = ArcadeSurvivorEnum.EntityType.Monster
	local remainRound = ArcadeSurvivorGameModel.instance:getRemainRound()

	if remainRound > 0 or deadEntityType and deadEntityType ~= monsterEntityType then
		return
	end

	local monsterMOList = ArcadeSurvivorGameModel.instance:getEntityMOList(monsterEntityType)
	local curLevelId = ArcadeSurvivorGameModel.instance:getCurLevelId()
	local isBossLevel = ArcadeSurvivorConfig.instance:getLevelIsBossLevel(curLevelId)

	if isBossLevel then
		if self:_hasAliveBoss() then
			return
		end
	else
		local aliveMonsterCount = 0

		if monsterMOList then
			for _, monsterMO in ipairs(monsterMOList) do
				local monsterType = monsterMO:getMonsterType()

				if monsterType ~= ArcadeSurvivorEnum.MonsterType.Neutral then
					aliveMonsterCount = aliveMonsterCount + 1
				end
			end
		end

		if aliveMonsterCount > 0 then
			return
		end
	end

	self:_finishLevel()
end

function ArcadeSurvivorGameController:_hasAliveBoss()
	local monsterMOList = ArcadeSurvivorGameModel.instance:getEntityMOList(ArcadeSurvivorEnum.EntityType.Monster)

	if not monsterMOList then
		return false
	end

	for _, monsterMO in ipairs(monsterMOList) do
		local monsterType = monsterMO:getMonsterType()

		if monsterType == ArcadeSurvivorEnum.MonsterType.Boss then
			return true
		end
	end

	return false
end

function ArcadeSurvivorGameController:_finishLevel()
	if not ArcadeSurvivorGameModel.instance:isRoundScoreCalculated() then
		ArcadeSurvivorGameModel.instance:calcRoundScore()
	end

	ArcadeSurvivorGameModel.instance:commitLevelScore()
	self:_dispatchScoreChange()
	ArcadeSurvivorStatHelper.instance:sendFinishLevel()

	self._roundEndUnits, self._roundEndIndex = nil
	self._isFinishingLevel = true

	self:_setIsCanBeginNewRound(false)
	self:pauseGame(ArcadeSurvivorGameEnum.StopSource.GameTransfer)
	self._roundFlow:stop()

	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
	local isLopera = characterMO:getId() == ArcadeSurvivorGameEnum.Const.LoperaHeroId
	local levelId = ArcadeSurvivorGameModel.instance:getCurLevelId()
	local isBoss = ArcadeSurvivorConfig.instance:getLevelIsBossLevel(levelId)
	local constId

	if isBoss then
		constId = isLopera and ArcadeSurvivorEnum.ConstId.LoperaBossFinishTip or ArcadeSurvivorEnum.ConstId.BossFinishTip
	else
		constId = isLopera and ArcadeSurvivorEnum.ConstId.LoperaLevelFinishTip or ArcadeSurvivorEnum.ConstId.LevelFinishTip
	end

	if ArcadeSurvivorGameModel.instance:isDifficultyCompleted() then
		self:_finishLevelAfterOpening()

		return
	end

	self:_playConstOpening(constId, self._finishLevelAfterOpening)
end

function ArcadeSurvivorGameController:_finishLevelAfterOpening()
	local scene = self:getGameScene()
	local effectMgr = scene and scene.effectMgr

	if effectMgr then
		effectMgr:clearAllShow()
	end

	self:removeAllEntity()
	ArcadeSurvivorGameModel.instance:addResultStatistics(ArcadeSurvivorGameEnum.CustomSaveInfoKey.PassLevelCount)

	local curStageId = ArcadeSurvivorGameModel.instance:getCurStageId()
	local stageLevelCount = ArcadeSurvivorConfig.instance:getStageLevelCount(curStageId)
	local curLevelIndex = ArcadeSurvivorGameModel.instance:getCurLevelIndex()
	local curLevelId = ArcadeSurvivorGameModel.instance:getCurLevelId()
	local addDiamond = ArcadeSurvivorConfig.instance:getLevelAddDiamond(curLevelId)
	local addCassette = ArcadeSurvivorConfig.instance:getLevelAddCassette(curLevelId)

	self:changeCurrencyCount(ArcadeSurvivorEnum.Currency.Diamond, addDiamond)
	self:changeCurrencyCount(ArcadeSurvivorEnum.Currency.Cassette, addCassette)

	if stageLevelCount <= curLevelIndex then
		local difficulty = ArcadeSurvivorGameModel.instance:getDifficulty()
		local difficultyStageCount = ArcadeSurvivorConfig.instance:getDifficultyStageCount(difficulty)
		local curStageIndex = ArcadeSurvivorGameModel.instance:getCurStageIndex()

		if difficultyStageCount <= curStageIndex then
			self:endGame(ArcadeSurvivorGameEnum.SettleType.Win, true)

			return
		end
	end

	self:pauseGame(ArcadeSurvivorGameEnum.StopSource.GameTransfer)

	local shopId = ArcadeSurvivorGameModel.instance:getShopId()
	local goodsIdList = ArcadeSurvivorGameModel.instance:getGoodsIdList(shopId)
	local goodsIdStr = table.concat(goodsIdList, "#")
	local strShopStatus = string.format("%s_0_%s", shopId, goodsIdStr)

	self:saveGame(strShopStatus, false)
	self:openShopView(shopId, nil, nil, goodsIdList)
end

function ArcadeSurvivorGameController:openShopView(shopId, newPackIdList, isGMOpen, goodsIdList, consumeRefreshCount)
	if not shopId and (not newPackIdList or #newPackIdList == 0) then
		return
	end

	self:pauseGame(ArcadeSurvivorGameEnum.StopSource.Shop)

	local shopViewParam = {
		shopId = shopId,
		newPackIdList = newPackIdList,
		isGMOpen = isGMOpen,
		goodsIdList = goodsIdList,
		consumeRefreshCount = consumeRefreshCount
	}

	ViewMgr.instance:openView(ViewName.ArcadeSurvivorShopView, shopViewParam)
end

function ArcadeSurvivorGameController:onShopClosed()
	local ruleModel = ArcadeSurvivorGameModel.instance:getRuleModel()

	ruleModel:onShopClosed()
	self:_enterNextLevelOrStage()
end

function ArcadeSurvivorGameController:_enterNextLevelOrStage()
	ArcadeSurvivorGameModel.instance:onEnterNextLevelOrStage()

	local curStageId = ArcadeSurvivorGameModel.instance:getCurStageId()
	local stageLevelCount = ArcadeSurvivorConfig.instance:getStageLevelCount(curStageId)
	local curLevelIndex = ArcadeSurvivorGameModel.instance:getCurLevelIndex()

	if stageLevelCount <= curLevelIndex then
		self:_enterNextStage(true)
	else
		self:_enterNextLevel()
		self:saveGame(false, false)
		self:_playBattleStartTip()
	end
end

function ArcadeSurvivorGameController:_enterNextStage(isPlayExcessive)
	local curStageIndex = ArcadeSurvivorGameModel.instance:getCurStageIndex()
	local nextStageIndex = curStageIndex + 1
	local difficulty = ArcadeSurvivorGameModel.instance:getDifficulty()
	local nextStageId = ArcadeSurvivorConfig.instance:getDifficultyStageId(difficulty, nextStageIndex)

	if not nextStageId then
		logError(string.format("ArcadeSurvivorGameController:_enterNextStage error, nextStageId is nil, difficulty:%s curStageIndex:%s", difficulty, curStageIndex))

		return
	end

	ArcadeSurvivorGameModel.instance:setCurStageIndex(nextStageIndex)

	if isPlayExcessive then
		self:dispatchEvent(ArcadeSurvivorEvent.PlayChangeStageExcessive)
	else
		self:enterStageSceneAfterExcessive()
	end
end

function ArcadeSurvivorGameController:enterStageSceneAfterExcessive()
	self:_enterStage(self._openStageEventView, self)
end

function ArcadeSurvivorGameController:_enterStage(cb, cbObj)
	local scene = self:getGameScene()

	if not scene then
		return
	end

	local curStageId = ArcadeSurvivorGameModel.instance:getCurStageId()
	local sceneResName = ArcadeSurvivorConfig.instance:getStageSceneRes(curStageId)

	scene:changeSceneRes(sceneResName, cb, cbObj)
end

function ArcadeSurvivorGameController:_openStageEventView(isRestart)
	ArcadeSurvivorGameModel.instance:setCurLevelIndex()
	self:_enterNextLevel()

	if not isRestart then
		self:saveGame(false, true)
	end

	self:pauseGame(ArcadeSurvivorGameEnum.StopSource.SelectEvent)
	ViewMgr.instance:openView(ViewName.ArcadeSurvivorEventSelectView)
end

function ArcadeSurvivorGameController:_enterNextLevel()
	local curLevelIndex = ArcadeSurvivorGameModel.instance:getCurLevelIndex()
	local nextLevelIndex = curLevelIndex + 1
	local stageId = ArcadeSurvivorGameModel.instance:getCurStageId()
	local nextLevelId = ArcadeSurvivorConfig.instance:getStageLevelId(stageId, nextLevelIndex)

	if not nextLevelId then
		logError(string.format("ArcadeSurvivorGameController:_enterNextLevel error, nextLevelId is nil, stageId:%s curLevelIndex:%s", stageId, curLevelIndex))

		return
	end

	ArcadeSurvivorGameModel.instance:setCurLevelIndex(nextLevelIndex)
	self:_enterLevel()
end

function ArcadeSurvivorGameController:_enterLevel(restartInLevelEnd)
	self._isFinishingLevel = nil

	local levelId = ArcadeSurvivorGameModel.instance:getCurLevelId()
	local levelRuleId = ArcadeSurvivorConfig.instance:getLevelRuleId(levelId)

	ArcadeSurvivorStatHelper.instance:recordEnterLevel()
	ArcadeSurvivorGameModel.instance:resetLevelScore()

	if SLFramework.FrameworkSettings.IsEditor then
		local difficulty = ArcadeSurvivorGameModel.instance:getDifficulty()
		local difficultyDesc = ArcadeSurvivorConfig.instance:getDifficultyDesc(difficulty) or "未知难度"
		local stageIndex = ArcadeSurvivorGameModel.instance:getCurStageIndex()
		local stageId = ArcadeSurvivorGameModel.instance:getCurStageId()
		local stageName = ArcadeSurvivorConfig.instance:getStageName(stageId) or "未知阶段"
		local levelIndex = ArcadeSurvivorGameModel.instance:getCurLevelIndex()
		local levelName = ArcadeSurvivorConfig.instance:getLevelName(levelId) or "未知关卡"

		logNormal(string.format("【关卡开始】难度:%s(ID:%s) 阶段:%s(%d) 关卡:%s(%d) 关卡ID:%s", difficultyDesc, difficulty, stageName, stageIndex, levelName, levelIndex, levelId))
	end

	local scene = self:getGameScene()

	if scene then
		scene.tileMgr:onEnterLevel()
		scene:adjustViewSize()
		scene:focusPlayer()
	end

	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if characterMO then
		local startGridX, startGridY = ArcadeSurvivorConfig.instance:getLevelRuleStartPos(levelRuleId)
		local entityType = characterMO:getEntityType()
		local uid = characterMO:getUid()

		self:moveEntity(entityType, uid, startGridX, startGridY)

		local characterEntity = scene and scene.entityMgr and scene.entityMgr:getCharacterEntity()

		if characterEntity then
			characterEntity:removeActionShow()
		end
	end

	if restartInLevelEnd then
		return
	end

	local initMonsterCount = ArcadeSurvivorConfig.instance:getLevelRuleInitMonsterCount(levelRuleId)
	local initMonsterDataList = ArcadeSurvivorGameModel.instance:getSpawnMonsterDataList(initMonsterCount)
	local bossIdList, bossPosList = ArcadeSurvivorConfig.instance:getLevelRuleBossIdList(levelRuleId)
	local bossCount = bossIdList and #bossIdList or 0

	if bossCount > 0 then
		initMonsterDataList = initMonsterDataList or {}

		for i = 1, bossCount do
			local bossId = bossIdList[i]
			local bossPos = bossPosList[i]

			if bossPos and bossPos.x and bossPos.y then
				local sizeX, sizeY = ArcadeSurvivorConfig.instance:getMonsterSize(bossId)
				local bossData = {
					entityType = ArcadeSurvivorEnum.EntityType.Monster,
					id = bossId,
					x = bossPos.x,
					y = bossPos.y,
					sizeX = sizeX,
					sizeY = sizeY
				}

				table.insert(initMonsterDataList, 1, bossData)
			end
		end
	end

	self:addEntityList(initMonsterDataList)

	local ruleModel = ArcadeSurvivorGameModel.instance:getRuleModel()

	ruleModel:onEnterLevel()
	self:dispatchEvent(ArcadeSurvivorEvent.OnEnterLevel, levelId)
end

function ArcadeSurvivorGameController:selectStageEvent(eventId)
	ArcadeSurvivorGameModel.instance:addSelectEvent(eventId)

	local ruleIdList = ArcadeSurvivorConfig.instance:getEventRuleIdList(eventId)

	if ruleIdList then
		local ruleModel = ArcadeSurvivorGameModel.instance:getRuleModel()

		for _, ruleId in ipairs(ruleIdList) do
			ruleModel:onEventRuleGained(ruleId, eventId)
		end
	end

	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
	local skillIdList = ArcadeSurvivorConfig.instance:getEventSkillIdList(eventId)

	if skillIdList and characterMO then
		for i = 1, #skillIdList do
			local skillId = skillIdList[i]

			characterMO:addSkill(skillId, ArcadeSurvivorGameEnum.SkillSourceType.Normal, eventId)
		end
	end

	self:saveGame(false, false)
	self:dispatchEvent(ArcadeSurvivorEvent.OnSelectEvent, eventId)
	self:_playLevelOpening()
end

function ArcadeSurvivorGameController:_playConstOpening(constId, callback)
	local text = ArcadeSurvivorConfig.instance:getConst(constId, false, true)
	local textArr = string.split(text, "#")

	self:dispatchEvent(ArcadeSurvivorEvent.PlayOpening, textArr[1], textArr[2], callback, self)
end

function ArcadeSurvivorGameController:_playLevelOpening()
	local levelId = ArcadeSurvivorGameModel.instance:getCurLevelId()
	local title = ArcadeSurvivorConfig.instance:getLevelTitle(levelId)

	if not string.nilorempty(title) then
		local eventIdList = ArcadeSurvivorGameModel.instance:getEventIdList()
		local desc = ArcadeSurvivorConfig.instance:getEventDesc(eventIdList[#eventIdList]) or ""

		self:dispatchEvent(ArcadeSurvivorEvent.PlayOpening, title, desc, self._playBattleStartTip, self)
	else
		self:_playBattleStartTip()
	end
end

function ArcadeSurvivorGameController:_playBattleStartTip()
	local levelId = ArcadeSurvivorGameModel.instance:getCurLevelId()

	if not ArcadeSurvivorConfig.instance:getLevelIsBossLevel(levelId) then
		self:_playConstOpening(ArcadeSurvivorEnum.ConstId.BattleStartTip, self._gameTransferFinish)
	else
		self:_gameTransferFinish()
	end
end

function ArcadeSurvivorGameController:_gameTransferFinish()
	self:resumeGame(ArcadeSurvivorGameEnum.StopSource.GameTransfer)

	local triggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.BattleStart
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
	local characterContext = ArcadeSurvivorGameTriggerContext.New(triggerPoint, nil, characterMO)

	ArcadeSurvivorGameTriggerController.instance:trigger(triggerPoint, nil, characterContext)

	local monsterMOList = ArcadeSurvivorGameModel.instance:getEntityMOList(ArcadeSurvivorEnum.EntityType.Monster)

	if monsterMOList then
		for _, monsterMO in ipairs(monsterMOList) do
			local type = monsterMO:getMonsterType()

			if type == ArcadeSurvivorEnum.MonsterType.Boss then
				local bossContext = ArcadeSurvivorGameTriggerContext.New(triggerPoint, nil, monsterMO)

				ArcadeSurvivorGameTriggerController.instance:trigger(triggerPoint, nil, bossContext)
			end
		end
	end

	self:_setIsCanBeginNewRound(true)
	self:dispatchEvent(ArcadeSurvivorEvent.OnBattleBegin)
end

function ArcadeSurvivorGameController:_checkCharacterUnlock(unlockType, param)
	local lockCharacterIdList = ArcadeSurvivorGameModel.instance:getLockCharacterIdList()

	for _, characterId in ipairs(lockCharacterIdList) do
		local isCanUnlock = self:_canUnlockCharacter(characterId, unlockType, param)

		if isCanUnlock then
			ArcadeSurvivorGameModel.instance:addUnlockCharacter(characterId)
		end
	end
end

function ArcadeSurvivorGameController:_canUnlockCharacter(characterId, unlockType, param)
	local conditionStr = ArcadeSurvivorConfig.instance:getCharacterUnlockCondition(characterId)

	if string.nilorempty(conditionStr) then
		return false
	end

	local conditionArr = string.splitToNumber(conditionStr, "#")
	local conditionType = conditionArr and conditionArr[1]

	if conditionType ~= unlockType then
		return false
	end

	local conditionParam = conditionArr and conditionArr[2]
	local unlockTypeEnum = ArcadeSurvivorGameEnum.CharacterUnlockType

	if unlockType == unlockTypeEnum.KillMonster then
		return param == conditionParam
	elseif unlockType == unlockTypeEnum.TotalKillMonsterCount then
		local accumKillCount = ArcadeSurvivorOutSideModel.instance:getAccumKillCount()
		local killCount = (param or 0) + accumKillCount

		return conditionParam <= killCount
	elseif unlockType == unlockTypeEnum.PassDifficulty then
		return param == conditionParam
	elseif unlockType == unlockTypeEnum.UseCharacterWin then
		return param == conditionParam
	end
end

function ArcadeSurvivorGameController:_onUpdate()
	local isGameEnd = ArcadeSurvivorGameModel.instance:getGameIsEnd()

	if isGameEnd then
		return
	end

	local scene = self:getGameScene()

	if scene and scene.onUpdate then
		scene:onUpdate()
	end

	local isGamePause = ArcadeSurvivorGameModel.instance:getIsPauseGame()

	if isGamePause then
		return
	end

	if self._roundEndUnits then
		self:_onRoundEnd()

		return
	end

	if self._roundFlow then
		if self._canBeginNewRound then
			self:_resetRoundFlow()
			self._roundFlow:start()
		end

		local workList = self._roundFlow:getWorkList()
		local curWork = workList[self._roundFlow._curIndex]

		if curWork and curWork.status == WorkStatus.Running and curWork.onUpdate then
			curWork:onUpdate()
		end
	end
end

function ArcadeSurvivorGameController:_initRoundFlow()
	self:_disposeRoundFlow()

	self._roundFlow = FlowSequence.New()

	self._roundFlow:addWork(ArcadeSurvivorRoundBeginWork.New())
	self._roundFlow:addWork(ArcadeSurvivorCharacterWork.New())
	self._roundFlow:addWork(ArcadeSurvivorEntityWork.New())
	self._roundFlow:registerDoneListener(self._onGameFlowDone, self)
end

function ArcadeSurvivorGameController:_resetRoundFlow()
	if not self._roundFlow then
		return
	end

	self:_setIsCanBeginNewRound()
	self._roundFlow:reset()
end

function ArcadeSurvivorGameController:_onGameFlowDone(isSuccess)
	if not isSuccess then
		return
	end

	self._roundEndUnits = {
		ArcadeSurvivorGameModel.instance:getCharacterMO()
	}

	local monsters = ArcadeSurvivorGameModel.instance:getEntityMOList(ArcadeSurvivorEnum.EntityType.Monster)

	if monsters then
		for _, mo in ipairs(monsters) do
			self._roundEndUnits[#self._roundEndUnits + 1] = mo
		end
	end

	self._roundEndIndex = 1

	self:_onRoundEnd()
end

function ArcadeSurvivorGameController:_onRoundEnd()
	local isGameEnd = ArcadeSurvivorGameModel.instance:getGameIsEnd()

	if isGameEnd then
		return
	end

	local turnEndEvent = ArcadeSurvivorGameEnum.BuffTickEvent.TurnEnd

	while self._roundEndIndex <= #self._roundEndUnits do
		local mo = self._roundEndUnits[self._roundEndIndex]

		self._roundEndIndex = self._roundEndIndex + 1

		if mo:getIsAlive() then
			mo:onBuffTickEvent(turnEndEvent)
		end

		if ArcadeSurvivorGameModel.instance:getIsPauseGame() or ArcadeSurvivorGameModel.instance:getGameIsEnd() then
			return
		end
	end

	self._roundEndUnits, self._roundEndIndex = nil

	ArcadeSurvivorGameModel.instance:calcRoundScore()
	self:_dispatchScoreChange()
	self:_setIsCanBeginNewRound(true)
end

function ArcadeSurvivorGameController:_dispatchScoreChange()
	self:dispatchEvent(ArcadeSurvivorEvent.OnScoreChange, ArcadeSurvivorGameModel.instance:getCurLevelScore())
end

function ArcadeSurvivorGameController:_setIsCanBeginNewRound(isCanBegin)
	self._canBeginNewRound = isCanBegin
end

function ArcadeSurvivorGameController:_disposeRoundFlow()
	self._roundEndUnits, self._roundEndIndex = nil

	self:_setIsCanBeginNewRound()

	if self._roundFlow then
		self._roundFlow:unregisterDoneListener(self._onGameFlowDone, self)
		self._roundFlow:destroy()

		self._roundFlow = nil
	end
end

function ArcadeSurvivorGameController:onRoundBegin()
	ArcadeSurvivorGameModel.instance:addRound()
	self:_checkMonsterSpawn()
	self:_checkLevelFinish()

	if not self._isFinishingLevel then
		ArcadeSurvivorGameModel.instance:resetRoundScore()
	end

	self:dispatchEvent(ArcadeSurvivorEvent.OnRoundBegin)
end

function ArcadeSurvivorGameController:_checkMonsterSpawn()
	local spawnCount = ArcadeSurvivorGameModel.instance:getMonsterSpawnConfig()
	local curLevelRuleId = ArcadeSurvivorGameModel.instance:getCurLevelRule()
	local waveInterval = ArcadeSurvivorConfig.instance:getLevelRuleWaveInterval(curLevelRuleId)

	if not spawnCount or spawnCount <= 0 or not waveInterval or waveInterval < 0 then
		return
	end

	local remainRound = ArcadeSurvivorGameModel.instance:getRemainRound()
	local curRound = ArcadeSurvivorGameModel.instance:getCurRound()

	if curRound <= 0 or remainRound <= 0 then
		return
	end

	local round2Spawn = (curRound - 1) % (waveInterval + 1)

	if round2Spawn == 0 then
		local curWaveIndex = ArcadeSurvivorGameModel.instance:getCurWaveIndex()
		local waveExtraAdd = ArcadeSurvivorGameModel.instance:getWaveExtraAdd(curWaveIndex)
		local spawnMonsterDataList = ArcadeSurvivorGameModel.instance:getSpawnMonsterDataList(spawnCount + waveExtraAdd)

		self:addEntityList(spawnMonsterDataList)
	end
end

function ArcadeSurvivorGameController:_checkDelaySkillHit()
	local delayHitRecordList = ArcadeSurvivorGameModel.instance:getDelayHitRecordList()

	if #delayHitRecordList <= 0 then
		return
	end

	local readyRecords = {}

	for _, record in ipairs(delayHitRecordList) do
		local isReadyHit = record:tick()

		if isReadyHit then
			readyRecords[#readyRecords + 1] = record
		end
	end

	for _, record in ipairs(readyRecords) do
		local entityType = record:getEntityType()
		local uid = record:getUid()
		local skillId = record:getSkillId()
		local skillUid = record:getSkillUid()
		local casterMO = ArcadeSurvivorGameModel.instance:getEntityMO(entityType, uid)
		local skill = casterMO and casterMO:getSkillByUid(skillId, skillUid)
		local result

		if skill then
			result = skill:skillDelayHit(record)
		else
			logError(string.format("ArcadeSurvivorGameController:_checkDelaySkillHit error, invalid skill in record, skillId:%s triggerIndex:%s", skillId, record:getTriggerIndex()))
		end

		if result == ArcadeSurvivorGameEnum.DelayHitResult.Retry then
			record.remainTurn = 1
		else
			ArcadeSurvivorGameModel.instance:removeDelayHit(record)
		end

		if skill then
			local waiting = ArcadeSurvivorGameModel.instance:hasDelayHitRecord(entityType, uid, skillUid)

			skill:setWaitDelayHit(waiting)
		end
	end

	self:refreshDelayAlert()
end

function ArcadeSurvivorGameController:addDelayHit(record)
	local result = ArcadeSurvivorGameModel.instance:addDelayHitRecord(record)

	if not result then
		return
	end

	local needAlert = record:getNeedAlert()

	if needAlert then
		self:refreshDelayAlert()
	end

	return true
end

function ArcadeSurvivorGameController:refreshDelayAlert()
	local scene = self:getGameScene()
	local effectMgr = scene and scene.effectMgr

	if not effectMgr then
		return
	end

	local alertDict = ArcadeSurvivorGameModel.instance:getDelayAlertDict()
	local showIdList = ArcadeSurvivorConfig.instance:getActionShowIdList(ArcadeSurvivorEnum.ActionShowId.Alert)
	local alertShowId = showIdList and showIdList[1]

	if not alertShowId then
		return
	end

	if alertDict and next(alertDict) then
		for gridId, remainTurn in pairs(alertDict) do
			local gridX, gridY = ArcadeSurvivorGameHelper.getGridXYById(gridId)

			effectMgr:playGridShow(alertShowId, gridX, gridY, nil, ArcadeSurvivorAlertGridShowHandler, remainTurn)
		end
	end

	local activeEffectDict = effectMgr:getShowActiveEffectDict(alertShowId)

	if activeEffectDict then
		for gridId in pairs(activeEffectDict) do
			if not alertDict[gridId] then
				local gridX, gridY = ArcadeSurvivorGameHelper.getGridXYById(gridId)

				effectMgr:removeGridShow(alertShowId, gridX, gridY)
			end
		end
	end
end

function ArcadeSurvivorGameController:beginPlayerTurn()
	ArcadeSurvivorGameModel.instance:setIsPlayerTurn(true)
end

function ArcadeSurvivorGameController:endPlayerTurn()
	ArcadeSurvivorGameModel.instance:setIsPlayerTurn(false)
	self:_checkDelaySkillHit()
end

function ArcadeSurvivorGameController:addEntityOne(entityType, id, x, y, sizeX, sizeY, cb, cbObj)
	local cfg = ArcadeSurvivorHelper.getEntityCfg(entityType, id)

	if not cfg then
		GameUtil.handleCallbackFunc(cb, cbObj)

		return
	end

	local mo = ArcadeSurvivorGameModel.instance:addEntityMO(entityType, id, x, y, sizeX, sizeY)
	local scene = self:getGameScene()

	if scene then
		scene.entityMgr:addEntity(mo, cb, cbObj)
	else
		GameUtil.handleCallbackFunc(cb, cbObj)
	end

	return mo
end

function ArcadeSurvivorGameController:addEntityList(dataList, cb, cbObj)
	if not dataList or #dataList <= 0 then
		GameUtil.handleCallbackFunc(cb, cbObj)

		return
	end

	local moList = ArcadeSurvivorGameModel.instance:addEntityMOByList(dataList)
	local scene = self:getGameScene()

	if scene then
		scene.entityMgr:addEntityByList(moList, cb, cbObj)
	else
		GameUtil.handleCallbackFunc(cb, cbObj)
	end
end

function ArcadeSurvivorGameController:removeEntityOne(entityType, uid)
	if not entityType or not uid then
		return
	end

	local isClearDelayHit = ArcadeSurvivorGameModel.instance:removeDelayHitByEntity(entityType, uid)
	local scene = self:getGameScene()

	if scene then
		scene.entityMgr:removeEntity(entityType, uid)
	end

	ArcadeSurvivorGameModel.instance:removeEntityMO(entityType, uid)

	if isClearDelayHit then
		self:refreshDelayAlert()
	end

	self:dispatchEvent(ArcadeSurvivorEvent.OnRemoveEntity, entityType, uid)
end

function ArcadeSurvivorGameController:removeAllEntity(includeCharacter)
	local scene = self:getGameScene()

	if scene then
		scene.entityMgr:clearAllEntity(includeCharacter)
	end

	ArcadeSurvivorGameModel.instance:clearAllEntityMO(includeCharacter)
end

function ArcadeSurvivorGameController:replaceFloor(floorId, gridX, gridY)
	local floorEntityType = ArcadeSurvivorEnum.EntityType.Floor
	local floorCfg = ArcadeSurvivorConfig.instance:getFloorCfg(floorId)

	if not floorCfg then
		return false
	end

	local sizeX, sizeY = ArcadeSurvivorConfig.instance:getFloorSize(floorId)
	local isOutside = ArcadeSurvivorGameHelper.isOutsideMap(gridX, gridY, sizeX, sizeY)

	if isOutside then
		return false
	end

	local floorLayer = ArcadeSurvivorGameEnum.EntityLayer.Floor
	local originFloorData = ArcadeSurvivorGameModel.instance:getEntityDataInGrid(gridX, gridY, floorLayer)
	local originFloorUid = originFloorData and originFloorData.uid
	local originFloorMO = originFloorUid and ArcadeSurvivorGameModel.instance:getEntityMO(floorEntityType, originFloorUid)
	local isSameFloor = self:_isSameFloor(originFloorMO, floorId, gridX, gridY)

	if isSameFloor then
		originFloorMO:resetRoundCountdown()

		return true
	end

	self:_removeCoveredFloor(gridX, gridY, sizeX, sizeY)

	local floorMO = self:addEntityOne(floorEntityType, floorId, gridX, gridY, sizeX, sizeY)

	return floorMO ~= nil
end

function ArcadeSurvivorGameController:_isSameFloor(floorMO, floorId, gridX, gridY)
	if not floorMO then
		return false
	end

	local floorGridX, floorGridY = floorMO:getGridPos()

	return floorMO:getId() == floorId and floorGridX == gridX and floorGridY == gridY
end

function ArcadeSurvivorGameController:_removeCoveredFloor(gridX, gridY, sizeX, sizeY)
	local floorEntityType = ArcadeSurvivorEnum.EntityType.Floor
	local floorLayer = ArcadeSurvivorGameEnum.EntityLayer.Floor
	local removeUidDict = {}

	for gridOffsetX = 0, sizeX - 1 do
		for gridOffsetY = 0, sizeY - 1 do
			local occupyFloorData = ArcadeSurvivorGameModel.instance:getEntityDataInGrid(gridX + gridOffsetX, gridY + gridOffsetY, floorLayer)
			local occupyFloorUid = occupyFloorData and occupyFloorData.uid

			if occupyFloorUid then
				removeUidDict[occupyFloorUid] = true
			end
		end
	end

	for occupyFloorUid in pairs(removeUidDict) do
		self:removeEntityOne(floorEntityType, occupyFloorUid)
	end
end

function ArcadeSurvivorGameController:addBuff2Entity(entityType, uid, buffId, count, casterMO)
	local entityMO = ArcadeSurvivorGameModel.instance:getEntityMO(entityType, uid)

	if not entityMO then
		return
	end

	entityMO:addBuff(buffId, count, casterMO)

	local scene = self:getGameScene()
	local entityMgr = scene and scene.entityMgr
	local entity = entityMgr and entityMgr:getEntity(entityType, uid)

	if entity then
		local gainShow = ArcadeSurvivorConfig.instance:getBuffGainShow(buffId)

		if gainShow and gainShow > 0 then
			entity:playShow(gainShow)
		else
			entity:playStateShow()
		end
	end

	self:dispatchEvent(ArcadeSurvivorEvent.OnBuffChange, entityType, uid)
end

function ArcadeSurvivorGameController:onBuffExpire(entityType, uid, buffId)
	self:_stopEntityBuffLoopShow(entityType, uid, buffId)
end

function ArcadeSurvivorGameController:_stopEntityBuffLoopShow(entityType, uid, buffId)
	local scene = self:getGameScene()
	local entityMgr = scene and scene.entityMgr
	local entity = entityMgr and entityMgr:getEntity(entityType, uid)

	if not entity then
		return
	end

	local loopShow = ArcadeSurvivorConfig.instance:getBuffLoopShow(buffId)

	if loopShow and loopShow ~= 0 then
		entity:stopStateLoopEffect(loopShow)
	end
end

function ArcadeSurvivorGameController:removeEntityBuff(entityType, uid, buffId, count)
	local entityMO = ArcadeSurvivorGameModel.instance:getEntityMO(entityType, uid)

	if not entityMO then
		return
	end

	local existedBuff = entityMO:getBuff(buffId)

	if existedBuff and existedBuff:getIsActive() then
		entityMO:removeBuff(buffId, count)

		local remainBuff = entityMO:getBuff(buffId)

		if not remainBuff then
			self:_stopEntityBuffLoopShow(entityType, uid, buffId)
		end
	end

	self:dispatchEvent(ArcadeSurvivorEvent.OnBuffChange, entityType, uid)
end

function ArcadeSurvivorGameController:changeEntityHp(entityType, uid, changeVal)
	local entityMO = ArcadeSurvivorGameModel.instance:getEntityMO(entityType, uid)

	self:changeEntityMOHp(entityMO, changeVal)
end

function ArcadeSurvivorGameController:changeEntityMOHp(entityMO, changeVal, critCount)
	if not entityMO then
		return
	end

	local realChangeVal = entityMO:changeHp(changeVal)

	self:dispatchEvent(ArcadeSurvivorEvent.OnChangeEntityHp, entityMO, realChangeVal, changeVal, critCount)
end

function ArcadeSurvivorGameController:changeCurrencyCount(currencyId, changeNum, gainPos, isApplyGradeRate)
	ArcadeSurvivorGameModel.instance:changeCurrencyCount(currencyId, changeNum, true, isApplyGradeRate)
	self:dispatchEvent(ArcadeSurvivorEvent.OnGameCurrencyChange, currencyId, changeNum, gainPos)
end

function ArcadeSurvivorGameController:forceMoveEntity(entityType, uid, targetGridX, targetGridY, isTween, moveEffectShowId)
	local entityMO = ArcadeSurvivorGameModel.instance:getEntityMO(entityType, uid)

	if not entityMO or entityMO:getIsOffBoard() then
		return false
	end

	local plan = self:_getForceMovePlan(entityMO, targetGridX, targetGridY)

	if not plan then
		return false
	end

	return self:_executeForceMovePlan(entityMO, plan, isTween, moveEffectShowId, false)
end

function ArcadeSurvivorGameController:leaveBoard(entityType, uid)
	local mo = ArcadeSurvivorGameModel.instance:getEntityMO(entityType, uid)

	if not mo or not mo:getIsAlive() then
		return false
	end

	if mo:getIsOffBoard() then
		return true
	end

	local oldBorder = mo:getBorderGridList()

	mo:setOffBoard(true)
	ArcadeSurvivorGameModel.instance:removeOccupyGrid(entityType, uid)

	local scene = self:getGameScene()
	local entity = scene and scene.entityMgr:getEntity(entityType, uid)

	if entity then
		entity:refreshBoardState()
	end

	self:refreshNearEntityHpBar(entityType, uid, oldBorder)
	self:dispatchEvent(ArcadeSurvivorEvent.OnEntityBoardStateChange, entityType, uid)

	return true
end

function ArcadeSurvivorGameController:returnBoard(entityType, uid, x, y)
	local mo = ArcadeSurvivorGameModel.instance:getEntityMO(entityType, uid)

	if not mo or not mo:getIsAlive() or not mo:getIsOffBoard() then
		return false
	end

	local plan = self:_getForceMovePlan(mo, x, y)

	if not plan then
		return false
	end

	return self:_executeForceMovePlan(mo, plan, false, nil, true)
end

function ArcadeSurvivorGameController:_executeForceMovePlan(mo, plan, isTween, showId, isReturn)
	local moves = plan.moves

	moves[#moves + 1] = {
		mo = mo,
		x = plan.x,
		y = plan.y,
		showId = showId,
		isReturn = isReturn
	}

	local model = ArcadeSurvivorGameModel.instance

	for _, move in ipairs(moves) do
		move.oldBorder = move.mo:getBorderGridList()

		model:moveEntityMO(move.mo:getEntityType(), move.mo:getUid(), move.x, move.y, move.isReturn)
	end

	for _, move in ipairs(moves) do
		self:_refreshMovedEntity(move.mo, isTween, move.showId, move.oldBorder, move.isReturn)
	end

	return true, plan.x, plan.y
end

function ArcadeSurvivorGameController:_getForceMovePlan(entityMO, targetGridX, targetGridY)
	local sizeX, sizeY = entityMO:getSize()

	if not ArcadeSurvivorGameHelper.isOutsideMap(targetGridX, targetGridY, sizeX, sizeY) then
		return self:_planForceMoveAt(entityMO, targetGridX, targetGridY)
	end

	return self:_getNearestForceMovePlan(entityMO, targetGridX, targetGridY, sizeX, sizeY)
end

function ArcadeSurvivorGameController:_getNearestForceMovePlan(entityMO, targetGridX, targetGridY, sizeX, sizeY)
	local candidateRingIterator = ArcadeSurvivorGameHelper.iterateNearestPlacementCandidates(targetGridX, targetGridY, sizeX, sizeY)

	if not candidateRingIterator then
		return
	end

	for candidates in candidateRingIterator do
		local candidateCount = #candidates

		for index = candidateCount, 2, -1 do
			local swapIndex = math.random(index)

			candidates[index], candidates[swapIndex] = candidates[swapIndex], candidates[index]
		end

		for _, candidate in ipairs(candidates) do
			local plan = self:_planForceMoveAt(entityMO, candidate.x, candidate.y)

			if plan then
				return plan
			end
		end
	end
end

function ArcadeSurvivorGameController:_planForceMoveAt(entityMO, targetGridX, targetGridY)
	local entityType = entityMO:getEntityType()
	local sizeX, sizeY = entityMO:getSize()
	local layer = ArcadeSurvivorGameEnum.EntityType2Layer[entityType]
	local moves, repeatDict = {}, {}

	for x = targetGridX, targetGridX + sizeX - 1 do
		for y = targetGridY, targetGridY + sizeY - 1 do
			local data = ArcadeSurvivorGameModel.instance:getEntityDataInGrid(x, y, layer)
			local other = data and ArcadeSurvivorGameModel.instance:getEntityMO(data.entityType, data.uid)

			if other and other ~= entityMO and not repeatDict[other] then
				repeatDict[other] = true
				moves[#moves + 1] = {
					mo = other
				}
			end
		end
	end

	local reservedAreas = {
		{
			x = targetGridX,
			y = targetGridY,
			w = sizeX,
			h = sizeY
		}
	}

	for _, move in ipairs(moves) do
		local x, y = ArcadeSurvivorGameModel.instance:getNearestVacantPosition(move.mo, reservedAreas)

		if not x then
			return
		end

		move.x, move.y = x, y

		local w, h = move.mo:getSize()

		reservedAreas[#reservedAreas + 1] = {
			x = x,
			y = y,
			w = w,
			h = h
		}
	end

	return {
		x = targetGridX,
		y = targetGridY,
		moves = moves
	}
end

function ArcadeSurvivorGameController:moveEntity(entityType, uid, targetGridX, targetGridY, isTween, moveEffectShowId)
	local oldBorderGridList
	local isCharacterMove = entityType == ArcadeSurvivorEnum.EntityType.Character

	if isCharacterMove then
		local entityMO = ArcadeSurvivorGameModel.instance:getEntityMO(entityType, uid)

		if entityMO then
			oldBorderGridList = entityMO:getBorderGridList()
		end
	end

	local result = ArcadeSurvivorGameModel.instance:moveEntityMO(entityType, uid, targetGridX, targetGridY)

	if not result then
		return false
	end

	local mo = ArcadeSurvivorGameModel.instance:getEntityMO(entityType, uid)

	self:_refreshMovedEntity(mo, isTween, moveEffectShowId, oldBorderGridList)

	return true
end

function ArcadeSurvivorGameController:_refreshMovedEntity(mo, isTween, moveEffectShowId, oldBorderGridList, isReturn)
	local entityType, uid = mo:getEntityType(), mo:getUid()
	local scene = self:getGameScene()
	local entity = scene and scene.entityMgr:getEntity(entityType, uid)

	if entity then
		entity:refreshPosition(isTween, nil, nil, nil, moveEffectShowId)

		if isReturn then
			entity:refreshBoardState()
		end
	end

	if entityType == ArcadeSurvivorEnum.EntityType.Character then
		self:refreshNearEntityHpBar(entityType, uid, oldBorderGridList)
	end

	self:dispatchEvent(ArcadeSurvivorEvent.OnEntityMove, mo)

	if isReturn then
		self:dispatchEvent(ArcadeSurvivorEvent.OnEntityBoardStateChange, entityType, uid)
	end

	return true
end

function ArcadeSurvivorGameController:refreshNearEntityHpBar(entityType, uid, oldBorderGridList)
	local scene = self:getGameScene()
	local entityMgr = scene and scene.entityMgr

	if not entityMgr then
		return
	end

	local candidateDict = {}
	local targetMO = ArcadeSurvivorGameModel.instance:getEntityMO(entityType, uid)
	local currentBorderGridList = targetMO and targetMO:getBorderGridList()
	local borderGridLists = {
		oldBorderGridList,
		currentBorderGridList
	}

	for _, borderGridList in ipairs(borderGridLists) do
		if borderGridList then
			for index = 1, #borderGridList do
				local gridData = borderGridList[index]
				local gridX = gridData.gridX
				local gridY = gridData.gridY
				local occupyEntityData = ArcadeSurvivorGameModel.instance:getEntityDataInGrid(gridX, gridY)

				if occupyEntityData then
					local occupyEntityType = occupyEntityData.entityType
					local occupyUid = occupyEntityData.uid
					local candidateUidDict = GameUtil.tabletool_checkDictTable(candidateDict, occupyEntityType)

					candidateUidDict[occupyUid] = true
				end
			end
		end
	end

	for candidateEntityType, candidateUidDict in pairs(candidateDict) do
		for candidateUid in pairs(candidateUidDict) do
			local entity = entityMgr:getEntity(candidateEntityType, candidateUid)

			if entity then
				entity:refreshShowHpBar()
			end
		end
	end
end

function ArcadeSurvivorGameController:setAllEntityVisibility(isShow)
	local scene = self:getGameScene()

	if scene then
		scene.entityMgr:setAllEntityIsShow(isShow)
	end
end

function ArcadeSurvivorGameController:playerActOnDirection(direction)
	if not direction then
		return
	end

	local playerCanAct = ArcadeSurvivorGameModel.instance:getCanPlayerAct()

	if not playerCanAct then
		return
	end

	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
	local curGridX, curGridY = characterMO:getGridPos()
	local targetGridX = curGridX + (ArcadeSurvivorEnum.DirChangeGridX[direction] or 0)
	local targetGridY = curGridY + (ArcadeSurvivorEnum.DirChangeGridY[direction] or 0)
	local isOutside = ArcadeSurvivorGameHelper.isOutsideMap(targetGridX, targetGridY)

	if isOutside then
		return
	end

	characterMO:setDirection(direction)
	self:dispatchEvent(ArcadeSurvivorEvent.PlayerDoAction, targetGridX, targetGridY)
end

function ArcadeSurvivorGameController:playerDuel(entityType, uid)
	if entityType ~= ArcadeSurvivorEnum.EntityType.Monster then
		return
	end

	local targetMO = ArcadeSurvivorGameModel.instance:getEntityMO(entityType, uid)

	if not targetMO then
		return
	end

	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
	local direction = characterMO:getDirection()
	local entityMgr = self._gameScene.entityMgr
	local characterEntity = entityMgr:getEntity(characterMO:getEntityType(), characterMO:getUid())

	characterEntity:playActionShow(ArcadeSurvivorEnum.ActionShowId.Duel, direction)

	local characterDuelIsCrit = self:takeDamageOneTarget(characterMO, targetMO)

	if characterDuelIsCrit then
		self:_triggerCritOnce(characterMO, {
			targetMO
		})
	end

	local isTargetAlive = targetMO:getIsAlive()

	if isTargetAlive then
		local targetEntity = entityMgr:getEntity(entityType, uid)
		local hitDirection = ArcadeSurvivorGameHelper.getDirectionGridFromGrid(ArcadeSurvivorEnum.DirChangeGridX[direction], ArcadeSurvivorEnum.DirChangeGridY[direction], 0, 0, true)

		targetEntity:playShow(ArcadeSurvivorGameEnum.Const.DuelFireShowId, hitDirection)

		local targetDuelIsCrit = self:takeDamageOneTarget(targetMO, characterMO)

		if targetDuelIsCrit then
			self:_triggerCritOnce(targetMO, {
				characterMO
			})
		end
	end
end

function ArcadeSurvivorGameController:buyGoods(shopGoodsType, goodsId)
	local canBuy = ArcadeSurvivorGameModel.instance:canBuyGoods(shopGoodsType, goodsId)

	if not canBuy then
		return
	end

	local cost, isUseHp = ArcadeSurvivorGameModel.instance:getGoodsCost(shopGoodsType, goodsId)

	if not cost then
		return
	end

	if isUseHp then
		local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

		if not characterMO or not characterMO:getIsAlive() or cost >= characterMO:getHp() then
			return
		end

		local entityType = characterMO:getEntityType()
		local uid = characterMO:getUid()

		self:changeEntityHp(entityType, uid, -cost)
	else
		local coinId = ArcadeSurvivorEnum.Currency.Coin

		self:changeCurrencyCount(coinId, -cost)

		local ruleModel = ArcadeSurvivorGameModel.instance:getRuleModel()

		ruleModel:onGoodsPurchased(cost, coinId)
	end

	local goodsHandler = ArcadeSurvivorGameEnum.ShopGoodsHandler[shopGoodsType]

	goodsHandler.buyFunc(goodsId)
	self:setGoodsIsLock(shopGoodsType, goodsId, false)

	return true
end

function ArcadeSurvivorGameController:setGoodsIsLock(shopType, goodsId, isLock, index)
	ArcadeSurvivorGameModel.instance:setGoodsIsLock(shopType, goodsId, isLock, index)
end

function ArcadeSurvivorGameController:gainCollection(collectionId)
	local isGamEnd = ArcadeSurvivorGameModel.instance:getGameIsEnd()

	if isGamEnd then
		return
	end

	local cfg = ArcadeSurvivorConfig.instance:getCollectionCfg(collectionId, true)
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if not cfg or not characterMO then
		return
	end

	local isAdded = characterMO:addCollection(collectionId)

	if not isAdded then
		return
	end

	local skillIdList = ArcadeSurvivorConfig.instance:getCollectionMonsterAddSkillIdList(collectionId)

	for _, skillId in ipairs(skillIdList) do
		ArcadeSurvivorGameModel.instance:addMonsterExtraSkill(skillId)
	end

	local ruleModel = ArcadeSurvivorGameModel.instance:getRuleModel()

	ruleModel:onCollectionGained(collectionId)
	ArcadeSurvivorGameModel.instance:addUnlockHandBookItem(ArcadeSurvivorHallEnum.HandBookType.Item, collectionId)
	self:dispatchEvent(ArcadeSurvivorEvent.OnCollectionChange)

	return true
end

function ArcadeSurvivorGameController:replaceCollection(collectionId, targetCollectionIdList)
	local isGameEnd = ArcadeSurvivorGameModel.instance:getGameIsEnd()

	if isGameEnd then
		return
	end

	if not collectionId or not targetCollectionIdList then
		return
	end

	if #targetCollectionIdList <= 0 then
		return
	end

	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if not characterMO then
		return
	end

	local sourceCount = characterMO:getCollectionCount(collectionId)

	if sourceCount <= 0 then
		return
	end

	ArcadeSurvivorGameModel.instance:removeCollection(collectionId, sourceCount)

	local hasGainedTarget = false

	for _, targetCollectionId in ipairs(targetCollectionIdList) do
		local isGained = self:gainCollection(targetCollectionId)

		if isGained then
			hasGainedTarget = true
		end
	end

	if not hasGainedTarget then
		self:dispatchEvent(ArcadeSurvivorEvent.OnCollectionChange)
	end

	return true
end

function ArcadeSurvivorGameController:changeEntityAttr(entityType, uid, attrId, changeVal)
	if not attrId or not changeVal then
		return
	end

	local entityMO = ArcadeSurvivorGameModel.instance:getEntityMO(entityType, uid)

	if not entityMO then
		return
	end

	entityMO:changeAttr(attrId, changeVal)
	self:dispatchEvent(ArcadeSurvivorEvent.OnEntityAttrChange, entityType, uid, attrId, changeVal)
end

function ArcadeSurvivorGameController:changeEntityAttrs(entityType, uid, changeAttrDict, attrIdList)
	if not changeAttrDict then
		return
	end

	local hasChangeAttr = next(changeAttrDict) ~= nil

	if not hasChangeAttr then
		return
	end

	local entityMO = ArcadeSurvivorGameModel.instance:getEntityMO(entityType, uid)

	if not entityMO then
		return
	end

	if not attrIdList then
		attrIdList = {}

		for attrId in pairs(changeAttrDict) do
			attrIdList[#attrIdList + 1] = attrId
		end
	end

	local changedAttrDict = {}

	for _, attrId in ipairs(attrIdList) do
		local changeVal = changeAttrDict[attrId]

		if attrId and changeVal then
			entityMO:changeAttr(attrId, changeVal)

			changedAttrDict[attrId] = changeVal
		end
	end

	local hasChangedAttr = next(changedAttrDict) ~= nil

	if not hasChangedAttr then
		return
	end

	self:dispatchEvent(ArcadeSurvivorEvent.OnEntityChangeAttrDict, entityType, uid, changedAttrDict)
end

function ArcadeSurvivorGameController:takeDamage(attacker, targetList, argsDamage)
	if not targetList or #targetList <= 0 then
		return
	end

	local triggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.Hit
	local context = ArcadeSurvivorGameAttackResultContext.New(triggerPoint, nil, attacker, attacker, targetList)
	local hasCrit = false
	local critTargetList = {}

	for _, targetMO in ipairs(targetList) do
		local isCrit = self:takeDamageOneTarget(attacker, targetMO, argsDamage)

		hasCrit = hasCrit or isCrit

		if isCrit then
			critTargetList[#critTargetList + 1] = targetMO
		end

		context:addHitter(targetMO)
	end

	if hasCrit then
		self:_triggerCritOnce(attacker, critTargetList)
	end

	ArcadeSurvivorGameModel.instance:addRoundHitTargetCount(#targetList)
	ArcadeSurvivorGameTriggerController.instance:trigger(triggerPoint, nil, context)
end

function ArcadeSurvivorGameController:takeDamageOneTarget(attacker, targetMO, argsDamage, killDirectly)
	if not targetMO then
		return
	end

	local isAlive = targetMO:getIsAlive()

	if not killDirectly and not isAlive then
		return
	end

	if targetMO:getIsOffBoard() or targetMO:getIsRespawning() then
		return
	end

	local damage = 0
	local isCrit = false
	local critCount = 0

	if killDirectly then
		damage = targetMO:getHp()
	elseif argsDamage then
		damage = math.floor(argsDamage + 0.5)
	else
		damage, isCrit, critCount = self:_calDamage(attacker, targetMO)
	end

	if isCrit then
		local critTriggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.Crit
		local critContext = ArcadeSurvivorGameAttackResultContext.New(critTriggerPoint, nil, attacker, attacker, {
			targetMO
		})

		critContext:addHitter(targetMO)
		ArcadeSurvivorGameTriggerController.instance:trigger(critTriggerPoint, nil, critContext)
	end

	if damage <= 0 then
		return
	end

	if not killDirectly then
		local beforeDamageEvent = ArcadeSurvivorGameEnum.BuffTickEvent.BeforeDamage
		local damageValueType = ArcadeSurvivorGameEnum.BuffModifyValue.Damage

		damage = targetMO:modifyBuffTickValue(beforeDamageEvent, damageValueType, damage)
	end

	if damage <= 0 then
		return
	end

	self:changeEntityMOHp(targetMO, -damage, critCount)

	if targetMO:getEntityType() == ArcadeSurvivorEnum.EntityType.Character then
		ArcadeSurvivorGameModel.instance:setRoundIsHurt()
	end

	local triggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.Hurt
	local context = ArcadeSurvivorGameAttackResultContext.New(triggerPoint, nil, targetMO, attacker)

	ArcadeSurvivorGameTriggerController.instance:trigger(triggerPoint, nil, context)
	self:_checkDead(targetMO)

	return isCrit
end

function ArcadeSurvivorGameController:_triggerCritOnce(attacker, critTargetList)
	if not attacker then
		return
	end

	local critOnceTriggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.CritOnce
	local critOnceContext = ArcadeSurvivorGameAttackResultContext.New(critOnceTriggerPoint, nil, attacker, attacker, critTargetList)

	if critTargetList then
		for _, targetMO in ipairs(critTargetList) do
			critOnceContext:addHitter(targetMO)
		end
	end

	ArcadeSurvivorGameTriggerController.instance:trigger(critOnceTriggerPoint, nil, critOnceContext)
end

function ArcadeSurvivorGameController:_calDamage(attacker, targetMO)
	local result = 0
	local isCrit = false
	local critCount = 0

	if not attacker then
		return result, isCrit, critCount
	end

	local permillageBase = ArcadeSurvivorEnum.Const.PermillageBase
	local dodgeRate = targetMO and targetMO:getAttrValue(ArcadeSurvivorEnum.Attribute.dodgeRate) or 0
	local randDodgeVal = math.random(permillageBase)

	if randDodgeVal <= dodgeRate then
		local triggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.Dodge
		local context = ArcadeSurvivorGameTriggerContext.New(triggerPoint, nil, targetMO)

		ArcadeSurvivorGameTriggerController.instance:trigger(triggerPoint, nil, context)

		return result, isCrit, critCount
	end

	local atk = attacker:getAttrValue(ArcadeSurvivorEnum.Attribute.atk)
	local dmgAddRate = attacker:getAttrValue(ArcadeSurvivorEnum.Attribute.dmgAddRate)
	local criDmgRate = 0
	local critRate = attacker:getAttrValue(ArcadeSurvivorEnum.Attribute.criRate)
	local randCritVal = math.random(permillageBase)

	if randCritVal <= critRate then
		isCrit = true
		critCount = math.ceil(critRate / permillageBase)
		criDmgRate = attacker:getAttrValue(ArcadeSurvivorEnum.Attribute.criDmgRate)

		local critEvent = ArcadeSurvivorGameEnum.BuffTickEvent.Crit
		local critDmgRateValueType = ArcadeSurvivorGameEnum.BuffModifyValue.CritDamageRate

		criDmgRate = attacker:modifyBuffTickValue(critEvent, critDmgRateValueType, criDmgRate)
	end

	result = atk * (1 + dmgAddRate / permillageBase) * (1 + criDmgRate / permillageBase)

	return math.floor(result + 0.5), isCrit, critCount
end

function ArcadeSurvivorGameController:_checkDead(targetMO)
	if not targetMO then
		return
	end

	if targetMO:getIsDead() or targetMO:getIsRemoving() then
		return
	end

	local isAlive = targetMO:getIsAlive()

	if isAlive then
		return
	end

	local isRespawn = self:_checkRespawn(targetMO)

	if isRespawn then
		return
	end

	local targetEntityType = targetMO:getEntityType()

	if targetEntityType == ArcadeSurvivorEnum.EntityType.Character then
		targetMO:setDead(true)
		self:endGame(ArcadeSurvivorGameEnum.SettleType.Fail, false)

		return
	end

	targetMO:setRemoving(true)

	local deathTriggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.Death
	local deathContext = ArcadeSurvivorGameTriggerContext.New(deathTriggerPoint, nil, targetMO)

	ArcadeSurvivorGameTriggerController.instance:trigger(deathTriggerPoint, nil, deathContext)
	targetMO:setDead(true)

	local isBoss = targetEntityType == ArcadeSurvivorEnum.EntityType.Monster and ArcadeSurvivorConfig.instance:getMonsterType(targetMO:getId()) == ArcadeSurvivorEnum.MonsterType.Boss
	local isLastBoss = false

	if isBoss then
		local aliveBossMOList = ArcadeSurvivorGameModel.instance:getAliveBossMOList()

		isLastBoss = #aliveBossMOList <= 0
	end

	if isLastBoss then
		self._bossDeathMO = targetMO

		self:pauseGame(ArcadeSurvivorGameEnum.StopSource.BossDeath)

		local entity = self._gameScene.entityMgr:getEntity(targetEntityType, targetMO:getUid())

		entity:prepareBossDeath(self._onBossDeathPrepared, self)

		return
	end

	local entity = self._gameScene.entityMgr:getEntity(targetEntityType, targetMO:getUid())

	if entity then
		entity:playDeath(self._finishEntityDeath, self, targetMO)
	else
		self:_finishEntityDeath(targetMO)
	end
end

function ArcadeSurvivorGameController:isPlayingBossDeath()
	return self._bossDeathMO ~= nil
end

function ArcadeSurvivorGameController:_onBossDeathPrepared()
	local mo = self._bossDeathMO

	if not mo then
		return
	end

	local entity = self._gameScene.entityMgr:getEntity(mo:getEntityType(), mo:getUid())

	self._gameScene:focusBoss(entity, self._playBossDeath, self)
end

function ArcadeSurvivorGameController:_playBossDeath()
	local mo = self._bossDeathMO
	local entity = self._gameScene.entityMgr:getEntity(mo:getEntityType(), mo:getUid())

	entity:playBossDeath(self._onBossDeathAnimationFinished, self)
end

function ArcadeSurvivorGameController:_onBossDeathAnimationFinished()
	self._gameScene:restoreBossFocus(self._onBossDeathFinished, self)
end

function ArcadeSurvivorGameController:_onBossDeathFinished()
	local mo = self._bossDeathMO

	self._bossDeathMO = nil

	self:_finishEntityDeath(mo)
	self:resumeGame(ArcadeSurvivorGameEnum.StopSource.BossDeath)
end

function ArcadeSurvivorGameController:_clearBossDeath()
	local mo = self._bossDeathMO

	if not mo then
		return
	end

	self._bossDeathMO = nil

	local scene = self._gameScene
	local entity = scene.entityMgr:getEntity(mo:getEntityType(), mo:getUid())

	if entity then
		entity:cancelBossDeath()
	end

	scene:cancelBossFocus()
	self:resumeGame(ArcadeSurvivorGameEnum.StopSource.BossDeath)
end

function ArcadeSurvivorGameController:_finishEntityDeath(targetMO)
	local targetEntityType = targetMO:getEntityType()
	local targetUid = targetMO:getUid()

	self:removeEntityOne(targetEntityType, targetUid)

	local deathPlaceTriggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.DeathPlace
	local deathPlaceContext = ArcadeSurvivorGameTriggerContext.New(deathPlaceTriggerPoint, nil, targetMO)

	deathPlaceContext:setAllowDeadCaster(true)
	ArcadeSurvivorGameTriggerController.instance:trigger(deathPlaceTriggerPoint, nil, deathPlaceContext)

	local summonerMO = targetMO:getSummonerMO()

	if summonerMO then
		local summonEndTriggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.SummonEnd
		local summonEndContext = ArcadeSurvivorGameTriggerContext.New(summonEndTriggerPoint, nil, summonerMO)

		ArcadeSurvivorGameTriggerController.instance:trigger(summonEndTriggerPoint, nil, summonEndContext)
	end

	if targetEntityType == ArcadeSurvivorEnum.EntityType.Monster then
		local killTriggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.Kill
		local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
		local killContext = ArcadeSurvivorGameTriggerContext.New(killTriggerPoint, nil, characterMO)

		ArcadeSurvivorGameTriggerController.instance:trigger(killTriggerPoint, nil, killContext)
		ArcadeSurvivorGameModel.instance:addResultStatistics(ArcadeSurvivorGameEnum.CustomSaveInfoKey.KillMonsterNum)
		ArcadeSurvivorGameModel.instance:addRoundKillCount()

		local targetId = targetMO:getId()

		self:_checkCharacterUnlock(ArcadeSurvivorGameEnum.CharacterUnlockType.KillMonster, targetId)

		local killCount = ArcadeSurvivorGameModel.instance:getResultStatistics(ArcadeSurvivorGameEnum.CustomSaveInfoKey.KillMonsterNum)

		self:_checkCharacterUnlock(ArcadeSurvivorGameEnum.CharacterUnlockType.TotalKillMonsterCount, killCount)

		local dropCoin = ArcadeSurvivorConfig.instance:getMonsterDropCoin(targetId)

		if dropCoin > 0 then
			local gridX, gridY = targetMO:getGridPos()
			local showIdList = ArcadeSurvivorConfig.instance:getActionShowIdList(ArcadeSurvivorEnum.ActionShowId.DropCoin)
			local dropCoinShowId = showIdList and showIdList[1]

			if dropCoinShowId then
				self._gameScene.effectMgr:playGridShow(dropCoinShowId, gridX, gridY)
			end

			local worldX, worldY, worldZ = ArcadeSurvivorGameHelper.grid2Position(gridX, gridY, true)
			local gainPos = {
				x = worldX,
				y = worldY,
				z = worldZ
			}

			self:changeCurrencyCount(ArcadeSurvivorEnum.Currency.Coin, dropCoin, gainPos, true)
		end

		self:_checkLevelFinish(targetEntityType, targetId)
	end
end

function ArcadeSurvivorGameController:_checkRespawn(targetMO)
	if targetMO:getIsRespawning() then
		return true
	end

	local respawnTimesAttrId = ArcadeSurvivorEnum.Attribute.respawnTimes

	if targetMO:getAttrValue(respawnTimesAttrId) <= 0 then
		return false
	end

	self._respawnMO = targetMO

	targetMO:setRespawning(true)

	local entityType = targetMO:getEntityType()

	if entityType == ArcadeSurvivorEnum.EntityType.Character then
		ArcadeSurvivorStatHelper.instance:recordRespawn()
	end

	targetMO:setHp(targetMO:getAttrValue(ArcadeSurvivorEnum.Attribute.hpCap))
	targetMO:changeAttr(respawnTimesAttrId, ArcadeSurvivorGameEnum.Const.RespawnTimesCost)
	self:pauseGame(ArcadeSurvivorGameEnum.StopSource.Respawn)

	local scene = self:getGameScene()

	self._respawnEntity = scene and scene.entityMgr:getEntity(targetMO:getEntityType(), targetMO:getUid())

	if self._respawnEntity then
		self._respawnEntity:playActionShow(ArcadeSurvivorEnum.ActionShowId.Respawn, nil, nil, self._afterRespawn, self, targetMO)
	else
		self:_afterRespawn(targetMO)
	end

	return true
end

function ArcadeSurvivorGameController:isPlayingRespawn()
	return self._respawnMO ~= nil
end

function ArcadeSurvivorGameController:_afterRespawn(targetMO)
	if self._respawnMO ~= targetMO then
		return
	end

	local triggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.Rebirth
	local context = ArcadeSurvivorGameTriggerContext.New(triggerPoint, nil, targetMO)

	ArcadeSurvivorGameTriggerController.instance:trigger(triggerPoint, nil, context)
	targetMO:setRespawning(false)
	self:dispatchEvent(ArcadeSurvivorEvent.OnChangeEntityHp, targetMO, targetMO:getHp())
	self:dispatchEvent(ArcadeSurvivorEvent.OnEntityAttrChange, targetMO:getEntityType(), targetMO:getUid(), ArcadeSurvivorEnum.Attribute.respawnTimes, ArcadeSurvivorGameEnum.Const.RespawnTimesCost)

	local pendingFinish = self._respawnPendingFinish

	self._respawnMO, self._respawnEntity, self._respawnPendingFinish = nil

	self:resumeGame(ArcadeSurvivorGameEnum.StopSource.Respawn)

	if pendingFinish then
		self:_checkLevelFinish(pendingFinish[1], pendingFinish[2])
	end
end

function ArcadeSurvivorGameController:onRespawnEntityDestroy(entity)
	if self._respawnEntity == entity then
		self:_clearRespawn()
	end
end

function ArcadeSurvivorGameController:_clearRespawn()
	if self._respawnEntity then
		self._respawnEntity:cancelRespawn()
	end

	if self._respawnMO then
		self._respawnMO:setRespawning(false)
	end

	self._respawnMO, self._respawnEntity, self._respawnPendingFinish = nil

	self:resumeGame(ArcadeSurvivorGameEnum.StopSource.Respawn)
end

ArcadeSurvivorGameController.instance = ArcadeSurvivorGameController.New()

return ArcadeSurvivorGameController
