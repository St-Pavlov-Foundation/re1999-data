-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/context/ArcadeSurvivorGameAttackResultContext.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.context.ArcadeSurvivorGameAttackResultContext", package.seeall)

local ArcadeSurvivorGameAttackResultContext = class("ArcadeSurvivorGameAttackResultContext", ArcadeSurvivorGameTriggerContext)

function ArcadeSurvivorGameAttackResultContext:onCtor(attacker, targetList)
	self._attacker = attacker
end

function ArcadeSurvivorGameAttackResultContext:getAttacker()
	return self._attacker
end

return ArcadeSurvivorGameAttackResultContext
