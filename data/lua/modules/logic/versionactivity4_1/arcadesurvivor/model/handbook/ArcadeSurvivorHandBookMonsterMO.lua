-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/handbook/ArcadeSurvivorHandBookMonsterMO.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.handbook.ArcadeSurvivorHandBookMonsterMO", package.seeall)

local ArcadeSurvivorHandBookMonsterMO = class("ArcadeSurvivorHandBookMonsterMO", ArcadeSurvivorHandBookMO)

function ArcadeSurvivorHandBookMonsterMO:_initAttribute()
	local cfg = self:getCfg()

	self._attributeDict = {}
	self._attributeDict[ArcadeSurvivorEnum.Attribute.atk] = cfg.atk or 0
	self._attributeDict[ArcadeSurvivorEnum.Attribute.hpCap] = cfg.hpCap or 0
end

function ArcadeSurvivorHandBookMonsterMO:getCfg()
	local id = self:getId()

	return ArcadeSurvivorHelper.getEntityCfg(ArcadeSurvivorEnum.EntityType.Monster, id)
end

function ArcadeSurvivorHandBookMonsterMO:getBigIconTrans()
	local id = self:getId()
	local icon2Offset2 = ArcadeSurvivorConfig.instance:getMonsterIconOffset2(id)
	local anchorX = icon2Offset2 and tonumber(icon2Offset2[1]) or 0
	local anchorY = icon2Offset2 and tonumber(icon2Offset2[2]) or 0
	local iconScale2 = ArcadeSurvivorConfig.instance:getMonsterIconScale2(id)
	local scaleX = iconScale2 and tonumber(iconScale2[1]) or 1
	local scaleY = iconScale2 and tonumber(iconScale2[2]) or 1

	return anchorX, anchorY, scaleX, scaleY
end

return ArcadeSurvivorHandBookMonsterMO
