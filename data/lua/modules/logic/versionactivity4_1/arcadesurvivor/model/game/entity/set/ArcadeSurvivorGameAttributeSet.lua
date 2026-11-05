-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/entity/set/ArcadeSurvivorGameAttributeSet.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.entity.set.ArcadeSurvivorGameAttributeSet", package.seeall)

local ArcadeSurvivorGameAttributeSet = class("ArcadeSurvivorGameAttributeSet", ArcadeSurvivorGameBaseSet)

function ArcadeSurvivorGameAttributeSet:onCtor()
	self._attrDict = {}
	self._attrList = {}

	local hpMul = 0
	local atkMul = 0
	local unitMO = self:getUnitMO()
	local cfg = unitMO:getCfg()
	local entityType = unitMO:getEntityType()

	if entityType == ArcadeSurvivorEnum.EntityType.Monster then
		hpMul, atkMul = self:_getMonsterBaseAddPermille()
	end

	for attrName, attrId in pairs(ArcadeSurvivorEnum.Attribute) do
		if attrId ~= ArcadeSurvivorEnum.Attribute.hp then
			local base = cfg and cfg[attrName] or 0

			if attrId == ArcadeSurvivorEnum.Attribute.hpCap then
				base = base * (1 + hpMul / ArcadeSurvivorEnum.Const.PermillageBase)
			elseif attrId == ArcadeSurvivorEnum.Attribute.atk then
				base = base * (1 + atkMul / ArcadeSurvivorEnum.Const.PermillageBase)
			end

			local attrMO = ArcadeSurvivorGameAttribute.New(attrId, base)

			self._attrDict[attrId] = attrMO

			table.insert(self._attrList, attrMO)
		end
	end
end

function ArcadeSurvivorGameAttributeSet:_getMonsterBaseAddPermille()
	local levelHpMul = 0
	local levelAtkMul = 0
	local difficultyHpMul = 0
	local difficultyAtkMul = 0
	local levelId = ArcadeSurvivorGameModel.instance:getCurLevelId()
	local difficultyId = ArcadeSurvivorGameModel.instance:getDifficulty()

	if levelId then
		levelHpMul = ArcadeSurvivorConfig.instance:getLevelHpMul(levelId)
		levelAtkMul = ArcadeSurvivorConfig.instance:getLevelAtkMul(levelId)
	end

	if difficultyId then
		difficultyHpMul = ArcadeSurvivorConfig.instance:getDifficultyHpMul(difficultyId)
		difficultyAtkMul = ArcadeSurvivorConfig.instance:getDifficultyAtkMul(difficultyId)
	end

	local hpMul = levelHpMul + difficultyHpMul + levelHpMul * difficultyHpMul / ArcadeSurvivorEnum.Const.PermillageBase
	local atkMul = levelAtkMul + difficultyAtkMul + levelAtkMul * difficultyAtkMul / ArcadeSurvivorEnum.Const.PermillageBase

	return hpMul, atkMul
end

function ArcadeSurvivorGameAttributeSet:changeAttrIncrease(attrId, changeVal)
	local attrMO = self:_getAttribute(attrId)

	if not attrMO then
		return
	end

	attrMO:changeIncrease(changeVal)
end

function ArcadeSurvivorGameAttributeSet:getAttrList()
	return self._attrList
end

function ArcadeSurvivorGameAttributeSet:_getAttribute(attrId)
	return self._attrDict[attrId]
end

function ArcadeSurvivorGameAttributeSet:getAttrValue(attrId)
	if attrId == ArcadeSurvivorEnum.Attribute.respawnTimes then
		local unitMO = self:getUnitMO()
		local entityType = unitMO and unitMO:getEntityType()

		if entityType == ArcadeSurvivorEnum.EntityType.Character then
			local characterId = unitMO:getId()
			local respawnNeedHpCap = ArcadeSurvivorConfig.instance:getCharacterRespawnNeedHpCap(characterId)

			if respawnNeedHpCap > 0 then
				local hpCapAttr = self:_getAttribute(ArcadeSurvivorEnum.Attribute.hpCap)
				local hpCap = hpCapAttr and hpCapAttr:getValue() or 0
				local respawnTimes = math.ceil(hpCap / respawnNeedHpCap) - 1

				return math.max(0, respawnTimes)
			end
		end
	end

	local result = 0
	local attr = self:_getAttribute(attrId)

	if attr then
		result = attr:getValue()
	end

	return result
end

function ArcadeSurvivorGameAttributeSet:reset()
	for _, attr in ipairs(self._attrList) do
		attr:reset()
	end
end

return ArcadeSurvivorGameAttributeSet
