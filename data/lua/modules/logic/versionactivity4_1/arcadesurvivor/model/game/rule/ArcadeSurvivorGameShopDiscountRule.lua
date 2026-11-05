-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/rule/ArcadeSurvivorGameShopDiscountRule.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.rule.ArcadeSurvivorGameShopDiscountRule", package.seeall)

local ArcadeSurvivorGameShopDiscountRule = class("ArcadeSurvivorGameShopDiscountRule", ArcadeSurvivorGameBaseRule)

function ArcadeSurvivorGameShopDiscountRule:getShopDiscountPercent()
	local discountPercent = 0
	local rulePercent = tonumber(self._typeParam) or 0

	for _, sourceInfo in ipairs(self:getSourceInfoList()) do
		discountPercent = discountPercent + rulePercent * sourceInfo.count
	end

	return discountPercent
end

return ArcadeSurvivorGameShopDiscountRule
