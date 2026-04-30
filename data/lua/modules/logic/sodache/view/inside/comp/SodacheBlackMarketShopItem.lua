-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheBlackMarketShopItem.lua

module("modules.logic.sodache.view.inside.comp.SodacheBlackMarketShopItem", package.seeall)

local SodacheBlackMarketShopItem = class("SodacheBlackMarketShopItem", LuaCompBase)

function SodacheBlackMarketShopItem:init(go)
	self._golimit = gohelper.findChild(go, "limit")
	self._txtlimit = gohelper.findChildTextMesh(go, "limit/#txt_limit")
	self._txtname = gohelper.findChildTextMesh(go, "name/txt_Name")
	self._goprice = gohelper.findChild(go, "price")
	self._txtprice = gohelper.findChildTextMesh(go, "price/txt_Price")
	self._goselect = gohelper.findChild(go, "go_Select")
	self._btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")
	self._goitemparent = gohelper.findChild(go, "layout")
	self._goitem = gohelper.findChild(go, "layout/CardItem")
	self._gosoldout = gohelper.findChild(go, "go_soldout")
end

function SodacheBlackMarketShopItem:addEventListeners()
	self._btnClick:AddClickListener(self._onClickItem, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnClickGoodsItem, self.refreshCount, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnShopItemUpdate, self.onShopItemUpdate, self)
end

function SodacheBlackMarketShopItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
	SodacheController.instance:unregisterCallback(SodacheEvent.OnClickGoodsItem, self.refreshCount, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnShopItemUpdate, self.onShopItemUpdate, self)
end

function SodacheBlackMarketShopItem:setCellParam(cellParam)
	self.cellParam = cellParam
end

function SodacheBlackMarketShopItem:updateMo(data)
	self.data = data

	gohelper.setActive(self._golimit, data.count > 0)
	gohelper.setActive(self._gosoldout, data.count == 0)

	if data.count > 0 then
		self._txtlimit.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sodache_shopview_limit"), data.count)
	end

	self._txtname.text = data.goodCo.bundleName

	if not string.nilorempty(data.goodCo.bundleDiscount) then
		gohelper.setActive(self._goprice, true)

		self._txtprice.text = data.goodCo.bundleDiscount
	else
		gohelper.setActive(self._goprice, false)
	end

	self:refreshCount()
	gohelper.CreateObjList(self, self._createItem, data.items, self._goitemparent, self._goitem, SodacheCardItem)
end

function SodacheBlackMarketShopItem:onShopItemUpdate(updateIds)
	if not updateIds[self.data.id] then
		return
	end

	if self.cloneGo then
		gohelper.destroy(self.cloneGo)
	end

	local cloneGo = gohelper.cloneInPlace(self._goitemparent)

	self.cloneGo = cloneGo

	ZProj.TweenHelper.DOScale(cloneGo.transform, 0.2, 0.2, 0.2, 0.5)
	ZProj.TweenHelper.DOFadeCanvasGroup(cloneGo, 1, 0.1, 0.5, self._destoryCloneGo, self)
end

function SodacheBlackMarketShopItem:_destoryCloneGo()
	gohelper.destroy(self.cloneGo)

	self.cloneGo = nil
end

function SodacheBlackMarketShopItem:_createItem(obj, data, index)
	obj:updateMo(data)
end

function SodacheBlackMarketShopItem:refreshCount()
	gohelper.setActive(self._goselect, self.cellParam:getGoodSelectCount(self.data.id) > 0)
end

function SodacheBlackMarketShopItem:_onClickItem()
	self.cellParam:addGoodCount(self.data, 0)
	SodacheController.instance:dispatchEvent(SodacheEvent.OnClickGoodsItem)
end

return SodacheBlackMarketShopItem
