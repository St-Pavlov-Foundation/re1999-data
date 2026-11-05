-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/selector/ArcadeSurvivorSelectorSelfXY.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.selector.ArcadeSurvivorSelectorSelfXY", package.seeall)

local ArcadeSurvivorSelectorSelfXY = class("ArcadeSurvivorSelectorSelfXY", ArcadeSurvivorGameBaseGridSelector)

function ArcadeSurvivorSelectorSelfXY:_findGridIdList()
	self:_addGridXY(self._sourceGridX, self._sourceGridY)
end

return ArcadeSurvivorSelectorSelfXY
