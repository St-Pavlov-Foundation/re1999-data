-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/work/ArcadeRoundBeginWork.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.work.ArcadeRoundBeginWork", package.seeall)

local ArcadeRoundBeginWork = class("ArcadeRoundBeginWork", BaseWork)

function ArcadeRoundBeginWork:onStart(room)
	self._isNeedWait = false

	TaskDispatcher.cancelTask(self._delayDone, self)
	ArcadeGameTriggerController.instance:resetTriggerCount()
	ArcadeGameHelper.tryCallFunc(self.reduceBuffsRound, self)
	ArcadeGameHelper.tryCallFunc(self.updateFloorCountdown, self)
	self:reduceScoreBeginRound()
	self:updateCorpseCountdown()
	self:updateBombCountdown()
	self:_roundBeginFinish()
end

function ArcadeRoundBeginWork:reduceBuffsRound()
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	self:_reduceEntityBuffs(characterMO)

	local monsterMOList = ArcadeGameModel.instance:getMonsterList()

	if monsterMOList then
		for _, monsterMO in ipairs(monsterMOList) do
			self:_reduceEntityBuffs(monsterMO)
		end
	end

	local gridMOList = ArcadeGameModel.instance:getGridMOList()

	if gridMOList then
		for _, gridMO in ipairs(gridMOList) do
			self:_reduceEntityBuffs(gridMO)
		end
	end
end

function ArcadeRoundBeginWork:_reduceEntityBuffs(entityMO)
	local buffSetMO = entityMO and entityMO:getBuffSetMO()

	if buffSetMO then
		local entityType = entityMO:getEntityType()
		local uid = entityMO:getUid()
		local removeBuffList = buffSetMO:checkBuffsReduceInRoundBegin()

		ArcadeGameController.instance:removeEntityBuffs(removeBuffList, entityType, uid)
	end
end

function ArcadeRoundBeginWork:reduceScoreBeginRound()
	local negativeRoundLimit = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.NegativeRoundLimit, true)
	local curNegativeRound = ArcadeGameModel.instance:getNegativeOperationRound()

	if negativeRoundLimit < curNegativeRound then
		local subCount = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.SubScoreInRound, true)

		ArcadeGameController.instance:changeResCount(ArcadeGameEnum.CharacterResource.Score, subCount)
	end
end

