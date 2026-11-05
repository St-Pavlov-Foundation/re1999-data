-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/develop/ArcadeSurvivorTalentMO.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.develop.ArcadeSurvivorTalentMO", package.seeall)

local ArcadeSurvivorTalentMO = class("ArcadeSurvivorTalentMO")

function ArcadeSurvivorTalentMO:ctor(id, cfgList)
	self.id = id
	self.cfgList = cfgList
	self._skillIds = {}
	self._maxLevel = ArcadeSurvivorConfig.instance:getTalentMaxLevel(self.id)

	self:setLevel()
end

function ArcadeSurvivorTalentMO:refreshInfo(info)
	self:setLevel(info and info.level)
end

function ArcadeSurvivorTalentMO:setLevel(level)
	self._level = level or 0
end

function ArcadeSurvivorTalentMO:getId()
	return self.id
end

function ArcadeSurvivorTalentMO:getLevel()
	return self._level
end

function ArcadeSurvivorTalentMO:getMaxLevel()
	return self._maxLevel
end

function ArcadeSurvivorTalentMO:getLevelCfg(level)
	return self.cfgList[level]
end

function ArcadeSurvivorTalentMO:getCurLevelCfg()
	return self:getLevelCfg(self._level)
end

function ArcadeSurvivorTalentMO:getNextLevelCfg()
	return self:getLevelCfg(self._level + 1)
end

function ArcadeSurvivorTalentMO:getSkillIdsByLevel(level)
	if level <= 0 then
		return
	end

	local skillIds = self._skillIds[level]

	if not skillIds then
		local skills = ArcadeSurvivorConfig.instance:getTalentSkill(self.id, level)

		if string.nilorempty(skills) then
			return
		end

		skillIds = string.splitToNumber(skills, "#")
		self._skillIds[level] = skillIds
	end

	return skillIds
end

function ArcadeSurvivorTalentMO:getDisplayType()
	return ArcadeSurvivorConfig.instance:getTalentDisplayType(self.id, self._level)
end

function ArcadeSurvivorTalentMO:isMaxLevel()
	local nextCfg = self:getNextLevelCfg()

	return not nextCfg
end

function ArcadeSurvivorTalentMO:getCost()
	local result = 0
	local maxLevel = self:getMaxLevel()
	local nextLevel = self._level + 1

	if nextLevel <= maxLevel then
		result = ArcadeSurvivorConfig.instance:getTalentCost(self.id, nextLevel)
	end

	return result
end

function ArcadeSurvivorTalentMO:canUpLV()
	local isMaxLevel = self:isMaxLevel()

	if isMaxLevel then
		return false
	end

	local values = ArcadeSurvivorOutSideModel.instance:getOutsideCurrencyCount(ArcadeSurvivorEnum.Currency.Diamond)
	local curNum = values or 0
	local isEnough = curNum >= self:getCost()

	return isEnough
end

function ArcadeSurvivorTalentMO:isLock()
	return self._level < ArcadeSurvivorHallEnum.Const.MinTalentLevel
end

function ArcadeSurvivorTalentMO:getIcon()
	return ArcadeSurvivorConfig.instance:getTalentIcon(self.id)
end

return ArcadeSurvivorTalentMO
