-- chunkname: @modules/logic/store/view/decorate/DecorateStoreBundleCompType1.lua

module("modules.logic.store.view.decorate.DecorateStoreBundleCompType1", package.seeall)

local DecorateStoreBundleCompType1 = class("DecorateStoreBundleCompType1", LuaCompBase)

function DecorateStoreBundleCompType1.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, DecorateStoreBundleCompType1)
end

function DecorateStoreBundleCompType1:init(go)
	self.go = go
	self._txtdesc = gohelper.findChildText(go, "txt_desc")
	self._goitem = gohelper.findChild(go, "scroll_products/viewport/content/#go_item")

	self:_initItem()
	self:_addEvents()
end

function DecorateStoreBundleCompType1:_initItem()
	self._subGoodsItem = {}

	gohelper.setActive(self._goitem, false)
end

function DecorateStoreBundleCompType1:_addEvents()
	StoreController.instance:registerCallback(StoreEvent.DecorateGoodItemClick, self._onGoodItemClick, self)
end

function DecorateStoreBundleCompType1:_removeEvents()
	StoreController.instance:unregisterCallback(StoreEvent.DecorateGoodItemClick, self._onGoodItemClick, self)
end

function DecorateStoreBundleCompType1:_onGoodItemClick()
	self:_refreshItems()
end

function DecorateStoreBundleCompType1:refresh(goodId, storeId)
	self._goodId = goodId

	local decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(goodId)

	if decorateConfig and decorateConfig.fatherGoods > 0 then
		self._goodId = decorateConfig.fatherGoods
	end

	self._storeId = storeId

	self:_refreshType()
	self:_refreshItems()
end

function DecorateStoreBundleCompType1:_refreshType()
	self._txtdesc.text = ""
end

function DecorateStoreBundleCompType1:_refreshItems()
	local goods = DecorateStoreModel.instance:getBundleSubGoods(self._goodId)

	if not goods then
		return
	end

	local curGoodId = DecorateStoreModel.instance:getCurGood(self._storeId)

	for index, goodCo in ipairs(goods) do
		if not self._subGoodsItem[index] then
			local go = gohelper.cloneInPlace(self._goitem, goodCo.id)

			gohelper.setActive(go, true)

			self._subGoodsItem[index] = DecorateStoreBundleCompType1Item.Get(go)
		end

		self._subGoodsItem[index]:refresh(goodCo.id, self._storeId)

		if curGoodId == self._goodId and index == 1 then
			self._subGoodsItem[index]:selectGood()
		end
	end
end

function DecorateStoreBundleCompType1:destroy()
	if self._subGoodsItem then
		for _, item in pairs(self._subGoodsItem) do
			item:destroy()
		end

		self._subGoodsItem = nil
	end

	self:_removeEvents()
end

return DecorateStoreBundleCompType1
