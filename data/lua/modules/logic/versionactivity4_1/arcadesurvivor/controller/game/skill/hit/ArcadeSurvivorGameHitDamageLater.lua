-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/hit/ArcadeSurvivorGameHitDamageLater.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.hit.ArcadeSurvivorGameHitDamageLater", package.seeall)

local ArcadeSurvivorGameHitDamageLater = class("ArcadeSurvivorGameHitDamageLater", ArcadeSurvivorGameBaseDelayHit)

function ArcadeSurvivorGameHitDamageLater:onCtor(params)
	self._damage = tonumber(params[1])
	self._delayTurn = tonumber(params[2])
end

function ArcadeSurvivorGameHitDamageLater:_onDelayHit(context, caster, targetList, gridIdDict)
	ArcadeSurvivorGameController.instance:takeDamage(caster, targetList, self._damage)
end

function ArcadeSurvivorGameHitDamageLater:getNeedAlert()
	return true
end

return ArcadeSurvivorGameHitDamageLater
