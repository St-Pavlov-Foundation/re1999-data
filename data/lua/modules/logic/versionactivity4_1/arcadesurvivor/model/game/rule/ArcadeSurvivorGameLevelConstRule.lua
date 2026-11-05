-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/rule/ArcadeSurvivorGameLevelConstRule.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.rule.ArcadeSurvivorGameLevelConstRule", package.seeall)

local ArcadeSurvivorGameLevelConstRule = class("ArcadeSurvivorGameLevelConstRule", ArcadeSurvivorGameBaseRule)

function ArcadeSurvivorGameLevelConstRule:getCharacterTurnTime()
	return tonumber(self._typeParam)
end

return ArcadeSurvivorGameLevelConstRule
