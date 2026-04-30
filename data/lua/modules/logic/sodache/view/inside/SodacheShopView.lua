-- chunkname: @modules/logic/sodache/view/inside/SodacheShopView.lua

module("modules.logic.sodache.view.inside.SodacheShopView", package.seeall)

local SodacheShopView = class("SodacheShopView", BaseView)

function SodacheShopView:onInitView()
	self._goNormal = gohelper.findChild(self.viewGO, "Left/#go_Normal")
	self._scrollShop = gohelper.findChild(self.viewGO, "Left/#go_Normal/#scroll_Shop")
	self._btnBlackMarket = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_Normal/BtnGroup/#btn_BlackMarket")
	self._gobtntype = gohelper.findChild(self.viewGO, "Left/#go_Normal/BtnGroup/bg/#btn_card")
	self._btnMultiSelect = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_Normal/BtnGroup/#btn_MultiSelect")
	self._goMultiSelect = gohelper.findChild(self.viewGO, "Left/#go_Normal/BtnGroup/#btn_MultiSelect/#go_MultiSelect")
	self._goBlackMarket = gohelper.findChild(self.viewGO, "Left/#go_BlackMarket")
	self._btnShop = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_BlackMarket/#btn_Shop")
	self._goblackshopitem = gohelper.findChild(self.viewGO, "Left/#go_BlackMarket/#scroll_BlackMarket/Viewport/Content/#go_CardpackItem")
	self._txtchat = gohelper.findChildTextMesh(self.viewGO, "Left/#go_BlackMarket/chat/#txt_Chat")
	self._goSingleCard = gohelper.findChild(self.viewGO, "Right/#go_SingleCard")
	self._scrollMultiCard = gohelper.findChild(self.viewGO, "Right/#scroll_MultiCard")
	self._txtBuyCost = gohelper.findChildText(self.viewGO, "Right/bottom/#btn_Buy/#go_Cost/#txt_BuyCost")
	self._imageCostIcon = gohelper.findChildImage(self.viewGO, "Right/bottom/#btn_Buy/#go_Cost/costicon/image_icon")
	self._goCount = gohelper.findChild(self.viewGO, "Right/bottom/#go_Count")
	self._inputCount = gohelper.findChildTextMeshInputField(self.viewGO, "Right/bottom/#go_Count/valuebg/#input_Count")
	self._btnMin = gohelper.findChildButtonWithAudio(self.viewGO, "Right/bottom/#go_Count/#btn_Min")
	self._btnSub = gohelper.findChildButtonWithAudio(self.viewGO, "Right/bottom/#go_Count/#btn_Sub")
	self._btnAdd = gohelper.findChildButtonWithAudio(self.viewGO, "Right/bottom/#go_Count/#btn_Add")
	self._btnMax = gohelper.findChildButtonWithAudio(self.viewGO, "Right/bottom/#go_Count/#btn_Max")
	self._btnBuy = gohelper.findChildButtonWithAudio(self.viewGO, "Right/bottom/#btn_Buy")
	self._gocoin = gohelper.findChild(self.viewGO, "#go_topright/currencyview")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SodacheShopView:addEvents()
	self._btnBlackMarket:AddClickListener(self._btnBlackMarketOnClick, self)
	self._btnMultiSelect:AddClickListener(self._btnMultiSelectOnClick, self)
	self._btnShop:AddClickListener(self._btnShopOnClick, self)
	self._btnMin:AddClickListener(self._btnMinOnClick, self)
	self._btnSub:AddClickListener(self._btnSubOnClick, self)
	self._btnAdd:AddClickListener(self._btnAddOnClick, self)
	self._btnMax:AddClickListener(self._btnMaxOnClick, self)
	self._btnBuy:AddClickListener(self._btnBuyOnClick, self)
	self._inputCount:AddOnEndEdit(self._onInputChange, self)
	self:addEventCb(SodacheController.instance, SodacheEvent.OnClickGoodsItem, self.refreshRightInfo, self)
	self:addEventCb(SodacheController.instance, SodacheEvent.OnShopItemUpdate, self.refreshShopInfo, self)
end

function SodacheShopView:removeEvents()
	self._btnBlackMarket:RemoveClickListener()
	self._btnMultiSelect:RemoveClickListener()
	self._btnShop:RemoveClickListener()
	self._btnMin:RemoveClickListener()
	self._btnSub:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnMax:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._inputCount:RemoveOnEndEdit()
end

function SodacheShopView:refreshShopInfo()
	if self.shopType == SodacheEnum.ShopType.Normal then
		self:_onItemTypeClick(self._curItemType, true)
	else
		for i = #self.selectMo.curSelectGoods, 1, -1 do
			local mo = self.selectMo.curSelectGoods[i]

			if mo.shopMo.count == 0 then
				table.remove(self.selectMo.curSelectGoods, i)
			elseif mo.shopMo.count ~= -1 and mo.shopMo.count < mo.selectCount then
				mo.selectCount = mo.shopMo.count
			end
		end

		self:_refreshBlackMarketItems(true)
	end
