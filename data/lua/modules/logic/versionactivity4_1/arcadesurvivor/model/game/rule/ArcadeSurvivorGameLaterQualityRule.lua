-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/rule/ArcadeSurvivorGameLaterQualityRule.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.rule.ArcadeSurvivorGameLaterQualityRule", package.seeall)

local ArcadeSurvivorGameLaterQualityRule = class("ArcadeSurvivorGameLaterQualityRule", ArcadeSurvivorGameBaseRule)

function ArcadeSurvivorGameLaterQualityRule:checkCondition()
	local curLevelIndex = ArcadeSurvivorGameModel.instance:getCurLevelIndex()
	local paramList = string.splitToNumber(self._typeParam, "#")
	local targetLevelIndex = paramList[1] or 0

	return targetLevelIndex < curLevelIndex
end

function ArcadeSurvivorGameLaterQualityRule:onEnterLevel()
	local canTrigger = self:checkCondition()

	if not canTrigger then
		return
	end

	for _, collectionId in ipairs(self:getSortedCollectionIdList()) do
		local sourceCount = self:getSourceCount(ArcadeSurvivorGameEnum.RuleSourceType.Collection, collectionId)

		if sourceCount > 0 then
			local targetCollectionIdList = {}
			local excludeDict = {
				[collectionId] = true
			}

			for _ = 1, sourceCount do
				local qualityDataList = GameUtil.splitString2(self._typeParam, true, "#", ":")

				table.remove(qualityDataList, 1)

				local rarityIdList = {}
				local weightList = {}
				local totalWeight = 0

				for _, qualityData in ipairs(qualityDataList) do
					local rarity = tonumber(qualityData[1])
					local weight = tonumber(qualityData[2]) or 0

					if rarity and weight > 0 then
						rarityIdList[#rarityIdList + 1] = rarity
						weightList[#weightList + 1] = weight
						totalWeight = totalWeight + weight
					end
				end

				local targetCollectionId

				if totalWeight > 0 then
					local rarity = ArcadeSurvivorGameHelper.getWeightedId(rarityIdList, weightList, totalWeight)
					local collectionIdList = ArcadeSurvivorGameModel.instance:getAvailableCollectionIdList(rarity, nil, excludeDict)
					local collectionCount = #collectionIdList

					if collectionCount > 0 then
						targetCollectionId = collectionIdList[math.random(collectionCount)]
					end
				end

				local hasTargetCollectionId = targetCollectionId ~= nil

				if hasTargetCollectionId then
					targetCollectionIdList[#targetCollectionIdList + 1] = targetCollectionId
					excludeDict[targetCollectionId] = true
				end
			end

			local targetCount = #targetCollectionIdList

			if targetCount > 0 then
				ArcadeSurvivorGameController.instance:replaceCollection(collectionId, targetCollectionIdList)
			end
		end
	end
end

return ArcadeSurvivorGameLaterQualityRule
