-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/rule/ArcadeSurvivorGameReplaceShopRule.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.rule.ArcadeSurvivorGameReplaceShopRule", package.seeall)

local ArcadeSurvivorGameReplaceShopRule = class("ArcadeSurvivorGameReplaceShopRule", ArcadeSurvivorGameBaseRule)

function ArcadeSurvivorGameReplaceShopRule:getShopId()
	return tonumber(self._typeParam)
end

return ArcadeSurvivorGameReplaceShopRule
