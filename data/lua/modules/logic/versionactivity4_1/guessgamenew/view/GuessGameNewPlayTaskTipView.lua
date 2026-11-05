-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewPlayTaskTipView.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewPlayTaskTipView", package.seeall)

local GuessGameNewPlayTaskTipView = class("GuessGameNewPlayTaskTipView", BaseView)

function GuessGameNewPlayTaskTipView:onInitView()
	self._gotargetgift = gohelper.findChild(self.viewGO, "#go_targetgift")
	self._imagetargetgift = gohelper.findChildImage(self.viewGO, "#go_targetgift/#image_targetgift")
	self._gogifts = gohelper.findChild(self.viewGO, "#go_gifts")
	self._gogiftitem = gohelper.findChild(self.viewGO, "#go_gifts/#go_giftitem")
	self._gotasktips = gohelper.findChild(self.viewGO, "#go_tasktips")
	self._imagegift = gohelper.findChildImage(self.viewGO, "#go_tasktips/#image_gift")
	self._txttasktip = gohelper.findChildText(self.viewGO, "#go_tasktips/#txt_tasktip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GuessGameNewPlayTaskTipView:addEvents()
	return
end

function GuessGameNewPlayTaskTipView:removeEvents()
	return
end

function GuessGameNewPlayTaskTipView:_editableInitView()
	self:_initView()
	self:_addSelfEvents()
end

function GuessGameNewPlayTaskTipView:_initView()
	gohelper.setActive(self._gogiftitem, false)

	self._tipGiftItems = self:getUserDataTb_()
end

function GuessGameNewPlayTaskTipView:_addSelfEvents()
	self:addEventCb(GuessGameNewController.instance, GuessGameNewEvent.OnTaskTipReset, self._refresh, self)
	self:addEventCb(GuessGameNewController.instance, GuessGameNewEvent.OnRefreshTaskTipUnlockChanged, self._onUnlockGiftChanged, self)
end

function GuessGameNewPlayTaskTipView:_removeSelfEvents()
	self:removeEventCb(GuessGameNewController.instance, GuessGameNewEvent.OnTaskTipReset, self._refresh, self)
	self:removeEventCb(GuessGameNewController.instance, GuessGameNewEvent.OnRefreshTaskTipUnlockChanged, self._onUnlockGiftChanged, self)
end

function GuessGameNewPlayTaskTipView:_onUnlockGiftChanged()
	if self._tipGiftItems then
		for _, v in pairs(self._tipGiftItems) do
			v:refreshCount()
		end
	end
end

function GuessGameNewPlayTaskTipView:onUpdateParam()
	return
end

function GuessGameNewPlayTaskTipView:onOpen()
	self:_refresh()
end

function GuessGameNewPlayTaskTipView:_refresh()
	self:_refreshTargetGift()
	self:_refreshGifts()
end

function GuessGameNewPlayTaskTipView:_refreshTargetGift()
	local targetGiftId = GuessGameNewModel.instance:getTargetGiftId()
	local config = GuessGameNewConfig.instance:getBoxGiftCo(targetGiftId)

	UISpriteSetMgr.instance:setV3a7Activity3ndSprite(self._imagetargetgift, config.icon)
end

function GuessGameNewPlayTaskTipView:_refreshGifts()
	local episodeCo = GuessGameNewConfig.instance:getEpisodeCo(1)
	local lays = GameUtil.splitString2(episodeCo.layout, true, "|", "#")
	local totalCounts, giftIds = {}, {}

	for _, lay in ipairs(lays) do
		local giftId = tonumber(lay[1])

		if not totalCounts[giftId] then
			totalCounts[giftId] = 0

			table.insert(giftIds, giftId)
		end

		totalCounts[giftId] = totalCounts[giftId] + tonumber(lay[2])
	end

	table.sort(giftIds)

	for index, giftId in ipairs(giftIds) do
		if not self._tipGiftItems[index] then
			self._tipGiftItems[index] = GuessGameNewPlayTaskGiftItem.New()

			local go = gohelper.cloneInPlace(self._gogiftitem)

			self._tipGiftItems[index]:init(go)
			self._tipGiftItems[index]:setTotalCount(totalCounts[giftId])
		end

		self._tipGiftItems[index]:refresh(giftId)
	end
end

function GuessGameNewPlayTaskTipView:_onPlayScoreEffFinished()
	gohelper.setActive(self._goaddeff, false)
	gohelper.setActive(self._goreduceeff, false)
end

function GuessGameNewPlayTaskTipView:onClose()
	return
end

function GuessGameNewPlayTaskTipView:onDestroyView()
	TaskDispatcher.cancelTask(self._onPlayScoreEffFinished, self)

	if self._tipGiftItems then
		for _, v in pairs(self._tipGiftItems) do
			v:destroy()
		end

		self._tipGiftItems = nil
	end

	self:_removeSelfEvents()
end

return GuessGameNewPlayTaskTipView
