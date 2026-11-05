-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/rule/ArcadeSurvivorGameExitCoinRule.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.rule.ArcadeSurvivorGameExitCoinRule", package.seeall)

local ArcadeSurvivorGameExitCoinRule = class("ArcadeSurvivorGameExitCoinRule", ArcadeSurvivorGameBaseRule)

function ArcadeSurvivorGameExitCoinRule:onShopClosed()
	local haveCoin = ArcadeSurvivorGameModel.instance:getCurrencyCount(ArcadeSurvivorEnum.Currency.Coin)
	local gainPercent = tonumber(self._typeParam) or 0
	local totalPercent = 0

	for _, sourceInfo in ipairs(self:getSourceInfoList()) do
		totalPercent = totalPercent + gainPercent * sourceInfo.count
	end

	local gainCoin = math.floor(haveCoin * totalPercent / 100)
	local hasGainCoin = gainCoin > 0

	if hasGainCoin then
		ArcadeSurvivorGameController.instance:changeCurrencyCount(ArcadeSurvivorEnum.Currency.Coin, gainCoin)
	end
end

return ArcadeSurvivorGameExitCoinRule
