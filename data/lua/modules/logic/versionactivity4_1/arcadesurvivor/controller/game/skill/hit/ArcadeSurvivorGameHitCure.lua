-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/hit/ArcadeSurvivorGameHitCure.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.hit.ArcadeSurvivorGameHitCure", package.seeall)

local ArcadeSurvivorGameHitCure = class("ArcadeSurvivorGameHitCure", ArcadeSurvivorGameBaseHit)

function ArcadeSurvivorGameHitCure:onCtor(params)
	self._changeHp = tonumber(params[1])
end

function ArcadeSurvivorGameHitCure:_onHit(context, caster, targetList, gridIdDict)
	for _, targetMO in ipairs(targetList) do
		ArcadeSurvivorGameController.instance:changeEntityMOHp(targetMO, self._changeHp)
	end
end

return ArcadeSurvivorGameHitCure
