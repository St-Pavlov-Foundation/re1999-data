-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/selector/ArcadeSurvivorSelectorHitter.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.selector.ArcadeSurvivorSelectorHitter", package.seeall)

local ArcadeSurvivorSelectorHitter = class("ArcadeSurvivorSelectorHitter", ArcadeSurvivorGameBaseSelector)

function ArcadeSurvivorSelectorHitter:_onFindByContext(context)
	local hitterList

	if context and context.getHitterList then
		hitterList = context:getHitterList()
	end

	for index = 1, #hitterList do
		self:_addTarget(hitterList[index], true)
	end

	return true
end

return ArcadeSurvivorSelectorHitter
