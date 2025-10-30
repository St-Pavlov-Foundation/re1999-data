﻿-- chunkname: @modules/logic/store/model/DecorateStoreModel.lua

module("modules.logic.store.model.DecorateStoreModel", package.seeall)

local DecorateStoreModel = class("DecorateStoreModel", BaseModel)

function DecorateStoreModel:onInit()
	self._curGoodId = 0
	self._curViewType = 0
	self._curDecorateType = 0
	self._curCostIndex = 1
	self._readGoodList = {}
end

function DecorateStoreModel:reInit()
	self:onInit()
end

function DecorateStoreModel:setCurGood(goodId)
	self._curGoodId = goodId
end

function DecorateStoreModel:getCurGood(storeId)
	if self._curGoodId == 0 then
		self._curGoodId = self:getDecorateGoodList(storeId)[1].goodsId
	else
		local curStoreId = tonumber(StoreConfig.instance:getGoodsConfig(self._curGoodId).storeId)

		if curStoreId ~= storeId then
			self._curGoodId = self:getDecorateGoodList(storeId)[1].goodsId
		end
	end

	return self._curGoodId
end

function DecorateStoreModel:getDecorateGoodList(storeId)
	local allGoods = {}
	local storeMO = StoreModel.instance:getStoreMO(storeId)

	if storeMO then
		local goodsList = storeMO:getGoodsList()

		for _, mo in pairs(goodsList) do
			table.insert(allGoods, mo)
		end
	end

	table.sort(allGoods, function(a, b)
		local isAItemHas = self:isDecorateGoodItemHas(a.goodsId)
		local isBItemHas = self:isDecorateGoodItemHas(b.goodsId)
		local aSoldOut = a.config.maxBuyCount > 0 and a.buyCount >= a.config.maxBuyCount and 1 or 0

		if isAItemHas then
			aSoldOut = 1
		end

		local bSoldOut = b.config.maxBuyCount > 0 and b.buyCount >= b.config.maxBuyCount and 1 or 0

		if isBItemHas then
			bSoldOut = 1
		end

		if aSoldOut ~= bSoldOut then
			return aSoldOut < bSoldOut
		else
			return a.config.order < b.config.order
		end
	end)

	return allGoods
end

function DecorateStoreModel:getDecorateGoodIndex(storeId, goodId)
	local goodList = self:getDecorateGoodList(storeId)

	for index, goodMo in ipairs(goodList) do
		if goodMo.goodsId == goodId then
			return index
		end
	end

	return 0
end

function DecorateStoreModel:setCurViewType(viewType)
	self._curViewType = viewType
end

function DecorateStoreModel:getCurViewType()
	if self._curViewType == 0 then
		self._curViewType = DecorateStoreEnum.DecorateViewType.Fold
	end

	return self._curViewType
end

function DecorateStoreModel:setCurDecorateType(type)
	self._curDecorateType = type
end

function DecorateStoreModel:getCurDecorateType()
	if self._curDecorateType == 0 then
		self._curDecorateType = DecorateStoreEnum.DecorateType.New
	end

	return self._curDecorateType
end

function DecorateStoreModel:isGoodRead(goodId)
	return self._readGoodList[goodId]
end

function DecorateStoreModel:initDecorateReadState()
	local str = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DecorateStoreReadGoods), "")
	local readGoods = string.splitToNumber(str, "#")

	for _, good in pairs(readGoods) do
		self._readGoodList[good] = true
	end
end

function DecorateStoreModel:setGoodRead(goodId)
	self._readGoodList[goodId] = true

	local str = ""

	for good, _ in pairs(self._readGoodList) do
		str = str == "" and good or string.format("%s#%s", str, good)
	end

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DecorateStoreReadGoods), str)
end

