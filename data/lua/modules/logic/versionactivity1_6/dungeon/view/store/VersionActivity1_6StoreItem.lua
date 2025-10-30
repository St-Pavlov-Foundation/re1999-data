﻿-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/store/VersionActivity1_6StoreItem.lua

module("modules.logic.versionactivity1_6.dungeon.view.store.VersionActivity1_6StoreItem", package.seeall)

local VersionActivity1_6StoreItem = class("VersionActivity1_6StoreItem", UserDataDispose)

function VersionActivity1_6StoreItem:onInitView(go)
	self:__onInit()

	self.go = go
	self.goStoreGoodsItem = gohelper.findChild(self.go, "#go_storegoodsitem")

	gohelper.setActive(self.goStoreGoodsItem, false)

	self.goodsItemList = self:getUserDataTb_()
	self._clipPosY = 424
	self._startFadePosY = 382.32
	self._showTagPosY = 300

	self:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self.onBuyGoodsSuccess, self)
end

function VersionActivity1_6StoreItem:onBuyGoodsSuccess()
	self:sortGoodsCoList()
	self:refreshGoods()
end

function VersionActivity1_6StoreItem:sortGoodsCoList()
	table.sort(self.groupGoodsCoList, VersionActivity1_6StoreItem.sortGoods)
end

function VersionActivity1_6StoreItem:updateInfo(groupId, groupGoodsCoList)
	gohelper.setActive(self.go, true)

	self.groupGoodsCoList = groupGoodsCoList
	self.groupId = groupId

	self:sortGoodsCoList()
	self:refreshTag()
	self:refreshGoods()
end

function VersionActivity1_6StoreItem:refreshTag()
	if self.gotag then
		return
	end

	self.gotag = gohelper.findChild(self.go, "tag" .. self.groupId)
	self.canvasGroup = self.gotag:GetComponent(typeof(UnityEngine.CanvasGroup))
	self.imageTagType = gohelper.findChildImage(self.gotag, "image_tagType")
	self.txtTagName = gohelper.findChildText(self.gotag, "txt_tagName")

	gohelper.setActive(self.gotag, true)

	self.tagMaskList = self:getUserDataTb_()

	table.insert(self.tagMaskList, self.imageTagType)
	table.insert(self.tagMaskList, self.txtTagName)
end

function VersionActivity1_6StoreItem:refreshGoods()
	local goodsItem

	for index, goodsCo in ipairs(self.groupGoodsCoList) do
		goodsItem = self.goodsItemList[index]

		if not goodsItem then
			goodsItem = VersionActivity1_6StoreGoodsItem.New()

			goodsItem:onInitView(gohelper.cloneInPlace(self.goStoreGoodsItem))
			table.insert(self.goodsItemList, goodsItem)
		end

		goodsItem:updateInfo(goodsCo)
	end

	for i = #self.groupGoodsCoList + 1, #self.goodsItemList do
		self.goodsItemList[i]:hide()
	end
end

function VersionActivity1_6StoreItem:refreshTagClip(scrollStore)
	if not self.canvasGroup then
		return
	end

	local tagPosY = recthelper.rectToRelativeAnchorPos(self.gotag.transform.position, scrollStore.transform)
	local rate = Mathf.Clamp((self._clipPosY - tagPosY.y) / (self._clipPosY - self._startFadePosY), 0, 1)

	self.canvasGroup.alpha = rate

	for k, v in ipairs(self.tagMaskList) do
		v.maskable = tagPosY.y <= self._showTagPosY
	end
end

function VersionActivity1_6StoreItem.sortGoods(goodCo1, goodCo2)
	local goods1SellOut = goodCo1.maxBuyCount ~= 0 and goodCo1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_6Enum.ActivityId.DungeonStore, goodCo1.id) <= 0
	local goods2SellOut = goodCo2.maxBuyCount ~= 0 and goodCo2.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_6Enum.ActivityId.DungeonStore, goodCo2.id) <= 0

	if goods1SellOut ~= goods2SellOut then
		if goods1SellOut then
			return false
		end

		return true
	end

	return goodCo1.id < goodCo2.id
end

function VersionActivity1_6StoreItem:onDestroy()
	for _, goodsItem in ipairs(self.goodsItemList) do
		goodsItem:onDestroy()
	end

	self:__onDispose()
end

function VersionActivity1_6StoreItem:getHeight()
	return recthelper.getHeight(self.go.transform)
end

return VersionActivity1_6StoreItem
