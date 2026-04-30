-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheMapCardUseItem.lua

module("modules.logic.sodache.view.inside.comp.SodacheMapCardUseItem", package.seeall)

local SodacheMapCardUseItem = class("SodacheMapCardUseItem", LuaCompBase)

function SodacheMapCardUseItem:init(go)
	self.go = go
	self.cardGo = gohelper.findChild(go, "sodache_carditem")
	self.cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(self.cardGo, SodacheCardItem)

	self.cardItem:setOverrideClick(self.onCardClick, self)
end

function SodacheMapCardUseItem:updateMo(data)
	self.data = data

	self.cardItem:updateMo(data)
end

function SodacheMapCardUseItem:onCardClick()
	ViewMgr.instance:openView(ViewName.SodacheCardDetailView, {
		cardMo = self.data,
		subView = SodacheCardDetailUseItemPart.New()
	})
end

function SodacheMapCardUseItem:setActive(isActive)
	gohelper.setActive(self.cardGo, isActive)
end

return SodacheMapCardUseItem
