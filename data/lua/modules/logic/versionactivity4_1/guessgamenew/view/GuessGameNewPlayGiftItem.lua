-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewPlayGiftItem.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewPlayGiftItem", package.seeall)

local GuessGameNewPlayGiftItem = class("GuessGameNewPlayGiftItem", LuaCompBase)

function GuessGameNewPlayGiftItem:init(go, index)
	self.go = go
	self._index = index
	self._anim = self.go:GetComponent(gohelper.Type_Animator)
	self._goopen = gohelper.findChild(self.go, "root/open")
	self._imagegift = gohelper.findChildImage(self.go, "root/open/#image_gift")
	self._simagegift = gohelper.findChildSingleImage(self.go, "root/open/#image_gift")
	self._goresult = gohelper.findChild(self.go, "root/open/result")
	self._gowrong = gohelper.findChild(self.go, "root/open/result/wrong")
	self._gocorrect = gohelper.findChild(self.go, "root/open/result/correct")
	self._gounopen = gohelper.findChild(self.go, "root/unopen")
	self._gounselect = gohelper.findChild(self.go, "root/unopen/unselect")
	self._goselect = gohelper.findChild(self.go, "root/select")
	self._goclick = gohelper.findChild(self.go, "root/clickarea")
	self._btnclick = gohelper.getClick(self._goclick)

	self:_initItem()
	self:_addEvents()
end

function GuessGameNewPlayGiftItem:_initItem()
	gohelper.setActive(self.go, true)
	gohelper.setActive(self._goselect, false)
	gohelper.setActive(self._goresult, false)
	gohelper.setActive(self._gowrong, false)
	gohelper.setActive(self._gocorrect, false)
end

function GuessGameNewPlayGiftItem:_addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function GuessGameNewPlayGiftItem:_removeEvents()
	self._btnclick:RemoveClickListener()
end

function GuessGameNewPlayGiftItem:showItem(show)
	gohelper.setActive(self.go, show)
end

function GuessGameNewPlayGiftItem:setScale(scale)
	transformhelper.setLocalScale(self.go.transform, scale, scale, 1)
end

function GuessGameNewPlayGiftItem:showSelect(show)
	self._showSelect = show

	gohelper.setActive(self._goselect, show)
end

function GuessGameNewPlayGiftItem:playAnim(animName)
	self._anim:Play(animName, 0, 0)
end

function GuessGameNewPlayGiftItem:showResult(show, isRight)
	gohelper.setActive(self._goresult, show)
end

function GuessGameNewPlayGiftItem:_btnclickOnClick()
	if not self._enableClick then
		return
	end

	if self._clickCallback then
		self._clickCallback(self._clickCallbackObj, self._index)
	end
end

function GuessGameNewPlayGiftItem:showOpen(show)
	gohelper.setActive(self._goopen, show)
	gohelper.setActive(self._gounopen, not show)

	local itemAnimName = show and "open_idle" or "unopen_idle"

	self:playAnim(itemAnimName)
end

function GuessGameNewPlayGiftItem:enableClick(enable)
	self._enableClick = enable

	if not enable then
		self._clickCallback = nil
		self._clickCallbackObj = nil
	end
end

function GuessGameNewPlayGiftItem:refresh(giftId)
	self._giftId = giftId
	self._config = GuessGameNewConfig.instance:getBoxGiftCo(giftId)

	if self._config.type == GuessGameNewEnum.GiftType.Wild then
		self._simagegift:LoadImage(ResUrl.getV4a1GuessGameNewLangSingleBg(self._config.icon))
	else
		UISpriteSetMgr.instance:setV3a7Activity3ndSprite(self._imagegift, self._config.icon)
	end
end

function GuessGameNewPlayGiftItem:getGiftId()
	return self._giftId or 1
end

function GuessGameNewPlayGiftItem:setClickCallback(callback, callbackObj)
	self._enableClick = true
	self._clickCallback = callback
	self._clickCallbackObj = callbackObj
end

function GuessGameNewPlayGiftItem:clearClickCallback()
	self._enableClick = false
	self._clickCallback = nil
	self._clickCallbackObj = nil
end

function GuessGameNewPlayGiftItem:destroy()
	self._clickCallback = nil
	self._clickCallbackObj = nil

	self._simagegift:UnLoadImage()
	self:_removeEvents()
end

return GuessGameNewPlayGiftItem
