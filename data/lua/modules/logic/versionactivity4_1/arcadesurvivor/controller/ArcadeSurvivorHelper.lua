-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/ArcadeSurvivorHelper.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.ArcadeSurvivorHelper", package.seeall)

local ArcadeSurvivorHelper = _M
local EntityType2CfgGetter = {
	[ArcadeSurvivorEnum.EntityType.Character] = function(id)
		return ArcadeSurvivorConfig.instance:getCharacterCfg(id, true)
	end,
	[ArcadeSurvivorEnum.EntityType.Monster] = function(id)
		return ArcadeSurvivorConfig.instance:getMonsterCfg(id, true)
	end,
	[ArcadeSurvivorEnum.EntityType.Ally] = function(id)
		return ArcadeSurvivorConfig.instance:getAllyCfg(id, true)
	end,
	[ArcadeSurvivorEnum.EntityType.Floor] = function(id)
		return ArcadeSurvivorConfig.instance:getFloorCfg(id, true)
	end
}

function ArcadeSurvivorHelper.getEntityCfg(entityType, id)
	local getter = EntityType2CfgGetter[entityType]

	if not getter then
		logError(string.format("ArcadeSurvivorHelper.getEntityCfg error, not support entityType:%s", entityType))

		return
	end

	return getter(id)
end

function ArcadeSurvivorHelper.getCollectionDisplayRarity(rarity)
	return rarity == 0 and 3 or rarity
end

function ArcadeSurvivorHelper.getAttributeShowValue(attrId, value)
	local showValue = value

	if attrId == ArcadeSurvivorEnum.Attribute.dodgeRate then
		local factor = ArcadeSurvivorEnum.Const.PermillageBase / ArcadeSurvivorEnum.Const.PercentBase

		showValue = value / factor
	end

	return showValue
end

function ArcadeSurvivorHelper.getCollectionDescWithAttr(desc, characterId, characterUnitMO)
	if string.nilorempty(desc) then
		return ""
	end

	local attrValueDict = {}

	if characterUnitMO then
		for key, attrId in pairs(ArcadeSurvivorEnum.Attribute) do
			local value = characterUnitMO:getAttrValue(attrId)

			attrValueDict[key] = value and tostring(value) or 0
		end
	else
		for key, _ in pairs(ArcadeSurvivorEnum.Attribute) do
			local cfg = ArcadeSurvivorConfig.instance:getCharacterCfg(characterId)
			local value = cfg and cfg[key]

			attrValueDict[key] = value and tostring(value) or 0
		end
	end

	return string.gsub(desc, "{([%w]+)}", attrValueDict)
end

return ArcadeSurvivorHelper
