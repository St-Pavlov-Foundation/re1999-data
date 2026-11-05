-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/buff/ArcadeSurvivorGameCritOverflowBuff.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.buff.ArcadeSurvivorGameCritOverflowBuff", package.seeall)

local ArcadeSurvivorGameCritOverflowBuff = class("ArcadeSurvivorGameCritOverflowBuff", ArcadeSurvivorGameBaseBuff)

function ArcadeSurvivorGameCritOverflowBuff:onCtor()
	self:_setTickEvent(ArcadeSurvivorGameEnum.BuffTickEvent.Crit)
	self:_setValueType(ArcadeSurvivorGameEnum.BuffModifyValue.CritDamageRate)
end

function ArcadeSurvivorGameCritOverflowBuff:_onModifyValue(value)
	local unitMO = self:getUnitMO()

	if not unitMO then
		return false, value
	end

	local newVal = value
	local criRate = unitMO:getAttrValue(ArcadeSurvivorEnum.Attribute.criRate)
	local overflowRate = criRate - ArcadeSurvivorEnum.Const.PermillageBase

	if overflowRate > 0 then
		newVal = value + overflowRate
	end

	return true, newVal
end

return ArcadeSurvivorGameCritOverflowBuff
