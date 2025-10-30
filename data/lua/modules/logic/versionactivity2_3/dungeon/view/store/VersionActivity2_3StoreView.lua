﻿-- chunkname: @modules/logic/versionactivity2_3/dungeon/view/store/VersionActivity2_3StoreView.lua

module("modules.logic.versionactivity2_3.dungeon.view.store.VersionActivity2_3StoreView", package.seeall)

local VersionActivity2_3StoreView = class("VersionActivity2_3StoreView", BaseView)

function VersionActivity2_3StoreView:onInitView()
	self._scrollstore = gohelper.findChildScrollRect(self.viewGO, "#scroll_store")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content")
	self._gostoreItem = gohelper.findChild(self.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem")
	self._txttime = gohelper.findChildText(self.viewGO, "title/image_LimitTimeBG/#txt_time")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_3StoreView:addEvents()
	self._scrollstore:AddOnValueChanged(self._onScrollValueChanged, self)
	self:addEventCb(JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)
end

function VersionActivity2_3StoreView:removeEvents()
	self._scrollstore:RemoveOnValueChanged()
	self:removeEventCb(JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)
end

function VersionActivity2_3StoreView:_onScrollValueChanged()
	if #self.storeItemList > 0 then
		local storeItem = self.storeItemList[1]

		if storeItem then
			storeItem:refreshTagClip(self._scrollstore)
		end
	end
end

function VersionActivity2_3StoreView:_editableInitView()
	gohelper.setActive(self._gostoreItem, false)

	self.actId = VersionActivity2_3Enum.ActivityId.DungeonStore
	self.storeItemList = self:getUserDataTb_()
	self.rectTrContent = self._goContent:GetComponent(gohelper.Type_RectTransform)
end

function VersionActivity2_3StoreView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	self:refreshTime()
	TaskDispatcher.runRepeat(self.refreshTime, self, TimeUtil.OneMinuteSecond)
	self:refreshStoreContent()
	self:_onScrollValueChanged()
	self:scrollToFirstNoSellOutStore()
end

function VersionActivity2_3StoreView:refreshTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_3Enum.ActivityId.DungeonStore]
	local remainTimeStr = actInfoMo:getRemainTimeStr3(false, false)

	self._txttime.text = remainTimeStr
end

function VersionActivity2_3StoreView:refreshStoreContent()
	local storeGroupDict = self.actId and ActivityStoreConfig.instance:getActivityStoreGroupDict(self.actId)

	if not storeGroupDict then
		return
	end

	local storeItem

	for i = 1, #storeGroupDict do
		storeItem = self.storeItemList[i]

		if not storeItem then
			local storeItemGo = gohelper.cloneInPlace(self._gostoreItem)

			storeItem = VersionActivity2_3StoreItem.New()

			storeItem:onInitView(storeItemGo)
			table.insert(self.storeItemList, storeItem)
		end

		storeItem:updateInfo(i, storeGroupDict[i])
	end
end

function VersionActivity2_3StoreView:scrollToFirstNoSellOutStore()
	local firstNoSellOutIndex = self:getFirstNoSellOutGroup()

	if firstNoSellOutIndex <= 1 then
		return
	end

	ZProj.UGUIHelper.RebuildLayout(self.rectTrContent)

	local height = 0

	for i, storeItem in ipairs(self.storeItemList) do
		if firstNoSellOutIndex <= i then
			break
		end

		height = height + storeItem:getHeight()
	end

	local viewPortTr = gohelper.findChildComponent(self.viewGO, "#scroll_store/Viewport", gohelper.Type_RectTransform)
	local viewPortHeight = recthelper.getHeight(viewPortTr)
	local contentHeight = recthelper.getHeight(self.rectTrContent)
	local maxAnchorY = contentHeight - viewPortHeight

	recthelper.setAnchorY(self.rectTrContent, math.min(height, maxAnchorY))
end

function VersionActivity2_3StoreView:getFirstNoSellOutGroup()
	local storeGroupDict = ActivityStoreConfig.instance:getActivityStoreGroupDict(self.actId)

	for index, groupGoodsCoList in ipairs(storeGroupDict) do
		for _, goodsCo in ipairs(groupGoodsCoList) do
			if goodsCo.maxBuyCount == 0 then
				return index
			end

			if goodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(self.actId, goodsCo.id) > 0 then
				return index
			end
		end
	end

	return 1
end

function VersionActivity2_3StoreView:onClose()
	TaskDispatcher.cancelTask(self.refreshTime, self)
end

function VersionActivity2_3StoreView:onDestroyView()
	for _, storeItem in ipairs(self.storeItemList) do
		storeItem:onDestroy()
	end
end

return VersionActivity2_3StoreView
