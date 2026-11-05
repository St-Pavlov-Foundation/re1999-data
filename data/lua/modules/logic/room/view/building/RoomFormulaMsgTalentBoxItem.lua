-- chunkname: @modules/logic/room/view/building/RoomFormulaMsgTalentBoxItem.lua

module("modules.logic.room.view.building.RoomFormulaMsgTalentBoxItem", package.seeall)

local RoomFormulaMsgTalentBoxItem = class("RoomFormulaMsgTalentBoxItem", ListScrollCell)

function RoomFormulaMsgTalentBoxItem:init(go)
	self._go = go
	self._imagerare = gohelper.findChildImage(self._go, "#image_rare")
	self._simageproduceitem = gohelper.findChildSingleImage(self._go, "#simage_produceitem")
	self._txtNum = gohelper.findChildText(self._go, "image_NumBG/#txt_Num")
	self._txtInventory = gohelper.findChildText(self._go, "#txt_Inventory")
end

function RoomFormulaMsgTalentBoxItem:onUpdateMO(mo)
	local config, icon = ItemModel.instance:getItemConfigAndIcon(mo.type, mo.id)

	self._simageproduceitem:LoadImage(icon)
	UISpriteSetMgr.instance:setRoomSprite(self._imagerare, "huangyuan_pz_" .. tostring(ItemEnum.Color[config.rare]))

	local numDisplay = GameUtil.numberDisplay(mo.quantity)

	self._txtNum.text = luaLang("multiple") .. tostring(numDisplay)

	local inventory = ItemModel.instance:getItemQuantity(mo.type, mo.id)

	self._txtInventory.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("roomformulamsgboxview_inventory"), inventory)
end

function RoomFormulaMsgTalentBoxItem:onDestroy()
	self._simageproduceitem:UnLoadImage()
end

return RoomFormulaMsgTalentBoxItem