end

function SodacheShopView:_btnBlackMarketOnClick()
	self.shopType = SodacheEnum.ShopType.BlackMarket

	self.selectMo:clearAllGoodSelect()

	self.selectMo.isMultSelect = false

	self:_refreshView()
	self:_refreshBlackMarketItems()
	self:playBlackMarketChar(SodacheEnum.ShopChatTriggerType.OpenBlackMarket)
end

function SodacheShopView:_refreshBlackMarketItems(isUpdate)
	if not isUpdate then
		table.sort(self.curShopUnitMo.shop.items, SodacheShopView.sortGoods)
	end

	gohelper.CreateObjList(self, self._onCreateBlackShopItem, self.curShopUnitMo.shop.items, nil, self._goblackshopitem, SodacheBlackMarketShopItem)
	self:refreshRightInfo()
end

function SodacheShopView:playBlackMarketChar(type)
	local co = SodacheConfig.instance:getShopChatRandomCo(type)

	if not co then
		return
	end

	self._txtchat.text = co[1].content
end

function SodacheShopView:_onCreateBlackShopItem(obj, data, index)
	obj:setCellParam(self.selectMo)
	obj:updateMo(data)
end

function SodacheShopView:_refreshView()
	self.curShopUnitMo = self.viewParam[self.shopType]

	gohelper.setActive(self._goNormal, self.shopType == SodacheEnum.ShopType.Normal)
	gohelper.setActive(self._goBlackMarket, self.shopType == SodacheEnum.ShopType.BlackMarket)
	gohelper.setActive(self._goCount, self.shopType == SodacheEnum.ShopType.BlackMarket or self.shopType == SodacheEnum.ShopType.Normal and not self.selectMo.isMultSelect)
	gohelper.setActive(self._goSingleCard, self.shopType == SodacheEnum.ShopType.Normal and not self.selectMo.isMultSelect)
	gohelper.setActive(self._scrollMultiCard, self.shopType == SodacheEnum.ShopType.BlackMarket or self.selectMo.isMultSelect)
	gohelper.setActive(self._goMultiSelect, self.selectMo.isMultSelect)
end

function SodacheShopView:_btnMultiSelectOnClick()
	self.selectMo.isMultSelect = not self.selectMo.isMultSelect

	self:_refreshView()
	self:_onItemTypeClick()
end

function SodacheShopView:_btnShopOnClick()
	self.shopType = SodacheEnum.ShopType.Normal
	self.selectMo.isMultSelect = false

	self:_refreshView()
end

function SodacheShopView:_btnMinOnClick()
	self.selectMo:setCurGoodMin()
	self:refreshRightInfo()
end

function SodacheShopView:_btnSubOnClick()
	self.selectMo:addCurGoodCount(-1)
	self:refreshRightInfo()
end

function SodacheShopView:_btnAddOnClick()
	self.selectMo:addCurGoodCount(1)
	self:refreshRightInfo()
end

function SodacheShopView:_btnMaxOnClick()
	self.selectMo:setCurGoodMax()
	self:refreshRightInfo()
end

function SodacheShopView:_onInputChange()
	local count = tonumber(self._inputCount:GetText()) or 0
	local curCount = self.selectMo:getGoodSelectCount()

	if count == curCount then
		return
	end

	self.selectMo:addCurGoodCount(count - curCount)
	self:refreshRightInfo()
end

function SodacheShopView:_btnBuyOnClick()
	local nowCoin = SodacheUtil.getItemCount(SodacheEnum.CurrencyId.Coin, SodacheEnum.BagType.Inside)

	if nowCoin < self.allPrice then
		GameFacade.showToast(ToastEnum.SodacheToastId373001, SodacheUtil.getCurrencyName())

		return
	end

	if #self.selectMo.curSelectGoods <= 0 then
		return
	end

	local shopItems = {}

	for i, v in ipairs(self.selectMo.curSelectGoods) do
		table.insert(shopItems, {
			id = v.shopMo.id,
			count = v.selectCount
		})
	end

	SodacheInsideRpc.instance:sendSodacheInsideBatchBuy(self.curShopUnitMo.uid, shopItems)
end

function SodacheShopView:_editableInitView()
	UISpriteSetMgr.instance:setSodache2Sprite(self._imageCostIcon, SodacheUtil.getCurrencyIcon())
	MonoHelper.addNoUpdateLuaComOnceToGo(self._gocoin, SodacheCurrencyComp, {
		bagType = SodacheEnum.BagType.Inside
	})

	self.selectMo = SodacheShopSelectMo.New()
	self.cardInfoComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goSingleCard, SodacheCardInfoRight)
	self.simpleListNormal = MonoHelper.addNoUpdateLuaComOnceToGo(self._scrollShop, SurvivalSimpleListPart)

	self.simpleListNormal:setCellCls(SodacheGoodsItem)
	self.simpleListNormal:setCellParam(self.selectMo)

	self.simpleListMult = MonoHelper.addNoUpdateLuaComOnceToGo(self._scrollMultiCard, SurvivalSimpleListPart)

	self.simpleListMult:setCellCls(SodacheShopMultiCardItem)
	self.simpleListMult:setCellParam(self.selectMo)

	self.shopType = SodacheEnum.ShopType.Normal
	self.allPrice = 0
