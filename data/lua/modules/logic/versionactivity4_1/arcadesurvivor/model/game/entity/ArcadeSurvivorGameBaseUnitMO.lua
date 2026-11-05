-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/entity/ArcadeSurvivorGameBaseUnitMO.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.entity.ArcadeSurvivorGameBaseUnitMO", package.seeall)

local ArcadeSurvivorGameBaseUnitMO = class("ArcadeSurvivorGameBaseUnitMO")

function ArcadeSurvivorGameBaseUnitMO:ctor(entityType, id, uid, gridX, gridY, sizeX, sizeY, ...)
	self._entityType = entityType
	self._id = id
	self._uid = uid
	self._isOffBoard = false

	self:setSize(sizeX, sizeY)
	self:setGridPos(gridX, gridY)
	self:setDirection()

	self._attrSet = ArcadeSurvivorGameAttributeSet.New(self)

	local hpCap = self:getAttrValue(ArcadeSurvivorEnum.Attribute.hpCap)

	self:setHp(hpCap)

	self._buffSet = ArcadeSurvivorGameBuffSet.New(self)
	self._skillSet = ArcadeSurvivorGameSkillSet.New(self)

	self:onCtor(...)
end

function ArcadeSurvivorGameBaseUnitMO:changeHp(value)
	local changeVal = 0
	local changeHpVal = tonumber(value)

	if not changeHpVal or changeHpVal == 0 then
		return changeVal
	end

	if changeHpVal < 0 and self:getIsOffBoard() then
		return changeVal
	end

	local oldHp = self:getHp()
	local newHp = self:setHp(oldHp + changeHpVal)

	changeVal = newHp - oldHp

	return changeVal
end

function ArcadeSurvivorGameBaseUnitMO:addSkill(skillId, sourceType, sourceId)
	local skillSet = self:getSkillSet()

	if skillSet then
		return skillSet:addSkill2Set(skillId, sourceType, sourceId)
	end
end

function ArcadeSurvivorGameBaseUnitMO:removeSkill(skillId, sourceType, sourceId)
	local skillSet = self:getSkillSet()

	if skillSet then
		skillSet:removeSkillInSet(skillId, sourceType, sourceId)
	end
end

function ArcadeSurvivorGameBaseUnitMO:addBuff(buffId, stackCount, casterMO)
	local buffSet = self:getBuffSet()

	if buffSet then
		buffSet:addBuff2Set(buffId, stackCount, casterMO)
	end
end

function ArcadeSurvivorGameBaseUnitMO:onBuffTickEvent(ev, context)
	local buffSet = self:getBuffSet()

	if not buffSet then
		return
	end

	local copyBuffList = {}

	for index, buff in ipairs(buffSet:getBuffList()) do
		copyBuffList[index] = buff
	end

	local isTurnEndEv = ev == ArcadeSurvivorGameEnum.BuffTickEvent.TurnEnd

	for _, buff in ipairs(copyBuffList) do
		buff:onReceiveTickEvent(ev, context)

		if isTurnEndEv then
			buff:onTurnEnd()
		end
	end
end

function ArcadeSurvivorGameBaseUnitMO:modifyBuffTickValue(ev, valueType, value)
	local buffSet = self:getBuffSet()

	if not buffSet then
		return value
	end

	local buffList = buffSet:getBuffList()
	local result = value

	for index = 1, #buffList do
		local buff = buffList[index]

		result = buff:modifyTickValue(ev, valueType, result)
	end

	return result
end

function ArcadeSurvivorGameBaseUnitMO:removeBuff(buffId, stackCount)
	local buffSet = self:getBuffSet()

	if buffSet then
		buffSet:removeBuffInSet(buffId, stackCount)
	end
end

function ArcadeSurvivorGameBaseUnitMO:setOffBoard(value)
	self._isOffBoard = value
end

function ArcadeSurvivorGameBaseUnitMO:getIsOffBoard()
	return self._isOffBoard == true
end

function ArcadeSurvivorGameBaseUnitMO:setSize(sizeX, sizeY)
	local minimumSize = ArcadeSurvivorEnum.Const.MinimumEntitySize

	self._sizeX = sizeX or minimumSize
	self._sizeY = sizeY or minimumSize
