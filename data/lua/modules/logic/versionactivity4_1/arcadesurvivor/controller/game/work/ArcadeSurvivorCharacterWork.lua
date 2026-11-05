-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/work/ArcadeSurvivorCharacterWork.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.work.ArcadeSurvivorCharacterWork", package.seeall)

local ArcadeSurvivorCharacterWork = class("ArcadeSurvivorCharacterWork", BaseWork)

function ArcadeSurvivorCharacterWork:onStart()
	self._passTime = 0
	self._turnTime = ArcadeSurvivorGameModel.instance:getCharacterTurnTime()

	ArcadeSurvivorGameController.instance:registerCallback(ArcadeSurvivorEvent.PlayerDoAction, self._onPlayerDoAction, self)
	ArcadeSurvivorGameController.instance:beginPlayerTurn()

	local triggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.CharTurnBegin
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if characterMO then
		characterMO:setTurnMoveDirection(nil)
	end

	local context = ArcadeSurvivorGameTriggerContext.New(triggerPoint, nil, characterMO)

	ArcadeSurvivorGameTriggerController.instance:trigger(triggerPoint, nil, context)

	self._pendingBegin = true

	self:_finishBegin()
end

function ArcadeSurvivorCharacterWork:_finishBegin()
	if ArcadeSurvivorGameModel.instance:getIsPauseGame() then
		return
	end

	if not self:_triggerOtherEntityTurnSkills(ArcadeSurvivorGameEnum.TriggerPoint.CharTurnBegin) then
		return
	end

	self._pendingBegin = nil

	ArcadeSurvivorGameController.instance:dispatchEvent(ArcadeSurvivorEvent.OnPlayerTurnStart)
end

function ArcadeSurvivorCharacterWork:resetCountdown()
	if self._pendingEnd or self._pendingEndOther or self._pendingDuel or not self._passTime then
		return
	end

	self._passTime = 0

	ArcadeSurvivorGameController.instance:dispatchEvent(ArcadeSurvivorEvent.OnPlayerTurnUpdate, self._passTime, self._turnTime)
end

function ArcadeSurvivorCharacterWork:onUpdate()
	if self._pendingBegin then
		self:_finishBegin()

		return
	end

	if self._pendingEndOther then
		self:_finishEnd()

		return
	end

	if self._pendingDuel then
		self._pendingDuel = nil

		self:_triggerDuel()
		self:_endCharacterWork()

		return
	end

	if self._pendingEnd then
		self._pendingEnd = nil

		self:_endCharacterWork()

		return
	end

	if not self._passTime or not self._turnTime then
		return
	end

	self._passTime = self._passTime + Time.deltaTime

	if self._passTime > self._turnTime then
		self:_endCharacterWork()
	end

	ArcadeSurvivorGameController.instance:dispatchEvent(ArcadeSurvivorEvent.OnPlayerTurnUpdate, self._passTime, self._turnTime)
end

function ArcadeSurvivorCharacterWork:_onPlayerDoAction(targetGridX, targetGridY)
	if ArcadeSurvivorGameModel.instance:getIsPauseGame() then
		return
	end

	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if not characterMO or not targetGridX or not targetGridY then
		return
	end

	local haveAction = false
	local entityData = ArcadeSurvivorGameModel.instance:getEntityDataInGrid(targetGridX, targetGridY)
	local targetEntityType = entityData and entityData.entityType

	if not entityData or targetEntityType == ArcadeSurvivorEnum.EntityType.Character then
		local characterUid = characterMO:getUid()
		local characterEntityType = characterMO:getEntityType()
		local gridX, gridY = characterMO:getGridPos()
		local isMoved = ArcadeSurvivorGameController.instance:moveEntity(characterEntityType, characterUid, targetGridX, targetGridY, true)

		if isMoved then
			characterMO:setTurnMoveDirection(ArcadeSurvivorGameHelper.getDirectionGridFromGrid(gridX, gridY, targetGridX, targetGridY))
		end

		local triggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.Move
		local context = ArcadeSurvivorGameTriggerContext.New(triggerPoint, nil, characterMO)

		ArcadeSurvivorGameTriggerController.instance:trigger(triggerPoint, nil, context)

		haveAction = true
	elseif targetEntityType == ArcadeSurvivorEnum.EntityType.Monster then
		self._duelTargetMO = ArcadeSurvivorGameModel.instance:getEntityMO(targetEntityType, entityData.uid)
		self._duelTargetGridX, self._duelTargetGridY = targetGridX, targetGridY

		ArcadeSurvivorGameController.instance:playerDuel(targetEntityType, entityData.uid)

		if ArcadeSurvivorGameController.instance:isPlayingRespawn() then
			self._pendingDuel = true
		else
			self:_triggerDuel()
		end

		haveAction = true
	end

	if haveAction then
		ArcadeSurvivorGameController.instance:unregisterCallback(ArcadeSurvivorEvent.PlayerDoAction, self._onPlayerDoAction, self)

		if not self._pendingDuel then
			self:_endCharacterWork()
		end
	end
