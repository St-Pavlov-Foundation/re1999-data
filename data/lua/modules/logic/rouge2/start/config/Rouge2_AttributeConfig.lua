-- chunkname: @modules/logic/rouge2/start/config/Rouge2_AttributeConfig.lua

module("modules.logic.rouge2.start.config.Rouge2_AttributeConfig", package.seeall)

local Rouge2_AttributeConfig = class("Rouge2_AttributeConfig", BaseConfig)

function Rouge2_AttributeConfig:onInit()
	return
end

function Rouge2_AttributeConfig:reqConfigNames()
	return {
		"rouge2_attribute",
		"rouge2_passive_skill"
	}
end

function Rouge2_AttributeConfig:onConfigLoaded(configName, configTable)
	if configName == "rouge2_attribute" then
		self:_onLoadAttributeConfigs(configTable)
	end
end

function Rouge2_AttributeConfig:_onLoadAttributeConfigs(configTable)
	self._id2LevelList = {}
	self._type2AttributeList = {}

	for _, attributeCo in ipairs(configTable.configList) do
		local type = attributeCo.type

		self._type2AttributeList[type] = self._type2AttributeList[type] or {}

		table.insert(self._type2AttributeList[type], attributeCo)

		local attributeId = attributeCo.id

		self._id2LevelList[attributeId] = GameUtil.splitString2(attributeCo.level)
	end

	for _, attributeList in pairs(self._type2AttributeList) do
		table.sort(attributeList, function(aCo, bCo)
			return aCo.level < bCo.level
		end)
	end

	for _, levelList in pairs(self._id2LevelList) do
		table.sort(levelList, function(aLevel, bLevel)
			return aLevel[1] < bLevel[2]
		end)
	end
end

function Rouge2_AttributeConfig:getAttributeConfig(attributeId)
	attributeId = tonumber(attributeId)

	local attributeCo = lua_rouge2_attribute.configDict[attributeId]

	if not attributeCo then
		logError(string.format("肉鸽属性配置为空 attributeId = %s", attributeId))

		return
	end

	return attributeCo
end

function Rouge2_AttributeConfig:getPassiveSkillConfig(skillId, level)
	level = level or 1

	local skillCoDict = lua_rouge2_passive_skill.configDict[skillId]
	local skillCo = skillCoDict and skillCoDict[level]

	if not skillCo then
		logError(string.format("肉鸽特性技能配置为空 skillId = %s, level = %s", skillId, level))
	end

	return skillCo
end

function Rouge2_AttributeConfig:attributeIdAndValue2LevelConfig(attributeId, attributeValue)
	local levelList = self._id2LevelList and self._id2LevelList[tonumber(attributeId)]

	if not levelList or #levelList <= 0 then
		logError(string.format("肉鸽属性评级文本配置不存在 attributeId = %s, attributeValue = %s", attributeId, attributeValue))

		return
	end

	local targetCo

	for _, levelCo in ipairs(levelList) do
		if attributeValue < levelCo[1] then
			break
		end

		targetCo = levelCo
	end

	return targetCo
end

function Rouge2_AttributeConfig:getAttributeEffectDescList(attributeId, attributeValue)
	local levelCo = self:attributeIdAndValue2LevelConfig(attributeId, attributeValue)
	local desc = levelCo and levelCo[3]

	return desc
end

function Rouge2_AttributeConfig:getAttributeLevelKeyworld(attributeId, attributeValue)
	local levelCo = self:attributeIdAndValue2LevelConfig(attributeId, attributeValue)
	local level = levelCo and levelCo[2]

	return level
end

function Rouge2_AttributeConfig:getAttributeLevelContent(attributeId, attributeValue)
	local levelCo = self:attributeIdAndValue2LevelConfig(attributeId, attributeValue)
	local level = levelCo and levelCo[3]

	return level
end

function Rouge2_AttributeConfig:getPassiveSkillCo(careerId, attributeId, level)
	local skillId = Rouge2_CareerConfig.instance:getCareerPassiveSkillId(careerId, attributeId)

	return skillId and self:getPassiveLevelSkillCo(skillId, level)
end

function Rouge2_AttributeConfig:getPassiveLevelSkillCo(passiveSkillId, level)
	local skillMap = lua_rouge2_passive_skill.configDict[passiveSkillId]
	local skillCo = skillMap and skillMap[level]

	if not skillCo then
		logError(string.format("肉鸽特性技能配置不存在 passiveSkillId = %s, level = %s", passiveSkillId, level))
	end

	return skillCo
end

function Rouge2_AttributeConfig:getPassiveSkillCommonDesc(careerId, attributeId, level)
	local skillCo = self:getPassiveSkillCo(careerId, attributeId, level)
	local descStr = skillCo and skillCo.desc or ""

	if string.nilorempty(descStr) then
		return
	end

	local descList = string.split(descStr, "|")
	local resultDescList = {}

	for _, desc in ipairs(descList) do
		local resultDesc = Rouge2_ItemExpressionHelper.getDescResult(nil, nil, desc)

		table.insert(resultDescList, resultDesc)
	end

	return resultDescList
end

function Rouge2_AttributeConfig:getPassiveSkillEffectDescList(careerId, attributeId, level)
	local skillCo = self:getPassiveSkillCo(careerId, attributeId, level)
	local effectDesc = skillCo and skillCo.effectDesc or ""

	if string.nilorempty(effectDesc) then
		return
	end

	local effectDescList = string.split(effectDesc, "|")
	local resultDescList = {}

	for _, effectDesc in ipairs(effectDescList) do
		local resultDesc = Rouge2_ItemExpressionHelper.getDescResult(nil, nil, effectDesc)

		table.insert(resultDescList, resultDesc)
	end

	return resultDescList
end

function Rouge2_AttributeConfig:getPassiveSkillDescList(careerId, attributeId, level)
	local descList = {}
	local commonDescList = self:getPassiveSkillCommonDesc(careerId, attributeId, level)
	local effectDescList = self:getPassiveSkillEffectDescList(careerId, attributeId, level)

	tabletool.addValues(descList, commonDescList)
	tabletool.addValues(descList, effectDescList)

	return descList
end

function Rouge2_AttributeConfig:getNextSpPassiveSkill(careerId, attrId, attrValue)
	local skillNum = #lua_rouge2_passive_skill.configList

	for i = attrValue + 1, skillNum do
		local skillCo = self:getPassiveSkillCo(careerId, attrId, i)

		if not skillCo then
			return
		end

		local isSpecial = skillCo and skillCo.isSpecial

		if isSpecial and isSpecial ~= 0 then
			return i, skillCo
		end
	end
end

Rouge2_AttributeConfig.instance = Rouge2_AttributeConfig.New()

return Rouge2_AttributeConfig
