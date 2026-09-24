-- chunkname: @modules/logic/store/view/decorate/DecorateStoreBundleCompType1Item.lua

module("modules.logic.store.view.decorate.DecorateStoreBundleCompType1Item", package.seeall)

local DecorateStoreBundleCompType1Item = class("DecorateStoreBundleCompType1Item", LuaCompBase)

function DecorateStoreBundleCompType1Item.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, DecorateStoreBundleCompType1Item)
end

function DecorateStoreBundleCompType1Item:init(go)
	self.go = go
	self._simagehero = gohelper.findChildSingleImage(self.go, "#simage_heroskin")
	self._goselect = gohelper.findChild(self.go, "#go_select")
	self._goowned = gohelper.findChild(self.go, "#go_owned")
	self._btnClick = SLFramework.UGUI.ButtonWrap.Get(self.go)

	self:_initItem()
	self:_addEvents()
end

function DecorateStoreBundleCompType1Item:_initItem()
	gohelper.setActive(self._goselect, false)
	gohelper.setActive(self._goowned, false)
end

function DecorateStoreBundleCompType1Item:_addEvents()
	self._btnClick:AddClickListener(self._onItemClick, self)
end

function DecorateStoreBundleCompType1Item:_removeEvents()
	self._btnClick:RemoveClickListener()
end

function DecorateStoreBundleCompType1Item:selectGood()
	self:_onItemClick()
end

function DecorateStoreBundleCompType1Item:_onItemClick()
	DecorateStoreModel.instance:setCurGood(self._goodId)
	StoreController.instance:dispatchEvent(StoreEvent.DecorateGoodItemClick, self._goodId)
end

function DecorateStoreBundleCompType1Item:refresh(goodId, storeId)
	self._goodId = goodId
	self._storeId = storeId
	self._decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(self._goodId)
	self._goodCo = StoreConfig.instance:getGoodsConfig(self._goodId)

	if self._decorateConfig and not self._goodCo then
		logError("please check store_decorate goodId:" .. self._goodId .. " not found in store_goods!")

		return
	end

	local curGoodId = DecorateStoreModel.instance:getCurGood(self._storeId)

	gohelper.setActive(self._goselect, curGoodId == self._goodId)

	local isOwn = DecorateStoreModel.instance:isDecorateGoodItemHas(self._goodId)

	gohelper.setActive(self._goowned, isOwn)

	local itemCos = string.splitToNumber(self._goodCo.product, "#")
	local itemCo, itemIcon = ItemModel.instance:getItemConfigAndIcon(itemCos[1], itemCos[2], true)

	self._simagehero:LoadImage(itemIcon)
end

function DecorateStoreBundleCompType1Item:destroy()
	self:_removeEvents()
end

return DecorateStoreBundleCompType1Item
