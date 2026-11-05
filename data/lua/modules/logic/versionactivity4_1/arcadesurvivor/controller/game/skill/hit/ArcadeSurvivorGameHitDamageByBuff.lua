-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/hit/ArcadeSurvivorGameHitDamageByBuff.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.hit.ArcadeSurvivorGameHitDamageByBuff", package.seeall)

local ArcadeSurvivorGameHitDamageByBuff = class("ArcadeSurvivorGameHitDamageByBuff", ArcadeSurvivorGameBaseHit)

function ArcadeSurvivorGameHitDamageByBuff:onCtor(params)
	self._buffId = tonumber(params[1])
	self._perCount = tonumber(params[2])
	self._damage = tonumber(params[3]) or 0
end

function ArcadeSurvivorGameHitDamageByBuff:_onHit(context, caster, targetList, gridIdDict)
	local totalDamage = 0
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if characterMO and self._perCount then
		local buff = characterMO:getBuff(self._buffId)
		local buffCount = 0

		if buff then
			buffCount = buff:getStackCount()
		end

		local damageTimes = math.floor(buffCount / self._perCount)

		totalDamage = damageTimes * self._damage
	end

	ArcadeSurvivorGameController.instance:takeDamage(caster, targetList, totalDamage)
end

return ArcadeSurvivorGameHitDamageByBuff