end

local showTypes = {
	SodacheEnum.CardType.Ammo,
	SodacheEnum.CardType.Adventure
}

function SodacheShopView:onOpen()
	self:_btnShopOnClick()

	local types = {}

	for k, v in ipairs(showTypes) do
		if self.curShopUnitMo.shop.itemsByItemTypes[v] then
			table.insert(types, v)
		end
	end

	self._btns = self:getUserDataTb_()

	gohelper.CreateObjList(self, self._onCreateItemTypeBtn, types, nil, self._gobtntype)
	self:_onItemTypeClick(types[1])
	gohelper.setActive(self._btnBlackMarket, self.viewParam[SodacheEnum.ShopType.BlackMarket])
end

function SodacheShopView:_onCreateItemTypeBtn(obj, data, index)
	local btn = gohelper.findButtonWithAudio(obj)
	local name = gohelper.findChildTextMesh(obj, "#txt_name")
	local name2 = gohelper.findChildTextMesh(obj, "#go_Select/#txt_name")
	local goselect = gohelper.findChild(obj, "#go_Select")
	local imageType = gohelper.findChildImage(obj, "#txt_name/icon")
	local imageType2 = gohelper.findChildImage(obj, "#go_Select/#txt_name/icon")

	name.text = luaLang("sodache_cardtype_" .. data)
	name2.text = luaLang("sodache_cardtype_" .. data)

	UISpriteSetMgr.instance:setSodache2Sprite(imageType, "sodache_handbook_icon_" .. tostring(data))
	UISpriteSetMgr.instance:setSodache2Sprite(imageType2, "sodache_handbook_icon_" .. tostring(data))

	self._btns[data] = goselect

	self:addClickCb(btn, self._onItemTypeClick, self, data)
end

function SodacheShopView:_onItemTypeClick(type, isUpdate)
	type = type or self._curItemType

	for k, v in pairs(self._btns) do
		gohelper.setActive(v, k == type)
	end

	self._curItemType = type

	if type then
		if isUpdate and not self.selectMo.isMultSelect then
			for i = #self.selectMo.curSelectGoods, 1, -1 do
				local mo = self.selectMo.curSelectGoods[i]

				if mo.shopMo.count == 0 then
					table.remove(self.selectMo.curSelectGoods, i)
				elseif mo.shopMo.count ~= -1 and mo.shopMo.count < mo.selectCount then
					mo.selectCount = mo.shopMo.count
				end
			end
		else
			self.selectMo:clearAllGoodSelect()
		end

		local list = self.curShopUnitMo.shop.itemsByItemTypes[type]

		if not isUpdate then
			table.sort(list, SodacheShopView.sortGoods)
		end

		if not self.selectMo.isMultSelect and not self.selectMo.curSelectGoods[1] and list[1] and list[1].count ~= 0 then
			self.selectMo:addGoodCount(list[1], 1)
		end

		self.simpleListNormal:setList(list)
		self:refreshRightInfo()
	end
end

function SodacheShopView.sortGoods(a, b)
	if a.count == 0 ~= (b.count == 0) then
		return a.count ~= 0
	end

	return a.id < b.id
end

function SodacheShopView:refreshRightInfo()
	if self.shopType == SodacheEnum.ShopType.BlackMarket then
		self:refreshMultiCard()
	elseif self.selectMo.isMultSelect then
		self:refreshMultiCard()
	else
		local selectMo = self.selectMo.curSelectGoods[1]

		if selectMo then
			self.cardInfoComp:setData(selectMo.shopMo.items[1])
		end
	end

	self:refreshPrice()
end

function SodacheShopView:refreshMultiCard()
	local moList = {}

	for i, v in ipairs(self.selectMo.curSelectGoods) do
		for _, vv in ipairs(v.shopMo.items) do
			table.insert(moList, {
				cardMo = vv,
				count = v.selectCount,
				shopMo = v.shopMo
			})
		end
	end

	self.simpleListMult:setList(moList)
end

function SodacheShopView:refreshPrice()
	local price = 0
	local fixrate = 0

	if self.shopType == SodacheEnum.ShopType.Normal then
		fixrate = SodacheUtil.getAttr(SodacheEnum.AttrId.ShopItemPriceFix)
	else
		fixrate = SodacheUtil.getAttr(SodacheEnum.AttrId.BlackMarketPriceFix)
	end

	for i, v in ipairs(self.selectMo.curSelectGoods) do
		price = price + v.selectCount * math.floor(v.shopMo.price * (1 + fixrate / 1000))
	end

	self._txtBuyCost.text = price
	self.allPrice = price

	self._inputCount:SetText(tostring(self.selectMo:getGoodSelectCount()))
end

return SodacheShopView
