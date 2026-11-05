-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/rule/ArcadeSurvivorGameHpPurchaseRule.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.rule.ArcadeSurvivorGameHpPurchaseRule", package.seeall)

local ArcadeSurvivorGameHpPurchaseRule = class("ArcadeSurvivorGameHpPurchaseRule", ArcadeSurvivorGameBaseRule)

function ArcadeSurvivorGameHpPurchaseRule:getCoinPerHp()
	return tonumber(self._typeParam) or 0
end

return ArcadeSurvivorGameHpPurchaseRule
