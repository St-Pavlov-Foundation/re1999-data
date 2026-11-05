-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/entity/set/ArcadeSurvivorGameBaseSet.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.entity.set.ArcadeSurvivorGameBaseSet", package.seeall)

local ArcadeSurvivorGameBaseSet = class("ArcadeSurvivorGameBaseSet")

function ArcadeSurvivorGameBaseSet:ctor(unitMO)
	self._unitMO = unitMO
	self._genUid = 0

	self:onCtor()
end

function ArcadeSurvivorGameBaseSet:_generateUid()
	self._genUid = self._genUid + 1

	return self._genUid
end

function ArcadeSurvivorGameBaseSet:getUnitMO()
	return self._unitMO
end

function ArcadeSurvivorGameBaseSet:onCtor()
	return
end

return ArcadeSurvivorGameBaseSet
