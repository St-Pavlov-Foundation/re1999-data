-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/work/ArcadeSurvivorEntityWork.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.work.ArcadeSurvivorEntityWork", package.seeall)

local ArcadeSurvivorEntityWork = class("ArcadeSurvivorEntityWork", BaseWork)

function ArcadeSurvivorEntityWork:onStart()
	self._phase = 1
	self._monsterIndex = 1
	self._weaponIndex = 1

	self:_continueWork()
end

function ArcadeSurvivorEntityWork:_continueWork()
	while not ArcadeSurvivorGameModel.instance:getIsPauseGame() and not ArcadeSurvivorGameModel.instance:getGameIsEnd() do
		if self._phase == 1 then
			self._phase = 2

			self:_beginMonsterTurn()
		elseif self._phase == 2 then
			if not self:_tickMonsterBT() then
				return
			end

			self._phase = 3
		elseif self._phase == 3 then
			if not self:_releasePlayerWeaponSkills() then
				return
			end

			self._phase = 4
		elseif self._phase == 4 then
			self._phase = 5

			self:_endEntityWork()
		else
			self:onDone(true)

			return
		end
	end
end

function ArcadeSurvivorEntityWork:_beginMonsterTurn()
	local triggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.MonTurnBegin
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
	local context = ArcadeSurvivorGameTriggerContext.New(triggerPoint, nil, characterMO)

	ArcadeSurvivorGameTriggerController.instance:trigger(triggerPoint, nil, context)
end

function ArcadeSurvivorEntityWork:_tickMonsterBT()
	local monsterMOList = ArcadeSurvivorGameModel.instance:getEntityMOList(ArcadeSurvivorEnum.EntityType.Monster)

	if not monsterMOList then
		return true
	end

	local scene = ArcadeSurvivorGameController.instance:getGameScene()

	if not scene then
		return true
	end

	self._monsterList = self._monsterList or tabletool.copy(monsterMOList)

	while self._monsterIndex <= #self._monsterList do
		local monsterMO = self._monsterList[self._monsterIndex]

		self._monsterIndex = self._monsterIndex + 1

		if monsterMO:getIsAlive() then
			local entity = scene.entityMgr:getEntity(monsterMO:getEntityType(), monsterMO:getUid())

			if entity then
				entity:btTick()
			end
		end

		if ArcadeSurvivorGameModel.instance:getIsPauseGame() or ArcadeSurvivorGameModel.instance:getGameIsEnd() then
			return false
		end
	end

	return true
end

function ArcadeSurvivorEntityWork:_releasePlayerWeaponSkills()
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if not characterMO then
		return true
	end

	local entityType = characterMO:getEntityType()
	local uid = characterMO:getUid()
	local skillIdList = characterMO:getWeaponSkillIdList()
	local isSkillCdReady = self:_isWeaponSkillCdReady(characterMO)

	if not isSkillCdReady then
		return true
	end

	local skillCount = #skillIdList

	while skillCount >= self._weaponIndex do
		local skillId = skillIdList[self._weaponIndex]

		self._weaponIndex = self._weaponIndex + 1

		local isCast = ArcadeSurvivorGameSkillController.instance:castSkill(entityType, uid, skillId)

		self._hasCastSkill = self._hasCastSkill or isCast

		if ArcadeSurvivorGameModel.instance:getIsPauseGame() or ArcadeSurvivorGameModel.instance:getGameIsEnd() then
			return false
		end
	end

	if self._hasCastSkill then
		local curRound = ArcadeSurvivorGameModel.instance:getCurRound()

		characterMO:setLastWeaponSkillCastRound(curRound)
	end

	return true
end

function ArcadeSurvivorEntityWork:_isWeaponSkillCdReady(characterMO)
	local lastCastRound = characterMO:getLastWeaponSkillCastRound()

	if not lastCastRound then
		return true
	end

	local curRound = ArcadeSurvivorGameModel.instance:getCurRound()
	local characterId = characterMO:getId()
	local cdInterval = ArcadeSurvivorConfig.instance:getCharacterAtkInterval(characterId)
	local isCdReady = cdInterval <= curRound - lastCastRound

	return isCdReady
end

function ArcadeSurvivorEntityWork:_endEntityWork()
	local triggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.MonTurnEnd
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()
	local context = ArcadeSurvivorGameTriggerContext.New(triggerPoint, nil, characterMO)

	ArcadeSurvivorGameTriggerController.instance:trigger(triggerPoint, nil, context)
end

function ArcadeSurvivorEntityWork:onUpdate()
	self:_continueWork()
end

function ArcadeSurvivorEntityWork:clearWork()
	self._phase, self._monsterIndex, self._weaponIndex = nil
	self._monsterList, self._hasCastSkill = nil
end

return ArcadeSurvivorEntityWork
