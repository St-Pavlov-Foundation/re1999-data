-- chunkname: @modules/logic/partycloth/model/PartyClothModel.lua

module("modules.logic.partycloth.model.PartyClothModel", package.seeall)

local PartyClothModel = class("PartyClothModel", BaseModel)

function PartyClothModel:onInit()
	self:reInit()
end

function PartyClothModel:reInit()
	self.sortReverse = false
	self.suitIds = {}
	self.clothMoList = {}
	self.wearClothIdMap = {}
	self.previewClothIdMap = {}
	self._getWearCloth = false
	self.summonPoolMos = {}

	local strCacheData = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.PartyClothNewTag, "")

	if string.nilorempty(strCacheData) then
		self.clothNewTagCache = {}
	else
		self.clothNewTagCache = cjson.decode(strCacheData)
	end
end

function PartyClothModel:setSummonPoolInfo(infos)
	tabletool.clear(self.summonPoolMos)

	for k, v in ipairs(infos) do
		local mo = PartyClothSummonPoolMo.New()

		mo:init(v)

		self.summonPoolMos[k] = mo
	end
end

function PartyClothModel:updateSummonPoolInfo(pooldId, hasSummonPrizeInfos, leftPrizeNum)
	local mo = self:getSummonPoolMo(pooldId)

	if mo then
		mo:update(hasSummonPrizeInfos, leftPrizeNum)
	end
end

function PartyClothModel:updateClothInfo(clothInfos)
	tabletool.clear(self.clothMoList)

	for k, info in ipairs(clothInfos) do
		local mo = PartyClothMo.New()

		mo:init(info.clothId, info.quantity)

		self.clothMoList[k] = mo

		self:checkSuitChange(info.clothId)
	end

	PartyClothController.instance:dispatchEvent(PartyClothEvent.ClothInfoUpdate)
end

function PartyClothModel:checkSuitChange(clothId)
	local config = PartyClothConfig.instance:getClothConfig(clothId)

	if not tabletool.indexOf(self.suitIds, config.suitId) then
		self.suitIds[#self.suitIds + 1] = config.suitId
	end
end

function PartyClothModel:alreadyGetWearCloth()
	return self._getWearCloth
end

function PartyClothModel:setInitMark(bool)
	self._getWearCloth = bool
end

function PartyClothModel:addClothMo(clothId, quantity)
	local clothMo = self:getClothMo(clothId, true)

	if clothMo then
		clothMo:addQuantity(quantity)
	else
		clothMo = PartyClothMo.New()

		clothMo:init(clothId, quantity)

		self.clothMoList[#self.clothMoList + 1] = clothMo

		self:checkSuitChange(clothId)
	end

	PartyClothController.instance:dispatchEvent(PartyClothEvent.ClothInfoUpdate)
end

function PartyClothModel:updateWearClothIds(wearClothIds)
	self.wearClothIds = wearClothIds

	tabletool.clear(self.wearClothIdMap)
	tabletool.clear(self.previewClothIdMap)

	for _, clothId in ipairs(self.wearClothIds) do
		local config = PartyClothConfig.instance:getClothConfig(clothId)

		if config then
			self.wearClothIdMap[config.partId] = clothId
			self.previewClothIdMap[config.partId] = clothId
		end
	end

	PartyClothController.instance:dispatchEvent(PartyClothEvent.WearClothUpdate)
end

function PartyClothModel:getSummonPoolMo(poolId)
	if poolId then
		for _, v in ipairs(self.summonPoolMos) do
			if v.poolId == poolId then
				return v
			end
		end
	else
		return self.summonPoolMos[1]
	end
end

function PartyClothModel:getClothMo(clothId, ignor)
	for _, info in ipairs(self.clothMoList) do
		if info.clothId == clothId then
			return info
		end
	end

	if not ignor then
		logError(string.format("PartyClothModel不存在clothId为： %s 的ClothInfo", clothId))
	end
end

function PartyClothModel:getClothMoList(clothType)
	local list = {}

	for _, info in ipairs(self.clothMoList) do
		if info.config.partId == clothType then
			list[#list + 1] = info
		end
	end

	return list
end

function PartyClothModel:getSuitCollectCount(suitId)
	local count = 0

	for _, info in ipairs(self.clothMoList) do
		if info.config.suitId == suitId then
			count = count + 1
		end
	end

	return count
end

function PartyClothModel:getWearClothIdMap()
	return self.wearClothIdMap
end

function PartyClothModel:getCurWearClothRes()
	return PartyClothConfig.instance:getSkinRes(self.wearClothIdMap)
end

function PartyClothModel:getPreviewClothIdMap()
	return self.previewClothIdMap
end

function PartyClothModel:getPreviewClothIds()
	local list = {}

	for _, id in pairs(self.previewClothIdMap) do
		list[#list + 1] = id
	end

	return list
end

function PartyClothModel:getSuitIds()
	return self.suitIds
end

function PartyClothModel:setSortRule()
	self.sortReverse = not self.sortReverse
end

function PartyClothModel:hasNewTag(clothId)
	clothId = tostring(clothId)

	return not self.clothNewTagCache[clothId]
end

function PartyClothModel:setNewTagInvalid(clothIdList)
	local isChange

	for _, clothId in ipairs(clothIdList) do
		clothId = tostring(clothId)

		if not self.clothNewTagCache[clothId] then
			self.clothNewTagCache[clothId] = true
			isChange = true
		end
	end

	if isChange then
		GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.PartyClothNewTag, cjson.encode(self.clothNewTagCache))
	end
end

PartyClothModel.instance = PartyClothModel.New()

return PartyClothModel