function ArcadeRoundBeginWork:updateCorpseCountdown()
	local monsterList = ArcadeGameModel.instance:getMonsterList()

	if not monsterList or #monsterList <= 0 then
		return
	end

	local removeList = {}
	local corpseKeepTime = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.CorpseKeepTime, true)

	for _, monsterMO in ipairs(monsterList) do
		local isDead = monsterMO:getIsDead()
		local hasCorpse = monsterMO:getHasCorpse()

		if isDead and hasCorpse then
			local curCorpseTime = monsterMO:getCorpseTime()

			if corpseKeepTime <= curCorpseTime then
				removeList[#removeList + 1] = monsterMO
			else
				monsterMO:addCorpseTime()
			end
		end
	end

	for _, monsterMO in ipairs(removeList) do
		ArcadeGameController.instance:removeDeadEntityAndDrop(monsterMO, true)
	end
end

function ArcadeRoundBeginWork:updateBombCountdown()
	local bombMOList = ArcadeGameModel.instance:getEntityMOList(ArcadeGameEnum.EntityType.Bomb)

	if not bombMOList or #bombMOList <= 0 then
		return
	end

	local scene = ArcadeGameController.instance:getGameScene()
	local isBombAddFloor = ArcadeGameModel.instance:getGameSwitchIsOn(ArcadeGameEnum.GameSwitch.BombAddBurning)
	local bombEffectIdList = ArcadeConfig.instance:getActionShowEffectIdList(ArcadeGameEnum.ActionShowId.BombRange)
	local bombEffId = bombEffectIdList and bombEffectIdList[1]
	local warnEffectIdList = ArcadeConfig.instance:getActionShowEffectIdList(ArcadeGameEnum.ActionShowId.BombWarn)
	local warnEffId = warnEffectIdList and warnEffectIdList[1]

	for _, bombMO in ipairs(bombMOList) do
		bombMO:addLiveRound()

		local bombId = bombMO:getId()
		local gridX, gridY = bombMO:getGridPos()
		local targetId = ArcadeConfig.instance:getBombTarget(bombId)
		local targetSelector = ArcadeSkillFactory.instance:createSkillTargetById(targetId)

		if targetSelector then
			local addBombRange = ArcadeGameModel.instance:getGameAttribute(ArcadeGameEnum.GameAttribute.AddBombRange)

			targetSelector:setRadius(addBombRange)
		end

		local isExplode = bombMO:getIsExplode()

		if isExplode then
			local targetMOList, gridMOList

			if targetSelector then
				targetSelector:findTarget(gridX, gridY)

				local targetList = targetSelector:getTargetList()

				if targetList then
					targetMOList = tabletool.copy(targetList)
				end

				targetSelector:setTargetTypeList({
					ArcadeGameEnum.EntityType.Grid
				})
				targetSelector:findTarget(gridX, gridY)

				targetList = targetSelector:getTargetList()

				if targetList then
					gridMOList = tabletool.copy(targetList)
				end
			end

			ArcadeGameController.instance:enterAttackFlow(ArcadeGameEnum.AttackType.Bomb, bombMO, targetMOList)

			if scene and gridMOList then
				local floorDataList = {}
				local addFloorId = ArcadeConfig.instance:getBombAddFloor(bombId)

				for i, gridMO in ipairs(gridMOList) do
					local floorX, floorY = gridMO:getGridPos()

					scene.effectMgr:playEffect2Grid(bombEffId, floorX, floorY)
					scene.effectMgr:removeEffect(warnEffId, floorX, floorY, true)

					floorDataList[i] = {
						id = addFloorId,
						x = floorX,
						y = floorY
					}
				end

				if isBombAddFloor and addFloorId and addFloorId ~= 0 then
					ArcadeGameFloorController.instance:tryAddFloorByList(floorDataList)
				end
			end

			local uid = bombMO:getUid()

			ArcadeGameController.instance:removeEntity(ArcadeGameEnum.EntityType.Bomb, uid)

			self._isNeedWait = true
		else
			local gridMOList

			if targetSelector then
				targetSelector:setTargetTypeList({
					ArcadeGameEnum.EntityType.Grid
				})
				targetSelector:findTarget(gridX, gridY)

				gridMOList = targetSelector:getTargetList()
			end

			if gridMOList then
				for _, gridMO in ipairs(gridMOList) do
					local x, y = gridMO:getGridPos()

					scene.effectMgr:playEffect2Grid(warnEffId, x, y)
				end
			end
		end
	end
end

function ArcadeRoundBeginWork:updateFloorCountdown()
	local entityType = ArcadeGameEnum.EntityType.Floor
	local floorMOList = ArcadeGameModel.instance:getEntityMOList(entityType)

	if not floorMOList or #floorMOList < 1 then
		return
	end

	local removeUidList

	for _, floorMO in ipairs(floorMOList) do
		local cdRound = floorMO:getCdRound() + 1
		local limitRound = floorMO:getLimitRound()

		floorMO:setCdRound(cdRound)

		if limitRound <= cdRound and limitRound ~= -1 then
			removeUidList = removeUidList or {}

			table.insert(removeUidList, floorMO:getUid())
		end
	end

	if removeUidList and #removeUidList > 0 then
		for _, floorUid in ipairs(removeUidList) do
			ArcadeGameController.instance:removeEntity(entityType, floorUid)
		end
	end
end

function ArcadeRoundBeginWork:_roundBeginFinish()
	local waitTime = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.RoundBeginWaitTime, true) or 0

	if self._isNeedWait and waitTime > 0 then
		TaskDispatcher.cancelTask(self._delayDone, self)
		TaskDispatcher.runDelay(self._delayDone, self, waitTime)
	else
		self:_delayDone()
	end

	self._isNeedWait = false
end

function ArcadeRoundBeginWork:_delayDone()
	TaskDispatcher.cancelTask(self._delayDone, self)
	self:onDone(true)
end

function ArcadeRoundBeginWork:clearWork()
	self._isNeedWait = false

	TaskDispatcher.cancelTask(self._delayDone, self)
end

return ArcadeRoundBeginWork
