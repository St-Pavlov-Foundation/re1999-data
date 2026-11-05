-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/buff/ArcadeSurvivorGameDamageLockBuff.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.buff.ArcadeSurvivorGameDamageLockBuff", package.seeall)

local ArcadeSurvivorGameDamageLockBuff = class("ArcadeSurvivorGameDamageLockBuff", ArcadeSurvivorGameBaseBuff)

function ArcadeSurvivorGameDamageLockBuff:onCtor()
	self:_setTickEvent(ArcadeSurvivorGameEnum.BuffTickEvent.BeforeDamage)
	self:_setValueType(ArcadeSurvivorGameEnum.BuffModifyValue.Damage)
end

function ArcadeSurvivorGameDamageLockBuff:_onModifyValue(value)
	local newValue = value

	if newValue > 0 then
		newValue = ArcadeSurvivorGameEnum.Const.DamageLock
	end

	return true, newValue
end

return ArcadeSurvivorGameDamageLockBuff
