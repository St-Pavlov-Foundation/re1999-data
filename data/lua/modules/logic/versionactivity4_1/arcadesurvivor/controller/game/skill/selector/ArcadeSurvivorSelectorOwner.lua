-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/selector/ArcadeSurvivorSelectorOwner.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.selector.ArcadeSurvivorSelectorOwner", package.seeall)

local ArcadeSurvivorSelectorOwner = class("ArcadeSurvivorSelectorOwner", ArcadeSurvivorGameBaseSelector)

function ArcadeSurvivorSelectorOwner:onCtor()
	self._allowOffBoard = true
end

function ArcadeSurvivorSelectorOwner:_onFindByContext(context)
	local caster = context and context:getCaster()

	self:_addTarget(caster, true)

	return true
end

function ArcadeSurvivorSelectorOwner:getTargetListInGrids(gridIdDict)
	return self:getTargetList()
end

return ArcadeSurvivorSelectorOwner
