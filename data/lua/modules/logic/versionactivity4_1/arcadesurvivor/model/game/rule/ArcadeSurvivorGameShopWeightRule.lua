-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/rule/ArcadeSurvivorGameShopWeightRule.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.rule.ArcadeSurvivorGameShopWeightRule", package.seeall)

local ArcadeSurvivorGameShopWeightRule = class("ArcadeSurvivorGameShopWeightRule", ArcadeSurvivorGameBaseRule)

function ArcadeSurvivorGameShopWeightRule:adjustShopWeightList(weightList)
	if not self:hasSource() then
		return weightList
	end

	local resultList = {}

	for index, weight in ipairs(weightList) do
		resultList[index] = weight
	end

	for _, sourceInfo in ipairs(self:getSourceInfoList()) do
		for _, data in ipairs(ArcadeSurvivorGameHelper.parseColonNumberList(self._typeParam)) do
			local qualityIndex = data.id

			resultList[qualityIndex] = (resultList[qualityIndex] or 0) + data.val * sourceInfo.count
		end
	end

	for qualityIndex, weight in pairs(resultList) do
		resultList[qualityIndex] = math.max(0, weight)
	end

	return resultList
end

return ArcadeSurvivorGameShopWeightRule