end

function ArcadeSurvivorGameBaseUnitMO:setGridPos(gridX, gridY)
	self._gridX = gridX or 0
	self._gridY = gridY or 0
end

function ArcadeSurvivorGameBaseUnitMO:setDirection(dir)
	dir = dir or ArcadeSurvivorGameEnum.Const.DefaultDirection
	self._direction = dir

	self:_setEntityForwardDirection(dir)
end

function ArcadeSurvivorGameBaseUnitMO:_setEntityForwardDirection(dir)
	if dir ~= ArcadeSurvivorEnum.Direction.Right and dir ~= ArcadeSurvivorEnum.Direction.Left then
		return
	end

	self._forwardDirection = dir
end

function ArcadeSurvivorGameBaseUnitMO:setSummon(summonerMO)
	self._isSummon = true
	self._summonerMO = summonerMO
end

function ArcadeSurvivorGameBaseUnitMO:getSummonerMO()
	return self._summonerMO
end

function ArcadeSurvivorGameBaseUnitMO:changeAttr(attrId, value)
	if attrId == ArcadeSurvivorEnum.Attribute.hp then
		self:changeHp(value)
	else
		local attrSet = self:getAttrSet()

		if attrSet then
			attrSet:changeAttrIncrease(attrId, value)
		end

		local hpCapAttrId = ArcadeSurvivorEnum.Attribute.hpCap

		if attrId == hpCapAttrId then
			local curHp = self:getHp()
			local newHpCap = self:getAttrValue(hpCapAttrId)

			if newHpCap < curHp then
				self:setHp(newHpCap)
			end
		end
	end
end

function ArcadeSurvivorGameBaseUnitMO:setHp(value)
	local hpVal = tonumber(value) or 0
	local hpCap = self:getAttrValue(ArcadeSurvivorEnum.Attribute.hpCap)

	self._curHp = Mathf.Clamp(hpVal, 0, hpCap)

	return self._curHp
end

function ArcadeSurvivorGameBaseUnitMO:setRemoving(isRemoving)
	self._isRemoving = isRemoving
end

function ArcadeSurvivorGameBaseUnitMO:setRespawning(isRespawning)
	self._isRespawning = isRespawning
end

function ArcadeSurvivorGameBaseUnitMO:setDead(isDead)
	self._isDead = isDead
end

function ArcadeSurvivorGameBaseUnitMO:getEntityType()
	return self._entityType
end

function ArcadeSurvivorGameBaseUnitMO:getId()
	return self._id
end

function ArcadeSurvivorGameBaseUnitMO:getUid()
	return self._uid
end

function ArcadeSurvivorGameBaseUnitMO:getCfg()
	local entityType = self:getEntityType()
	local id = self:getId()

	return ArcadeSurvivorHelper.getEntityCfg(entityType, id)
end

function ArcadeSurvivorGameBaseUnitMO:getSize()
	local minimumSize = ArcadeSurvivorEnum.Const.MinimumEntitySize
	local sizeX = self._sizeX or minimumSize
	local sizeY = self._sizeY or minimumSize

	return sizeX, sizeY
end

function ArcadeSurvivorGameBaseUnitMO:getGridPos()
	return self._gridX or 0, self._gridY or 0
end

function ArcadeSurvivorGameBaseUnitMO:getGridPosRect()
	local sizeX, sizeY = self:getSize()
	local minX, minY = self:getGridPos()
	local maxX = minX + sizeX - 1
	local maxY = minY + sizeY - 1

	return minX, minY, maxX, maxY
end

