-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/handbook/ArcadeSurvivorHandBookCharacterMO.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.handbook.ArcadeSurvivorHandBookCharacterMO", package.seeall)

local ArcadeSurvivorHandBookCharacterMO = class("ArcadeSurvivorHandBookCharacterMO", ArcadeSurvivorHandBookMO)

function ArcadeSurvivorHandBookCharacterMO:_initAttribute()
	local cfg = self:getCfg()

	self._attributeDict = {}
	self._attributeDict[ArcadeSurvivorEnum.Attribute.atk] = cfg.atk or 0
	self._attributeDict[ArcadeSurvivorEnum.Attribute.hpCap] = cfg.hpCap or 0
	self._attributeDict[ArcadeSurvivorEnum.Attribute.dodgeRate] = cfg.dodgeRate or 0
end

function ArcadeSurvivorHandBookCharacterMO:_initEffect()
	local id = self:getId()

	self._effectDict = {}

	local weaponCollectionId = ArcadeSurvivorConfig.instance:getCharacterWeaponCollectionId(id)
	local collectionId = ArcadeSurvivorConfig.instance:getCharacterCollectionId(id)

	self._effectDict[ArcadeSurvivorEnum.EffectType.Weapon] = ArcadeSurvivorHandBookCollectionMO.New(weaponCollectionId)
	self._effectDict[ArcadeSurvivorEnum.EffectType.Collection] = ArcadeSurvivorHandBookCollectionMO.New(collectionId)
end

function ArcadeSurvivorHandBookCharacterMO:getBigIcon()
	local id = self:getId()

	return ArcadeSurvivorConfig.instance:getCharacterPortrait(id)
end

function ArcadeSurvivorHandBookCharacterMO:getCfg()
	local id = self:getId()

	return ArcadeSurvivorHelper.getEntityCfg(ArcadeSurvivorEnum.EntityType.Character, id)
end

function ArcadeSurvivorHandBookCharacterMO:getLockTip()
	local id = self:getId()

	return ArcadeSurvivorConfig.instance:getCharacterLockTip(id)
end

return ArcadeSurvivorHandBookCharacterMO
