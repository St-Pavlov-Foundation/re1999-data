-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/develop/ArcadeSurvivorHeroMO.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.develop.ArcadeSurvivorHeroMO", package.seeall)

local ArcadeSurvivorHeroMO = class("ArcadeSurvivorHeroMO")

function ArcadeSurvivorHeroMO:ctor(handbookMO)
	self.handbookMO = handbookMO
	self.cfg = handbookMO:getCfg()
	self.id = handbookMO:getId()
end

function ArcadeSurvivorHeroMO:checkEquip(equipId)
	self._isEquip = equipId == self.id
end

function ArcadeSurvivorHeroMO:checkSelect(selectId)
	self._isSelect = selectId == self.id
end

function ArcadeSurvivorHeroMO:setNew(isNew)
	self._isNew = isNew
end

function ArcadeSurvivorHeroMO:getId()
	return self.id
end

function ArcadeSurvivorHeroMO:getCfg()
	return self.cfg
end

function ArcadeSurvivorHeroMO:isSelect()
	return self._isSelect
end

function ArcadeSurvivorHeroMO:isEquip()
	return self._isEquip
end

function ArcadeSurvivorHeroMO:isNew()
	return self._isNew
end

function ArcadeSurvivorHeroMO:getHandbookMO()
	return self.handbookMO
end

function ArcadeSurvivorHeroMO:isLock()
	local handbookMO = self:getHandbookMO()

	return handbookMO:isLock()
end

function ArcadeSurvivorHeroMO:getEffectDict()
	local handbookMO = self:getHandbookMO()

	return handbookMO:getEffectDict()
end

function ArcadeSurvivorHeroMO:getAttributeDict()
	local handbookMO = self:getHandbookMO()

	return handbookMO:getAttributeDict()
end

function ArcadeSurvivorHeroMO:getReddotKey()
	local id = self:getId()

	return ArcadeSurvivorHallEnum.PlayerPrefsKey.DevelopHeroNew, id
end

function ArcadeSurvivorHeroMO:getPlayUnlockAnimKey()
	local id = self:getId()

	return ArcadeSurvivorHallEnum.PlayerPrefsKey.DevelopHeroPlayUnlockAnim, id
end

return ArcadeSurvivorHeroMO
