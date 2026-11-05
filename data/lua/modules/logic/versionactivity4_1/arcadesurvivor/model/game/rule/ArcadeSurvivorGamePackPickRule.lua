-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/rule/ArcadeSurvivorGamePackPickRule.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.rule.ArcadeSurvivorGamePackPickRule", package.seeall)

local ArcadeSurvivorGamePackPickRule = class("ArcadeSurvivorGamePackPickRule", ArcadeSurvivorGameBaseRule)

function ArcadeSurvivorGamePackPickRule:getPackSelectableCount()
	return tonumber(self._typeParam)
end

return ArcadeSurvivorGamePackPickRule
