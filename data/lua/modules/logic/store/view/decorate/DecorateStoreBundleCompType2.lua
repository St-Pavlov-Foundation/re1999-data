-- chunkname: @modules/logic/store/view/decorate/DecorateStoreBundleCompType2.lua

module("modules.logic.store.view.decorate.DecorateStoreBundleCompType2", package.seeall)

local DecorateStoreBundleCompType2 = class("DecorateStoreBundleCompType2", LuaCompBase)

function DecorateStoreBundleCompType2.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, DecorateStoreBundleCompType2)
end

function DecorateStoreBundleCompType2:init(go)
	self.go = go
	self._txtdesc = gohelper.findChildText(go, "txt_desc")
	self._simagepackage = gohelper.findChildSingleImage(go, "scroll_products/viewport/content/#simage_package")
	self._gopackageselect = gohelper.findChild(go, "scroll_products/viewport/content/#simage_package/#go_select")
	self._btnpackageclick = gohelper.findChildButtonWithAudio(go, "scroll_products/viewport/content/#simage_package/#btn_click")
	self._goitem = gohelper.findChild(go, "scroll_products/viewport/content/grid/#go_item")

	self:_initItem()
	self:_addEvents()
end

function DecorateStoreBundleCompType2:_initItem()
	self._subGoodsItem = {}

	gohelper.setActive(self._goitem, false)
end

function DecorateStoreBundleCompType2:_onClickPackage()
	DecorateStoreModel.instance:setCurGood(self._packageGoodId)
	StoreController.instance:dispatchEvent(StoreEvent.DecorateGoodItemClick, self._packageGoodId)
	self:_refreshType()
end

function DecorateStoreBundleCompType2:_onGoodItemClick()
	self:_refreshType()
end

function DecorateStoreBundleCompType2:_addEvents()
	self._btnpackageclick:AddClickListener(self._onClickPackage, self)
	StoreController.instance:registerCallback(StoreEvent.DecorateGoodItemClick, self._onGoodItemClick, self)
end

function DecorateStoreBundleCompType2:_removeEvents()
	self._btnpackageclick:RemoveClickListener()
	StoreController.instance:unregisterCallback(StoreEvent.DecorateGoodItemClick, self._onGoodItemClick, self)
end

function DecorateStoreBundleCompType2:refresh(goodId, storeId)
	self._packageGoodId = goodId

	local decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(goodId)

	if decorateConfig and decorateConfig.fatherGoods > 0 then
		self._packageGoodId = decorateConfig.fatherGoods
	end

	self._storeId = storeId
	self._decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(self._packageGoodId)
	self._goodConfig = StoreConfig.instance:getGoodsConfig(self._packageGoodId)

	self:_refreshType()
end

function DecorateStoreBundleCompType2:_refreshType()
	self:_refreshPackage()
	self:_refreshItems()
end

function DecorateStoreBundleCompType2:_refreshPackage()
	self._txtdesc.text = ""

	self._simagepackage:LoadImage(ResUrl.getDecorateStoreImg(self._decorateConfig.smalllmg))

	local curGoodId = DecorateStoreModel.instance:getCurGood(self._storeId)

	gohelper.setActive(self._gopackageselect, curGoodId == self._packageGoodId)
end

function DecorateStoreBundleCompType2:_refreshItems()
	local goods = DecorateStoreModel.instance:getBundleSubGoods(self._packageGoodId)

	for index, goodCo in pairs(goods) do
		if not self._subGoodsItem[index] then
			local go = gohelper.cloneInPlace(self._goitem, goodCo.id)

			gohelper.setActive(go, true)

			self._subGoodsItem[index] = DecorateStoreBundleCompType2Item.Get(go)
		end

		self._subGoodsItem[index]:refresh(goodCo.id, self._storeId)
	end
end

function DecorateStoreBundleCompType2:destroy()
	self._simagepackage:UnLoadImage()
	self:_removeEvents()

	if self._subGoodsItem then
		for _, item in pairs(self._subGoodsItem) do
			item:destroy()
		end

		self._subGoodsItem = nil
	end
end

return DecorateStoreBundleCompType2
