-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheShopMultiCardItem.lua

module("modules.logic.sodache.view.inside.comp.SodacheShopMultiCardItem", package.seeall)

local SodacheShopMultiCardItem = class("SodacheShopMultiCardItem", LuaCompBase)

function SodacheShopMultiCardItem:ctor(param)
	self.cellParam = param
end

function SodacheShopMultiCardItem:init(go)
	self.cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, SodacheCardItem)

	self.cardItem:setOverrideClick(self._onItemClick, self)
	self.cardItem:showInfo({
		true,
		true,
		false
	})
end

function SodacheShopMultiCardItem:updateMo(mo)
	self.mo = mo

	self.cardItem:updateMo(mo.cardMo)
	self.cardItem:setCount(mo.count)
end

function SodacheShopMultiCardItem:_onItemClick()
	if self.cellParam.isMultSelect then
		self.cellParam:addGoodCount(self.mo.shopMo, -1)
		SodacheController.instance:dispatchEvent(SodacheEvent.OnClickGoodsItem)
	end
end

return SodacheShopMultiCardItem
