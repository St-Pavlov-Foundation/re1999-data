-- chunkname: @modules/logic/fight/system/work/FightWorkYiFuLinMove394.lua

module("modules.logic.fight.system.work.FightWorkYiFuLinMove394", package.seeall)

local FightWorkYiFuLinMove394 = class("FightWorkYiFuLinMove394", FightEffectBase)
local EFFECT_SELECT = "v4a1_yfl/yfl_innate1_01"
local EFFECT_OTHER = "v4a1_yfl/yfl_innate1_02"
local AUDIO_ID = 431600141

function FightWorkYiFuLinMove394:ctor(fightStepData, actEffectData)
	if fightStepData then
		fightStepData.custom_ingoreParallelSkill = true
	end

	FightWorkYiFuLinMove394.super.ctor(self, fightStepData, actEffectData)
end

function FightWorkYiFuLinMove394:onStart()
	self._performanceTime = 2 / FightModel.instance:getSpeed()

	self:com_registTimer(self._delayDone, 5)

	self._cacheEntityIds = {}

	local flow = self:com_registFlowParallel()

	flow:registWork(FightWorkFunction, self._playEffects, self)

	local sequence = flow:registWork(FightWorkFlowSequence)

	sequence:registWork(FightWorkDelayTimer, 0.3)
	sequence:registWork(FightWorkFunction, self._swapPositions, self)
	flow:registWork(FightWorkDelayTimer, 1)
	self:playWorkAndDone(flow)
end

function FightWorkYiFuLinMove394:_playEffects()
	local arr = FightStrUtil.instance:getSplitCache(self.actEffectData.reserveStr, "|")

	if #arr <= 0 then
		return
	end

	local newPos2MO, participantIds = self:_buildNewPosData(arr)
	local oldPos2MO = self:_buildOldPosData(newPos2MO, participantIds)

	for _, id in ipairs(participantIds) do
		table.insert(self._cacheEntityIds, id)
	end

	local hostEntity = self:_findEffectHost(participantIds)

	if not hostEntity then
		return
	end

	local hasEffect = false

	for pos, oldMO in pairs(oldPos2MO) do
		if newPos2MO[pos] ~= oldMO then
			self:_playEffectAtPos(hostEntity, pos, oldMO)

			hasEffect = true
		end
	end

	for pos, newMO in pairs(newPos2MO) do
		if not oldPos2MO[pos] then
			self:_playEffectAtPos(hostEntity, pos, newMO, EFFECT_OTHER)

			hasEffect = true
		end
	end

	if hasEffect then
		AudioMgr.instance:trigger(AUDIO_ID)
	end
end

function FightWorkYiFuLinMove394:_buildNewPosData(arr)
	local newPos2MO = {}
	local participantIds = {}
	local oldPosDict = self.actEffectData.custom_oldPosDict

	for i, v in ipairs(arr) do
		local arr1 = FightStrUtil.instance:getSplitCache(v, "#")
		local entityId = arr1[1]
		local entityMO = FightDataHelper.entityMgr:getById(entityId)

		if entityMO then
			newPos2MO[entityMO.position] = entityMO

			if oldPosDict and oldPosDict[entityId] then
				table.insert(participantIds, entityMO.id)
			end
		end
	end

	return newPos2MO, participantIds
end

function FightWorkYiFuLinMove394:_buildOldPosData(newPos2MO, participantIds)
	local oldPos2MO = {}
	local participantSet = {}

	for _, id in ipairs(participantIds) do
		participantSet[id] = true
	end

	local battleId = FightModel.instance:getBattleId()
	local battleCo = battleId and lua_battle.configDict[battleId]
	local totalPositions = battleCo and battleCo.playerMax or 3
	local entityList = FightDataHelper.entityMgr:getMyNormalList()

	if entityList then
		for _, entityMO in ipairs(entityList) do
			local pos = entityMO.position

			if pos and pos > 0 and pos <= totalPositions and not participantSet[entityMO.id] then
				oldPos2MO[pos] = entityMO
			end
		end
	end

	local oldPosDict = self.actEffectData.custom_oldPosDict

	if oldPosDict then
		for _, entityMO in pairs(newPos2MO) do
			local oldPos = oldPosDict[entityMO.id]

			if oldPos then
				oldPos2MO[oldPos] = entityMO
			end
		end
	end

	return oldPos2MO
end

function FightWorkYiFuLinMove394:_findEffectHost(participantIds)
	for _, id in ipairs(participantIds) do
		local entity = FightHelper.getEntity(id)

		if entity and entity.effect then
			return entity
		end
	end

	return nil
end

function FightWorkYiFuLinMove394:_playEffectAtPos(hostEntity, pos, occupantMO, forceEffectName)
	if not occupantMO then
		return
	end

	local effectName = forceEffectName

	if not effectName then
		effectName = EFFECT_OTHER

		if occupantMO:hasBuffFeature(FightEnum.BuffFeature.PositionSortSelect) then
			effectName = EFFECT_SELECT
		end
	end

	local effectWrap = hostEntity.effect:addGlobalEffect(effectName, nil, self._performanceTime)

	effectWrap:setRenderOrder(20000)

	local needBackfill = occupantMO.position ~= pos
	local backupPos

	if needBackfill then
		backupPos = occupantMO.position
		occupantMO.position = pos
	end

	local posX, posY, posZ = FightHelper.getEntityStandPos(occupantMO)

	if needBackfill then
		occupantMO.position = backupPos
	end

	effectWrap:setWorldPos(posX, posY, posZ)
end

function FightWorkYiFuLinMove394:_swapPositions()
	for i, id in ipairs(self._cacheEntityIds) do
		local entity = FightHelper.getEntity(id)

		if entity then
			entity:resetStandPos()

			local entityMO = entity:getMO()

			if entityMO and entity.setScale then
				local _, _, _, scale = FightHelper.getEntityStandPos(entityMO)

				if scale then
					entity:setScale(scale)
				end
			end

			FightController.instance:dispatchEvent(FightEvent.UpdateUIFollower, entity.id)
		end
	end
end

function FightWorkYiFuLinMove394:_delayDone()
	self:onDone(true)
end

function FightWorkYiFuLinMove394:clearWork()
	if self._cacheEntityIds then
		for i, v in ipairs(self._cacheEntityIds) do
			local entity = FightHelper.getEntity(v)

			if entity and entity.effect then
				entity.effect:refreshAllEffectLabel1()
			end
		end
	end

	FightRenderOrderMgr.instance:setSortType(FightEnum.RenderOrderType.StandPos)
end

return FightWorkYiFuLinMove394
