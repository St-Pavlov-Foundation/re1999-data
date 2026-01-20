-- chunkname: @modules/logic/partycloth/define/PartyClothHelper.lua

module("modules.logic.partycloth.define.PartyClothHelper", package.seeall)

local PartyClothHelper = class("PartyClothHelper")

function PartyClothHelper.GetWearSuitId()
	local previewClothIdMap = PartyClothModel.instance:getPreviewClothIdMap()
	local clothId = previewClothIdMap[PartyClothEnum.ClothType.Jacket]

	if not clothId then
		return
	end

	local suitId = PartyClothConfig.instance:getClothConfig(clothId).suitId
	local initSuitId = tonumber(lua_party_const.configDict[1].value)

	if suitId == initSuitId then
		for _, id in pairs(previewClothIdMap) do
			local config = PartyClothConfig.instance:getClothConfig(id)

			if config.suitId ~= suitId then
				return
			end
		end
	else
		for _, id in pairs(previewClothIdMap) do
			local config = PartyClothConfig.instance:getClothConfig(id)

			if config.suitId ~= suitId and config.suitId ~= initSuitId then
				return
			end
		end
	end

	return suitId
end

function PartyClothHelper.GetSuitClothIdMap(suitId)
	local clothIdMap = PartyClothConfig.instance:getInitClothIdMap()
	local clothCfgs = PartyClothConfig.instance:getClothCfgsBySuit(suitId)

	for _, config in ipairs(clothCfgs) do
		clothIdMap[config.partId] = config.clothId
	end

	return clothIdMap
end

function PartyClothHelper.SortSuitFunc(a, b)
	local cfgA = a.config
	local cfgB = b.config
	local isReverse = PartyClothModel.instance.sortReverse

	if a.isWear == b.isWear then
		if cfgA.rare == cfgB.rare then
			return cfgA.id < cfgB.id
		elseif isReverse then
			return cfgA.rare > cfgB.rare
		else
			return cfgA.rare < cfgB.rare
		end
	else
		return a.isWear > b.isWear
	end
end

function PartyClothHelper.SortClothFunc(a, b)
	local cfgA = a.config
	local cfgB = b.config
	local isReverse = PartyClothModel.instance.sortReverse

	if a.isWear == b.isWear then
		if cfgA.rare == cfgB.rare then
			return cfgA.clothId < cfgB.clothId
		elseif isReverse then
			return cfgA.rare > cfgB.rare
		else
			return cfgA.rare < cfgB.rare
		end
	else
		return a.isWear > b.isWear
	end
end

return PartyClothHelper