function ArcadeSurvivorGameBaseUnitMO:getBorderGridList()
	local result = {}
	local gridX, gridY = self:getGridPos()
	local sizeX, sizeY = self:getSize()

	if not gridX or not gridY or not sizeX or not sizeY then
		return result
	end

	local mapSizeX, mapSizeY = ArcadeSurvivorGameModel.instance:getMapSize()
	local minimumCoordinate = ArcadeSurvivorGameEnum.Const.MinimumCoordinate

	if mapSizeX <= 0 or mapSizeY <= 0 then
		return result
	end

	local leftGridX = gridX - 1
	local hasLeft = minimumCoordinate <= leftGridX
	local rightGridX = gridX + sizeX
	local hasRight = rightGridX <= mapSizeX

	for y = gridY, gridY + sizeY - 1 do
		if minimumCoordinate <= y and y <= mapSizeY then
			if hasLeft then
				result[#result + 1] = {
					gridX = leftGridX,
					gridY = y
				}
			end

			if hasRight then
				result[#result + 1] = {
					gridX = rightGridX,
					gridY = y
				}
			end
		end
	end

	local bottomGridY = gridY - 1
	local hasBottom = minimumCoordinate <= bottomGridY
	local topGridY = gridY + sizeY
	local hasTop = topGridY <= mapSizeY

	for x = gridX, gridX + sizeX - 1 do
		if minimumCoordinate <= x and x <= mapSizeX then
			if hasBottom then
				result[#result + 1] = {
					gridX = x,
					gridY = bottomGridY
				}
			end

			if hasTop then
				result[#result + 1] = {
					gridX = x,
					gridY = topGridY
				}
			end
		end
	end

	return result
end

function ArcadeSurvivorGameBaseUnitMO:getDirection(isForward)
	if isForward then
		return self._forwardDirection
	else
		return self._direction
	end
end

function ArcadeSurvivorGameBaseUnitMO:getIsSummon()
	return self._isSummon
end

function ArcadeSurvivorGameBaseUnitMO:getScale()
	local cfg = self:getCfg()
	local scaleArr = cfg and cfg.scale

	if scaleArr and type(scaleArr) == "table" then
		local scaleX = tonumber(scaleArr[1])
		local scaleY = tonumber(scaleArr[2])

		return scaleX, scaleY
	end
end

function ArcadeSurvivorGameBaseUnitMO:getPosOffset()
	local cfg = self:getCfg()
	local posArr = cfg and cfg.posOffset

	if posArr and type(posArr) == "table" then
		local posX = tonumber(posArr[1])
		local posY = tonumber(posArr[2])

		return posX, posY
	end
end

function ArcadeSurvivorGameBaseUnitMO:getIsRemoving()
	return self._isRemoving
end

function ArcadeSurvivorGameBaseUnitMO:getIsRespawning()
	return self._isRespawning
end

function ArcadeSurvivorGameBaseUnitMO:getIsAlive()
	local isDead = self:getIsDead()
	local hp = self:getHp()

	return not isDead and hp > 0
end

function ArcadeSurvivorGameBaseUnitMO:getIsDead()
	return self._isDead
end

