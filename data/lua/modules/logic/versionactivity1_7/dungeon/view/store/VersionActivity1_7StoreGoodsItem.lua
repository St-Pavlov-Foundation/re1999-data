﻿-- chunkname: @modules/logic/versionactivity1_7/dungeon/view/store/VersionActivity1_7StoreGoodsItem.lua

module("modules.logic.versionactivity1_7.dungeon.view.store.VersionActivity1_7StoreGoodsItem", package.seeall)

local VersionActivity1_7StoreGoodsItem = class("VersionActivity1_7StoreGoodsItem", ListScrollCell)

function VersionActivity1_7StoreGoodsItem:init(go)
	self.go = go
	self.goTag = gohelper.findChild(self.go, "go_tag")
	self.txtTag = gohelper.findChildText(self.go, "go_tag/txt_tag")
	self.txtLimitBuy = gohelper.findChildText(self.go, "txt_limitbuy")
	self.imageRare = gohelper.findChildImage(self.go, "image_rare")
	self.goMaxRareEffect = gohelper.findChild(self.go, "eff_rare5")
	self.simageIcon = gohelper.findChildSingleImage(self.go, "simage_icon")
	self.imageIcon = gohelper.findChildImage(self.go, "simage_icon")
	self.goQuantity = gohelper.findChild(self.go, "quantity")
	self.txtQuantity = gohelper.findChildText(self.go, "quantity/txt_quantity")
	self.txtCost = gohelper.findChildText(self.go, "txt_cost")
	self.simageCoin = gohelper.findChildSingleImage(self.go, "txt_cost/simage_coin")
	self.imageCoin = gohelper.findChildImage(self.go, "txt_cost/simage_coin")
	self.goSoldout = gohelper.findChild(self.go, "go_soldout")
	self.goClick = gohelper.getClickWithDefaultAudio(go)

	self.goClick:AddClickListener(self.onClick, self)
end

function VersionActivity1_7StoreGoodsItem:addEvents()
	return
end

function VersionActivity1_7StoreGoodsItem:removeEvents()
	return
end

function VersionActivity1_7StoreGoodsItem:onClick()
	if self.remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_5NormalStoreGoodsView, self.goodsCo)
end

function VersionActivity1_7StoreGoodsItem:onUpdateMO(goodsCo)
	self.goodsCo = goodsCo

	self:updateProductCo()
	self:updateRare()
	self:refreshRemainBuyCount()
	gohelper.setActive(self.go, true)
	self:refreshUI()
end

function VersionActivity1_7StoreGoodsItem:updateProductCo()
	self.productItemType, self.productItemId, self.productQuantity = self:getItemTypeIdQuantity(self.goodsCo.product)
	self.productConfig, self.productIconUrl = ItemModel.instance:getItemConfigAndIcon(self.productItemType, self.productItemId)
end

function VersionActivity1_7StoreGoodsItem:updateRare()
	self.rare = self.productConfig.rare

	if not self.rare then
		logWarn("material type : %s, material id : %s not had rare attribute")

		self.rare = 5
	end
end

function VersionActivity1_7StoreGoodsItem:refreshRemainBuyCount()
	if self.goodsCo.maxBuyCount == 0 then
		gohelper.setActive(self.txtLimitBuy.gameObject, false)
		gohelper.setActive(self.goSoldout, false)

		self.remainBuyCount = 9999
	else
		gohelper.setActive(self.txtLimitBuy.gameObject, true)

		self.remainBuyCount = self.goodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_7Enum.ActivityId.DungeonStore, self.goodsCo.id)
		self.txtLimitBuy.text = formatLuaLang("v1a4_bossrush_storeview_buylimit", self.remainBuyCount)

		gohelper.setActive(self.goSoldout, self.remainBuyCount <= 0)
	end
end

function VersionActivity1_7StoreGoodsItem:refreshUI()
	self:refreshRareBg()
	self:refreshIcon()
	self:refreshTag()
	self:refreshName()
	self:refreshQuantity()
	self:refreshCost()
end

function VersionActivity1_7StoreGoodsItem:refreshRareBg()
	UISpriteSetMgr.instance:setV1a7MainActivitySprite(self.imageRare, "v1a7_store_quality_" .. self.rare)
	gohelper.setActive(self.goMaxRareEffect, self.rare >= 5)
end

function VersionActivity1_7StoreGoodsItem:refreshIcon()
	if self.productItemType == MaterialEnum.MaterialType.Equip then
		self.simageIcon:LoadImage(ResUrl.getHeroDefaultEquipIcon(self.productConfig.icon), self.setNativeSize, self)
	else
		self.simageIcon:LoadImage(self.productIconUrl, self.setNativeSize, self)
	end
end

function VersionActivity1_7StoreGoodsItem:setNativeSize()
	self.imageIcon:SetNativeSize()
end

function VersionActivity1_7StoreGoodsItem:refreshTag()
	if self.goodsCo.tag == 0 or self.remainBuyCount <= 0 then
		gohelper.setActive(self.goTag, false)

		return
	end

	gohelper.setActive(self.goTag, true)

	self.txtTag.text = ActivityStoreConfig.instance:getTagName(self.goodsCo.tag)
end

function VersionActivity1_7StoreGoodsItem:refreshName()
	gohelper.setActive(self.txtName, false)

	if self.rare >= MaterialEnum.ItemRareR then
		self.txtName = gohelper.findChildText(self.go, "txt_name" .. self.rare)
	else
		self.txtName = gohelper.findChildText(self.go, "txt_name")
	end

	gohelper.setActive(self.txtName, true)

	self.txtName.text = self.productConfig.name
end

function VersionActivity1_7StoreGoodsItem:refreshQuantity()
	local showQuantity = self.productQuantity > 1

	gohelper.setActive(self.goQuantity, showQuantity)

	if showQuantity then
		self.txtQuantity.text = luaLang("multiple") .. self.productQuantity
	end
end

function VersionActivity1_7StoreGoodsItem:refreshCost()
	local costType, costId, costQuantity = self:getItemTypeIdQuantity(self.goodsCo.cost)

	self.txtCost.text = costQuantity

	local costCo, costIconUrl = ItemModel.instance:getItemConfigAndIcon(costType, costId)

	if costType == MaterialEnum.MaterialType.Currency then
		UISpriteSetMgr.instance:setCurrencyItemSprite(self.imageCoin, costCo.icon .. "_1")
	else
		self.simageCoin:LoadImage(costIconUrl)
	end
end

function VersionActivity1_7StoreGoodsItem:getItemTypeIdQuantity(coStr)
	local attribute = string.splitToNumber(coStr, "#")

	return attribute[1], attribute[2], attribute[3]
end

function VersionActivity1_7StoreGoodsItem:onDestroy()
	self.goClick:RemoveClickListener()
	self.simageIcon:UnLoadImage()
	self.simageCoin:UnLoadImage()
end

return VersionActivity1_7StoreGoodsItem
