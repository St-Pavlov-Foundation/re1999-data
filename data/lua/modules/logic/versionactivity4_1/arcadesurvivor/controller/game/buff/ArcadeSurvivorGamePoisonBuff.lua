-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/buff/ArcadeSurvivorGamePoisonBuff.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.buff.ArcadeSurvivorGamePoisonBuff", package.seeall)

local ArcadeSurvivorGamePoisonBuff = class("ArcadeSurvivorGamePoisonBuff", ArcadeSurvivorGameBaseBuff)

function ArcadeSurvivorGamePoisonBuff:onCtor()
	self:_setTickEvent(ArcadeSurvivorGameEnum.BuffTickEvent.TurnEnd)
end

function ArcadeSurvivorGamePoisonBuff:_onTick(context)
	local damage = self:getStackCount()
	local unitMO = self:getUnitMO()

	if not unitMO then
		return false
	end

	ArcadeSurvivorGameController.instance:takeDamageOneTarget(nil, unitMO, damage)

	return true
end

function ArcadeSurvivorGamePoisonBuff:_getConsumeStackCount()
	local casterMO = self:getCasterMO()

	if casterMO then
		local notConsume = casterMO:modifyBuffTickValue(ArcadeSurvivorGameEnum.BuffTickEvent.PoisonNoDecayTick, ArcadeSurvivorGameEnum.BuffModifyValue.PoisonBuffNotConsume, false)

		if notConsume then
			return 0
		end
	end

	local stackCount = self:getStackCount()

	return math.ceil(stackCount / 2)
end

return ArcadeSurvivorGamePoisonBuff