end

function ArcadeSurvivorCharacterWork:_endCharacterWork()
	self:_moveToDefeatedDuelTarget()

	if ArcadeSurvivorGameModel.instance:getGameIsEnd() then
		return
	end

	if ArcadeSurvivorGameController.instance:isPlayingRespawn() then
		self._pendingEnd = true

		return
	end

	ArcadeSurvivorGameController.instance:endPlayerTurn()

	local triggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.CharTurnEnd
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
	local context = ArcadeSurvivorGameTriggerContext.New(triggerPoint, nil, characterMO)

	ArcadeSurvivorGameTriggerController.instance:trigger(triggerPoint, nil, context)

	self._pendingEndOther = true

	self:_finishEnd()
end

function ArcadeSurvivorCharacterWork:_moveToDefeatedDuelTarget()
	local targetMO = self._duelTargetMO

	if not targetMO or ArcadeSurvivorGameController.instance:isPlayingRespawn() then
		return
	end

	local targetGridX, targetGridY = self._duelTargetGridX, self._duelTargetGridY

	self._duelTargetMO, self._duelTargetGridX, self._duelTargetGridY = nil

	local model = ArcadeSurvivorGameModel.instance
	local characterMO = model:getCharacterMO()

	if not targetMO:getIsDead() or not characterMO or not characterMO:getIsAlive() or model:getGameIsEnd() then
		return
	end

	model:removeOccupyGrid(targetMO:getEntityType(), targetMO:getUid())

	local gridX, gridY = characterMO:getGridPos()

	if gridX == targetGridX and gridY == targetGridY then
		return
	end

	local isMoved = ArcadeSurvivorGameController.instance:moveEntity(characterMO:getEntityType(), characterMO:getUid(), targetGridX, targetGridY, true)

	if not isMoved then
		return
	end

	characterMO:setTurnMoveDirection(ArcadeSurvivorGameHelper.getDirectionGridFromGrid(gridX, gridY, targetGridX, targetGridY))

	local triggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.Move
	local context = ArcadeSurvivorGameTriggerContext.New(triggerPoint, nil, characterMO)

	ArcadeSurvivorGameTriggerController.instance:trigger(triggerPoint, nil, context)
end

function ArcadeSurvivorCharacterWork:_finishEnd()
	if ArcadeSurvivorGameModel.instance:getIsPauseGame() then
		return
	end

	if not self:_triggerOtherEntityTurnSkills(ArcadeSurvivorGameEnum.TriggerPoint.CharTurnEnd) then
		return
	end

	self._pendingEndOther = nil

	self:onDone(true)
end

function ArcadeSurvivorCharacterWork:_triggerDuel()
	local triggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.Duel
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
	local context = ArcadeSurvivorGameTriggerContext.New(triggerPoint, nil, characterMO)

	ArcadeSurvivorGameTriggerController.instance:trigger(triggerPoint, nil, context)
end

function ArcadeSurvivorCharacterWork:_triggerOtherEntityTurnSkills(triggerPoint)
	local triggerEntityTypes = {
		ArcadeSurvivorEnum.EntityType.Ally,
		ArcadeSurvivorEnum.EntityType.Floor
	}
	local entityTypeIndex = self._otherEntityIndex or 1
	local moIndex = self._otherMOIndex or 1

	while entityTypeIndex <= #triggerEntityTypes do
		local entityType = triggerEntityTypes[entityTypeIndex]
		local entityMOList = ArcadeSurvivorGameModel.instance:getEntityMOList(entityType)

		if entityMOList then
			local entityCount = #entityMOList

			while moIndex <= entityCount do
				local entityMO = entityMOList[moIndex]

				moIndex = moIndex + 1

				local context = ArcadeSurvivorGameTriggerContext.New(triggerPoint, nil, entityMO)

				ArcadeSurvivorGameTriggerController.instance:trigger(triggerPoint, nil, context)

				if ArcadeSurvivorGameModel.instance:getIsPauseGame() or ArcadeSurvivorGameModel.instance:getGameIsEnd() then
					self._otherEntityIndex = entityTypeIndex
					self._otherMOIndex = moIndex

					return false
				end
			end
		end

		entityTypeIndex = entityTypeIndex + 1
		moIndex = 1
	end

	self._otherEntityIndex = nil
	self._otherMOIndex = nil

	return true
end

function ArcadeSurvivorCharacterWork:clearWork()
	self._duelTargetMO, self._duelTargetGridX, self._duelTargetGridY = nil
	self._pendingDuel, self._pendingEnd = nil
	self._pendingBegin, self._pendingEndOther = nil
	self._otherEntityIndex, self._otherMOIndex = nil
	self._passTime = nil

	ArcadeSurvivorGameController.instance:unregisterCallback(ArcadeSurvivorEvent.PlayerDoAction, self._onPlayerDoAction, self)
end

return ArcadeSurvivorCharacterWork
