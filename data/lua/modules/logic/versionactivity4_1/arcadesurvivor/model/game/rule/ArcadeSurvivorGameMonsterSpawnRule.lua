-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/rule/ArcadeSurvivorGameMonsterSpawnRule.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.rule.ArcadeSurvivorGameMonsterSpawnRule", package.seeall)

local ArcadeSurvivorGameMonsterSpawnRule = class("ArcadeSurvivorGameMonsterSpawnRule", ArcadeSurvivorGameBaseRule)

function ArcadeSurvivorGameMonsterSpawnRule:getMonsterSpawnConfig()
	local paramList = string.splitToNumber(self._typeParam, "#")

	return paramList[1], paramList[2]
end

return ArcadeSurvivorGameMonsterSpawnRule
