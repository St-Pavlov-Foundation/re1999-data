-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/rule/ArcadeSurvivorGameRandomPackRule.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.rule.ArcadeSurvivorGameRandomPackRule", package.seeall)

local ArcadeSurvivorGameRandomPackRule = class("ArcadeSurvivorGameRandomPackRule", ArcadeSurvivorGameBaseRule)

function ArcadeSurvivorGameRandomPackRule:applyOnceOnGain()
	local paramDataList = GameUtil.splitString2(self._typeParam, true, "#", ":")

	if not paramDataList then
		return
	end

	local countData = paramDataList[1]
	local packCount = countData and tonumber(countData[1]) or 0
	local weightedDataList = {}

	for index = 2, #paramDataList do
		weightedDataList[#weightedDataList + 1] = paramDataList[index]
	end

	local packIdList, weightList, totalWeight = ArcadeSurvivorGameHelper.parseWeightedDataList(weightedDataList)

	if packCount <= 0 or totalWeight <= 0 then
		return
	end

	local newPackIdList = {}

	for _ = 1, packCount do
		local packId = ArcadeSurvivorGameHelper.getWeightedId(packIdList, weightList, totalWeight)

		if packId then
			newPackIdList[#newPackIdList + 1] = packId
		end
	end

	local hasNewPack = #newPackIdList > 0

	if hasNewPack then
		ArcadeSurvivorGameController.instance:openShopView(nil, newPackIdList)
	end
end

return ArcadeSurvivorGameRandomPackRule
