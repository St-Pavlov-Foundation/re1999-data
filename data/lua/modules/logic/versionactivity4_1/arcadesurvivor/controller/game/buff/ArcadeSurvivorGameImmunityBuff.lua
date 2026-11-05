-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/buff/ArcadeSurvivorGameImmunityBuff.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.buff.ArcadeSurvivorGameImmunityBuff", package.seeall)

local ArcadeSurvivorGameImmunityBuff = class("ArcadeSurvivorGameImmunityBuff", ArcadeSurvivorGameBaseBuff)

function ArcadeSurvivorGameImmunityBuff:onCtor()
	self:_setTickEvent(ArcadeSurvivorGameEnum.BuffTickEvent.BeforeDamage)
	self:_setValueType(ArcadeSurvivorGameEnum.BuffModifyValue.Damage)
end

function ArcadeSurvivorGameImmunityBuff:_onModifyValue(value)
	return true, 0
end

return ArcadeSurvivorGameImmunityBuff