function DecorateStoreModel.getItemType(storeId)
	local goodId = DecorateStoreModel.instance:getCurGood(storeId)
	local decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(goodId)

	if decorateConfig.productType == MaterialEnum.MaterialType.Item then
		if decorateConfig.subType == MaterialEnum.ItemSubType.Icon then
			return DecorateStoreEnum.DecorateItemType.Icon
		elseif decorateConfig.subType == MaterialEnum.ItemSubType.SelfCard then
			return DecorateStoreEnum.DecorateItemType.SelfCard
		elseif decorateConfig.subType == MaterialEnum.ItemSubType.MainScene then
			return DecorateStoreEnum.DecorateItemType.MainScene
		elseif decorateConfig.subType == ItemEnum.SubType.SkinSelelctGift then
			return DecorateStoreEnum.DecorateItemType.SkinGift
		end
	elseif decorateConfig.productType == MaterialEnum.MaterialType.HeroSkin then
		return DecorateStoreEnum.DecorateItemType.Skin
	elseif decorateConfig.productType == MaterialEnum.MaterialType.Building and decorateConfig.subType == 7 then
		return DecorateStoreEnum.DecorateItemType.BuildingVideo
	end

	return DecorateStoreEnum.DecorateItemType.Default
end

function DecorateStoreModel:setCurCostIndex(index)
	self._curCostIndex = index
end

function DecorateStoreModel:getCurCostIndex()
	return self._curCostIndex
end

function DecorateStoreModel:getGoodDiscount(goodsId)
	local goodsConfig = StoreConfig.instance:getGoodsConfig(goodsId)

	if goodsConfig.discountItem == "" then
		return 0
	end

	local discounts = string.split(goodsConfig.discountItem, "|")

	if #discounts ~= 2 then
		return 0
	end

	local items = string.splitToNumber(discounts[1], "#")
	local itemCount = ItemModel.instance:getItemCount(items[2])

	if itemCount < items[3] then
		return 0
	end

	local itemCo = ItemModel.instance:getItemConfig(items[1], items[2])
	local ts = TimeUtil.stringToTimestamp(itemCo.expireTime)
	local offsetSecond = math.floor(ts - ServerTime.now())

	if offsetSecond <= 0 then
		return 0
	end

	return math.floor(tonumber(discounts[2]) / 10)
end

function DecorateStoreModel:getGoodItemLimitTime(goodsId)
	local discount = self:getGoodDiscount(goodsId)

	if discount > 0 and discount < 100 then
		local goodsConfig = StoreConfig.instance:getGoodsConfig(goodsId)

		if goodsConfig.discountItem == "" then
			return 0
		end

		local discounts = string.split(goodsConfig.discountItem, "|")

		if #discounts ~= 2 then
			return 0
		end

		local items = string.splitToNumber(discounts[1], "#")
		local itemCount = ItemModel.instance:getItemCount(items[2])

		if itemCount < items[3] then
			return 0
		end

		local itemCo = ItemModel.instance:getItemConfig(items[1], items[2])
		local ts = TimeUtil.stringToTimestamp(itemCo.expireTime)
		local offsetSecond = math.floor(ts - ServerTime.now())

		return offsetSecond
	end

	return 0
end

function DecorateStoreModel:isDecorateGoodItemHas(goodId)
	local decorateCo = DecorateStoreConfig.instance:getDecorateConfig(goodId)

	if decorateCo.maxbuycountType ~= DecorateStoreEnum.MaxBuyTipType.Owned then
		return false
	end

	local goodsConfig = StoreConfig.instance:getGoodsConfig(goodId)
	local items = string.splitToNumber(goodsConfig.product, "#")

	if decorateCo.productType == MaterialEnum.MaterialType.Item and decorateCo.subType == ItemEnum.SubType.SkinSelelctGift then
		local config = ItemConfig.instance:getItemCo(items[2])
		local effect = config and config.effect or ""
		local param = GameUtil.splitString2(effect, true)
		local skinList = param[1]

		for i, v in ipairs(skinList) do
			if not HeroModel.instance:checkHasSkin(v) then
				return false
			end
		end

		return true
	end

	local itemCount = ItemModel.instance:getItemQuantity(items[1], items[2])

	return itemCount > 0
end

DecorateStoreModel.instance = DecorateStoreModel.New()

return DecorateStoreModel
