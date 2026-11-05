-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/buff/ArcadeSurvivorGameEvasionBuff.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.buff.ArcadeSurvivorGameEvasionBuff", package.seeall)

local ArcadeSurvivorGameEvasionBuff = class("ArcadeSurvivorGameEvasionBuff", ArcadeSurvivorGameBaseBuff)

function ArcadeSurvivorGameEvasionBuff:onCtor()
	self:_setTickEvent(ArcadeSurvivorGameEnum.BuffTickEvent.BeforeDamage)
	self:_setValueType(ArcadeSurvivorGameEnum.BuffModifyValue.Damage)
end

function ArcadeSurvivorGameEvasionBuff:_onModifyValue(value)
	local triggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.Dodge
	local mo = self:getUnitMO()
	local context = ArcadeSurvivorGameTriggerContext.New(triggerPoint, nil, mo)

	ArcadeSurvivorGameTriggerController.instance:trigger(triggerPoint, nil, context)

	return true, 0
end

return ArcadeSurvivorGameEvasionBuff
