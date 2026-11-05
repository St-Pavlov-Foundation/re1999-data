-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/rule/ArcadeSurvivorGameSpendRewardRule.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.rule.ArcadeSurvivorGameSpendRewardRule", package.seeall)

local ArcadeSurvivorGameSpendRewardRule = class("ArcadeSurvivorGameSpendRewardRule", ArcadeSurvivorGameBaseRule)

function ArcadeSurvivorGameSpendRewardRule:checkCondition(source)
	local paramDataList = GameUtil.splitString2(self._typeParam, true, "#", ":")
	local firstData = paramDataList[1]
	local targetCoin = firstData and firstData[1] or 0

	return targetCoin <= (source.state.spentCoin or 0)
end

function ArcadeSurvivorGameSpendRewardRule:onGoodsPurchased(price, currencyId)
	local isCoinCost = currencyId == ArcadeSurvivorEnum.Currency.Coin

	if not isCoinCost or price <= 0 then
		return
	end

	local paramDataList = GameUtil.splitString2(self._typeParam, true, "#", ":")
	local firstData = paramDataList[1]
	local secondData = paramDataList[2]
	local targetCoin = firstData and firstData[1] or 0
	local rewardPackCount = secondData and secondData[1] or 0
	local weightedDataList = {}

	for index = 3, #paramDataList do
		weightedDataList[#weightedDataList + 1] = paramDataList[index]
	end

	local packIdList, weightList, totalWeight = ArcadeSurvivorGameHelper.parseWeightedDataList(weightedDataList)
	local newPackIdList = {}

	for _, collectionId in ipairs(self:getSortedCollectionIdList()) do
		local source = self:getSource(ArcadeSurvivorGameEnum.RuleSourceType.Collection, collectionId)

		source.state.spentCoin = (source.state.spentCoin or 0) + price

		local canTrigger = targetCoin > 0 and rewardPackCount > 0 and totalWeight > 0

		while canTrigger do
			canTrigger = self:checkCondition(source)

			if not canTrigger then
				break
			end

			source.state.spentCoin = source.state.spentCoin - targetCoin

			for _ = 1, rewardPackCount do
				local packId = ArcadeSurvivorGameHelper.getWeightedId(packIdList, weightList, totalWeight)

				if packId then
					newPackIdList[#newPackIdList + 1] = packId
				end
			end
		end
	end

	local hasNewPack = #newPackIdList > 0

	if hasNewPack then
		ArcadeSurvivorGameController.instance:openShopView(nil, newPackIdList)
	end
end

return ArcadeSurvivorGameSpendRewardRule
