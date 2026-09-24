-- chunkname: @modules/logic/store/view/decorate/DecorateStoreGoodTabCompItem.lua

module("modules.logic.store.view.decorate.DecorateStoreGoodTabCompItem", package.seeall)

local DecorateStoreGoodTabCompItem = class("DecorateStoreGoodTabCompItem", LuaCompBase)

function DecorateStoreGoodTabCompItem.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, DecorateStoreGoodTabCompItem)
end

function DecorateStoreGoodTabCompItem:init(go)
	self.go = go
	self._gospbg = gohelper.findChild(go, "#go_spbg ")
	self._imagerare = gohelper.findChildImage(go, "#image_rare")
	self._goselect = gohelper.findChild(go, "select")
	self._simageicon = gohelper.findChildSingleImage(go, "#image_icon")
	self._gounselect = gohelper.findChild(go, "unselect")
	self._btnClick = gohelper.getClick(go)

	self:_initItem()
	self:_addEvents()
end

function DecorateStoreGoodTabCompItem:_initItem()
	self._subGoodsItem = {}

	gohelper.setActive(self._gospbg, false)
	gohelper.setActive(self._goselect, false)
	gohelper.setActive(self._gounselect, false)
end

function DecorateStoreGoodTabCompItem:_addEvents()
	self._btnClick:AddClickListener(self._onItemClick, self)
	StoreController.instance:registerCallback(StoreEvent.DecorateGoodItemClick, self._onGoodItemClick, self)
end

function DecorateStoreGoodTabCompItem:_removeEvents()
	self._btnClick:RemoveClickListener()
	StoreController.instance:unregisterCallback(StoreEvent.DecorateGoodItemClick, self._onGoodItemClick, self)
end

function DecorateStoreGoodTabCompItem:_onItemClick()
	DecorateStoreModel.instance:setCurGood(self._goodId)
	StoreController.instance:dispatchEvent(StoreEvent.DecorateGoodItemClick, self._goodId)
end

function DecorateStoreGoodTabCompItem:_onGoodItemClick()
	self:_refreshItem()
end

function DecorateStoreGoodTabCompItem:refresh(goodId)
	self._goodId = goodId
	self._decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(goodId)
	self._goodCo = StoreConfig.instance:getGoodsConfig(goodId)
	self._storeId = self._goodCo and tonumber(self._goodCo.storeId) or StoreEnum.StoreId.SpiritualityDecorateStore

	self:_refreshItem()
end

function DecorateStoreGoodTabCompItem:_refreshItem()
	local curGoodId = DecorateStoreModel.instance:getCurGood(self._storeId)

	gohelper.setActive(self._goselect, curGoodId == self._goodId)

	local itemCos = string.splitToNumber(self._goodCo.product, "#")
	local itemCo, itemIcon = ItemModel.instance:getItemConfigAndIcon(itemCos[1], itemCos[2], true)

	self._simageicon:LoadImage(itemIcon)

	local curItemType = DecorateStoreModel.getItemTypeByGoodId(self._goodId)
	local showRare = curItemType ~= DecorateStoreEnum.DecorateItemType.Skin and curItemType ~= DecorateStoreEnum.DecorateItemType.Hero

	gohelper.setActive(self._imagerare.gameObject, showRare)

	if showRare then
		local rare = itemCo.rare or 5

		UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "bgequip" .. tostring(ItemEnum.Color[rare]))
	end
end

function DecorateStoreGoodTabCompItem:destroy()
	self:_removeEvents()
end

return DecorateStoreGoodTabCompItem