function ArcadeSurvivorGameBaseUnitMO:getStateShowIdList()
	local result = {}
	local stateShowId
	local isDead = self:getIsDead()

	if isDead then
		stateShowId = ArcadeSurvivorConfig.instance:getStateShowShowId(ArcadeSurvivorEnum.StateShowId.Dead)
	else
		stateShowId = self:getIdleShowId()
	end

	result[#result + 1] = stateShowId

	if not isDead then
		local buffSetMO = self:getBuffSet()
		local buffList = buffSetMO and buffSetMO:getBuffList()

		if buffList then
			for _, buffMO in ipairs(buffList) do
				if buffMO:getIsActive() then
					local buffId = buffMO:getId()
					local loopShowId = ArcadeSurvivorConfig.instance:getBuffLoopShow(buffId)

					if loopShowId and loopShowId ~= 0 then
						result[#result + 1] = loopShowId
					end
				end
			end
		end
	end

	return result
end

function ArcadeSurvivorGameBaseUnitMO:getIsHaveHPBar()
	local entityType = self:getEntityType()

	return entityType == ArcadeSurvivorEnum.EntityType.Monster or entityType == ArcadeSurvivorEnum.EntityType.Character
end

function ArcadeSurvivorGameBaseUnitMO:getHpPos()
	local cfg = self:getCfg()
	local hpPosArr = cfg and cfg.hpPos

	if hpPosArr then
		return tonumber(hpPosArr[1]), tonumber(hpPosArr[2])
	end
end

function ArcadeSurvivorGameBaseUnitMO:getBuffSet()
	return self._buffSet
end

function ArcadeSurvivorGameBaseUnitMO:getBuff(buffId)
	local buffSet = self:getBuffSet()

	return buffSet:getBuffInSet(buffId)
end

function ArcadeSurvivorGameBaseUnitMO:getSkillSet()
	return self._skillSet
end

function ArcadeSurvivorGameBaseUnitMO:getSkillStackList(skillId)
	local skillSet = self:getSkillSet()

	return skillSet and skillSet:getSkillStackListInSet(skillId)
end

function ArcadeSurvivorGameBaseUnitMO:hasSkill(skillId)
	local skillSet = self:getSkillSet()

	if not skillSet then
		return false
	end

	return skillSet:hasSkillInSet(skillId)
end

function ArcadeSurvivorGameBaseUnitMO:getSkillByUid(skillId, skillUid)
	local skillSet = self:getSkillSet()

	if not skillSet then
		return
	end

	return skillSet:getSkillByUidInSet(skillId, skillUid)
end

function ArcadeSurvivorGameBaseUnitMO:hasWaitDelayHit(skillId)
	local skillSet = self:getSkillSet()

	if not skillSet then
		return false
	end

	return skillSet:hasWaitDelayHitInSet(skillId)
end

function ArcadeSurvivorGameBaseUnitMO:clearSkillTriggerCounts()
	local skillSet = self:getSkillSet()

	if skillSet then
		skillSet:clearTriggerCounts()
	end
end

function ArcadeSurvivorGameBaseUnitMO:getTriggerSkillList(triggerPointWithParam)
	local skillSet = self:getSkillSet()

	return skillSet and skillSet:getTriggerSkillListInSet(triggerPointWithParam)
end

function ArcadeSurvivorGameBaseUnitMO:getAttrSet()
	return self._attrSet
end

function ArcadeSurvivorGameBaseUnitMO:getAttrValue(attrId)
	local result = 0

	if attrId == ArcadeSurvivorEnum.Attribute.hp then
		result = self:getHp()
	else
		local attrSet = self:getAttrSet()

		result = attrSet and attrSet:getAttrValue(attrId) or 0
	end

	return result
end

function ArcadeSurvivorGameBaseUnitMO:getHp()
	return self._curHp or 0
end

function ArcadeSurvivorGameBaseUnitMO:onCtor(...)
	return
end

function ArcadeSurvivorGameBaseUnitMO:getName()
	local cfg = self:getCfg()

	return cfg and cfg.name
end

function ArcadeSurvivorGameBaseUnitMO:getDesc()
	local cfg = self:getCfg()

	return cfg and cfg.desc
end

function ArcadeSurvivorGameBaseUnitMO:getIcon()
	local cfg = self:getCfg()

	return cfg and cfg.icon
end

function ArcadeSurvivorGameBaseUnitMO:getTipIsUseImg()
	return false
end

function ArcadeSurvivorGameBaseUnitMO:getResName()
	logError("ArcadeSurvivorGameBaseUnitMO.getResName error, need override this func")
end

function ArcadeSurvivorGameBaseUnitMO:getImgOffsetArr()
	return
end

function ArcadeSurvivorGameBaseUnitMO:getImgScaleArr()
	return
end

function ArcadeSurvivorGameBaseUnitMO:getMonsterType()
	return
end

function ArcadeSurvivorGameBaseUnitMO:getWeaponSkillIdList()
	return
end

function ArcadeSurvivorGameBaseUnitMO:getTreeId()
	return
end

function ArcadeSurvivorGameBaseUnitMO:getNextMoveGrid()
	return
end

function ArcadeSurvivorGameBaseUnitMO:getIdleShowId()
	local idleShowId = ArcadeSurvivorConfig.instance:getStateShowShowId(ArcadeSurvivorEnum.StateShowId.Idle)

	return idleShowId
end

return ArcadeSurvivorGameBaseUnitMO
