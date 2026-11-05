-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/hit/ArcadeSurvivorGameHitKill.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.hit.ArcadeSurvivorGameHitKill", package.seeall)

local ArcadeSurvivorGameHitKill = class("ArcadeSurvivorGameHitKill", ArcadeSurvivorGameBaseHit)

function ArcadeSurvivorGameHitKill:onCtor(params)
	return
end

function ArcadeSurvivorGameHitKill:_onHit(context, caster, targetList, gridIdDict)
	if not targetList then
		return
	end

	for _, targetMO in ipairs(targetList) do
		ArcadeSurvivorGameController.instance:takeDamageOneTarget(caster, targetMO, nil, true)
	end
end

return ArcadeSurvivorGameHitKill
