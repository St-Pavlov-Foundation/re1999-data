-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/hit/ArcadeSurvivorGameHitDamage.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.hit.ArcadeSurvivorGameHitDamage", package.seeall)

local ArcadeSurvivorGameHitDamage = class("ArcadeSurvivorGameHitDamage", ArcadeSurvivorGameBaseHit)

function ArcadeSurvivorGameHitDamage:onCtor(params)
	self._damage = tonumber(params[1])
end

function ArcadeSurvivorGameHitDamage:_onHit(context, caster, targetList, gridIdDict)
	ArcadeSurvivorGameController.instance:takeDamage(caster, targetList, self._damage)
end

return ArcadeSurvivorGameHitDamage
