-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewPlayTaskGiftItem.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewPlayTaskGiftItem", package.seeall)

local GuessGameNewPlayTaskGiftItem = class("GuessGameNewPlayTaskGiftItem", LuaCompBase)

function GuessGameNewPlayTaskGiftItem:init(go)
	self.go = go
	self._imagegift = gohelper.findChildImage(self.go, "image_gift")
	self._txtnum = gohelper.findChildText(self.go, "txt_num")

	gohelper.setActive(self.go, true)
end

function GuessGameNewPlayTaskGiftItem:setTotalCount(count)
	self._totalCount = count
end

function GuessGameNewPlayTaskGiftItem:refresh(giftId)
	self._giftId = giftId
	self._config = GuessGameNewConfig.instance:getBoxGiftCo(self._giftId)

	UISpriteSetMgr.instance:setV3a7Activity3ndSprite(self._imagegift, self._config.iconsmall)
	self:refreshCount()
end

function GuessGameNewPlayTaskGiftItem:refreshCount()
	local unlockCount = GuessGameNewModel.instance:getGiftUnlockCount(self._giftId)

	self._txtnum.text = self._totalCount - unlockCount
end

function GuessGameNewPlayTaskGiftItem:destroy()
	return
end

return GuessGameNewPlayTaskGiftItem
