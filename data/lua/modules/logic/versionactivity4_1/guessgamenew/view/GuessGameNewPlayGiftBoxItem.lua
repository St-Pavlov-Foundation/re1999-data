-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewPlayGiftBoxItem.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewPlayGiftBoxItem", package.seeall)

local GuessGameNewPlayGiftBoxItem = class("GuessGameNewPlayGiftBoxItem", LuaCompBase)

function GuessGameNewPlayGiftBoxItem:init(go)
	self.go = go
	self._imageicon = gohelper.findChildImage(self.go, "image_icon")
	self._txtcount = gohelper.findChild(self.go, "txt_count")

	gohelper.setActive(self.go, true)
	self:_addEvents()
end

function GuessGameNewPlayGiftBoxItem:_addEvents()
	return
end

function GuessGameNewPlayGiftBoxItem:_removeEvents()
	return
end

function GuessGameNewPlayGiftBoxItem:refresh(mo)
	self._mo = mo
end

function GuessGameNewPlayGiftBoxItem:destroy()
	self:_removeEvents()
end

return GuessGameNewPlayGiftBoxItem
