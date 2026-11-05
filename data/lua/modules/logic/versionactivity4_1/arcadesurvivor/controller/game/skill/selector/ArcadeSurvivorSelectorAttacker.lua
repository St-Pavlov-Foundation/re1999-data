-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/selector/ArcadeSurvivorSelectorAttacker.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.selector.ArcadeSurvivorSelectorAttacker", package.seeall)

local ArcadeSurvivorSelectorAttacker = class("ArcadeSurvivorSelectorAttacker", ArcadeSurvivorGameBaseSelector)

function ArcadeSurvivorSelectorAttacker:_onFindByContext(context)
	if context and context.getAttacker then
		local attacker = context:getAttacker()

		self:_addTarget(attacker, true)
	end

	return true
end

return ArcadeSurvivorSelectorAttacker
