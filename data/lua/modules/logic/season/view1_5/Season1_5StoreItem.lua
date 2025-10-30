﻿-- chunkname: @modules/logic/season/view1_5/Season1_5StoreItem.lua

module("modules.logic.season.view1_5.Season1_5StoreItem", package.seeall)

local Season1_5StoreItem = class("Season1_5StoreItem", UserDataDispose)

function Season1_5StoreItem:ctor(go)
	self:__onInit()

	self.go = go
	self.effectRare = gohelper.findChild(self.go, "eff_rare5")
	self.goClick = gohelper.findChildClickWithAudio(self.go, "goClick")
	self.goTag = gohelper.findChild(self.go, "go_tag")
	self.goLimit = gohelper.findChild(self.go, "go_tag/#go_limit")
	self.txtLimitBuy = gohelper.findChildText(self.go, "layout/txt_limitbuy")
	self.imageRare = gohelper.findChildImage(self.go, "image_rare")
	self.goIcon = gohelper.findChild(self.go, "goIcon")
	self.simageIcon = gohelper.findChildSingleImage(self.go, "goIcon/simage_icon")
	self.imageIcon = gohelper.findChildImage(self.go, "goIcon/simage_icon")
	self.goQuantity = gohelper.findChild(self.go, "quantity")
	self.txtQuantity = gohelper.findChildText(self.go, "quantity/bg/txt_quantity")
	self.txtName = gohelper.findChildText(self.go, "layout/txt_name")
	self.txtCost = gohelper.findChildText(self.go, "txt_cost")
	self.simageCoin = gohelper.findChildSingleImage(self.go, "txt_cost/simage_coin")
	self.imageCoin = gohelper.findChildImage(self.go, "txt_cost/simage_coin")
	self.goSoldout = gohelper.findChild(self.go, "go_soldout")

	self.goClick:AddClickListener(self.onClick, self)
end

function Season1_5StoreItem:onClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if not self.data then
		return
	end

	if self.remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	if self.productItemType == MaterialEnum.MaterialType.HeroSkin then
		ViewMgr.instance:openView(ViewName.StoreSkinGoodsView, {
			isActivityStore = true,
			goodsMO = self.data
		})
	else
		ViewMgr.instance:openView(ViewName.VersionActivityNormalStoreGoodsView, self.data)
	end
end

function Season1_5StoreItem:setData(data)
	self.data = data

	if not data then
		gohelper.setActive(self.go, false)

		return
	end

	gohelper.setActive(self.go, true)
	self:refreshRemainBuyCount()

	local productItemType, productItemId, productItemQuantity = self:getItemTypeIdQuantity(self.data.product)
	local productItemConfig, productIconUrl = ItemModel.instance:getItemConfigAndIcon(productItemType, productItemId, true)

	self.productItemType = productItemType

	local rare

	if not productItemConfig.rare then
		logWarn("material type : %s, material id : %s not had rare attribute")

		rare = 5
	else
		rare = productItemConfig.rare
	end

	gohelper.setActive(self.effectRare, rare >= 5)
	UISpriteSetMgr.instance:setStoreGoodsSprite(self.imageRare, "rare" .. rare)

	if productItemType == MaterialEnum.MaterialType.Equip then
		self.simageIcon:LoadImage(ResUrl.getHeroDefaultEquipIcon(productItemConfig.icon), function()
			self.imageIcon:SetNativeSize()
		end)

		if self.headIconItem then
			self.headIconItem:setVisible(false)
		end
	elseif productItemConfig.subType == ItemEnum.SubType.Portrait then
		gohelper.setActive(self.simageIcon.gameObject, false)

		if not self.headIconItem then
			self.headIconItem = IconMgr.instance:getCommonHeadIcon(self.goIcon)
		end

		self.headIconItem:setItemId(productItemConfig.id)
	else
		gohelper.setActive(self.simageIcon.gameObject, true)
		self.simageIcon:LoadImage(productIconUrl, function()
			self.imageIcon:SetNativeSize()
		end)

		if self.headIconItem then
			self.headIconItem:setVisible(false)
		end
	end

	self.txtName.text = productItemConfig.name

	gohelper.setActive(self.goQuantity, productItemQuantity > 1)

	self.txtQuantity.text = productItemQuantity > 1 and productItemQuantity or ""
	self.costItemType, self.costItemId, self.costItemQuantity = self:getItemTypeIdQuantity(self.data.cost)
	self.txtCost.text = self.costItemQuantity

	local costCo, costIconUrl = ItemModel.instance:getItemConfigAndIcon(self.costItemType, self.costItemId)

	if self.costItemType == MaterialEnum.MaterialType.Currency then
		UISpriteSetMgr.instance:setCurrencyItemSprite(self.imageCoin, costCo.icon .. "_1")
	else
		self.simageCoin:LoadImage(costIconUrl)
	end

	self:refreshTag()
end

function Season1_5StoreItem:refreshRemainBuyCount()
	if self.data.maxBuyCount == 0 then
		gohelper.setActive(self.txtLimitBuy.gameObject, false)
		gohelper.setActive(self.goSoldout, false)

		self.remainBuyCount = 9999
	else
		gohelper.setActive(self.txtLimitBuy.gameObject, true)

		self.remainBuyCount = self.data.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(self.data.activityId, self.data.id)
		self.txtLimitBuy.text = formatLuaLang("v1a4_bossrush_storeview_buylimit", self.remainBuyCount)

		gohelper.setActive(self.goSoldout, self.remainBuyCount <= 0)
	end
end

function Season1_5StoreItem:refreshTag()
	if self.data.tag == 0 or self.remainBuyCount <= 0 then
		gohelper.setActive(self.goLimit, false)

		return
	end

	gohelper.setActive(self.goLimit, true)
end

function Season1_5StoreItem:getItemTypeIdQuantity(coStr)
	local attribute = string.splitToNumber(coStr, "#")

	return attribute[1], attribute[2], attribute[3]
end

function Season1_5StoreItem:destory()
	self.goClick:RemoveClickListener()
	self.simageIcon:UnLoadImage()
	self.simageCoin:UnLoadImage()
	self:__onDispose()
end

return Season1_5StoreItem
