-- chunkname: @modules/logic/store/view/decorate/DecorateStoreGoodTabComp.lua

module("modules.logic.store.view.decorate.DecorateStoreGoodTabComp", package.seeall)

local DecorateStoreGoodTabComp = class("DecorateStoreGoodTabComp", LuaCompBase)

function DecorateStoreGoodTabComp.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, DecorateStoreGoodTabComp)
end

function DecorateStoreGoodTabComp:init(go)
	self.go = go
	self._goitem = gohelper.findChild(go, "root/Scrollview/Viewport/Content/#go_Tabitem")

	self:_initItem()
	self:_addEvents()
end

function DecorateStoreGoodTabComp:_initItem()
	gohelper.setActive(self._goitem, false)

	self._subGoodsItem = {}
end

function DecorateStoreGoodTabComp:_addEvents()
	StoreController.instance:registerCallback(StoreEvent.DecorateGoodItemClick, self._onGoodItemClick, self)
end

function DecorateStoreGoodTabComp:_removeEvents()
	StoreController.instance:unregisterCallback(StoreEvent.DecorateGoodItemClick, self._onGoodItemClick, self)
end

function DecorateStoreGoodTabComp:_onGoodItemClick()
	self:_refreshItems()
end

function DecorateStoreGoodTabComp:hide(hide)
	gohelper.setActive(self.go, not hide)
end

function DecorateStoreGoodTabComp:refresh(goodId)
	self._goodId = goodId

	local decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(goodId)

	if decorateConfig and decorateConfig.fatherGoods > 0 then
		self._goodId = decorateConfig.fatherGoods
	end

	self:_refreshItems()
end

function DecorateStoreGoodTabComp:_refreshItems()
	local goods = DecorateStoreModel.instance:getBundleSubGoods(self._goodId)

	if not goods then
		return
	end

	for index, goodCo in ipairs(goods) do
		if not self._subGoodsItem[index] then
			local go = gohelper.cloneInPlace(self._goitem, goodCo.id)

			gohelper.setActive(go, true)

			self._subGoodsItem[index] = DecorateStoreGoodTabCompItem.Get(go)
		end

		self._subGoodsItem[index]:refresh(goodCo.id)
	end
end

function DecorateStoreGoodTabComp:destroy()
	MonoHelper.removeLuaComFromGo(self.go, DecorateStoreGoodTabComp)

	if self._subGoodsItem then
		for _, item in pairs(self._subGoodsItem) do
			item:destroy()
		end

		self._subGoodsItem = nil
	end

	self:_removeEvents()
end

return DecorateStoreGoodTabComp
