-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/buff/ArcadeSurvivorGamePoisonNoDecayBuff.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.buff.ArcadeSurvivorGamePoisonNoDecayBuff", package.seeall)

local ArcadeSurvivorGamePoisonNoDecayBuff = class("ArcadeSurvivorGamePoisonNoDecayBuff", ArcadeSurvivorGameBaseBuff)

function ArcadeSurvivorGamePoisonNoDecayBuff:onCtor()
	self:_setTickEvent(ArcadeSurvivorGameEnum.BuffTickEvent.PoisonNoDecayTick)
	self:_setValueType(ArcadeSurvivorGameEnum.BuffModifyValue.PoisonBuffNotConsume)
end

function ArcadeSurvivorGamePoisonNoDecayBuff:_onModifyValue(value)
	return true, true
end

return ArcadeSurvivorGamePoisonNoDecayBuff
