﻿-- chunkname: @modules/logic/season/view1_6/Season1_6StoreView.lua

module("modules.logic.season.view1_6.Season1_6StoreView", package.seeall)

local Season1_6StoreView = class("Season1_6StoreView", BaseView)

function Season1_6StoreView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._txttime = gohelper.findChildText(self.viewGO, "title/#txt_time")
	self._goContent = gohelper.findChild(self.viewGO, "mask/#scroll_store/Viewport/#go_Content")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_6StoreView:addEvents()
	return
end

function Season1_6StoreView:removeEvents()
	return
end

function Season1_6StoreView:_editableInitView()
	self._simagebg:LoadImage(SeasonViewHelper.getSeasonIcon("full/shangcheng_bj.png"))
	gohelper.setActive(self._gostoreItem, false)

	self.storeItemList = self:getUserDataTb_()
end

function Season1_6StoreView:onUpdateParam()
	return
end

function Season1_6StoreView:onOpen()
	self:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnGet107GoodsInfo, self._onGet107GoodsInfo, self)
	self:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self._onBuyGoodsSuccess, self)

	self.actId = self.viewParam.actId

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	TaskDispatcher.runRepeat(self.refreshTime, self, TimeUtil.OneMinuteSecond)
	self:refreshTime()
	self:updateView()
end

function Season1_6StoreView:_onGet107GoodsInfo(actId)
	if actId ~= self.actId then
		return
	end

	self:updateView()
end

function Season1_6StoreView:_onBuyGoodsSuccess(actId)
	if actId ~= self.actId then
		return
	end

	self:updateView()
end

function Season1_6StoreView:updateView()
	self:refreshStoreContent()
end

function Season1_6StoreView:refreshStoreContent()
	local storeGroupDict = ActivityStoreConfig.instance:getActivityStoreGroupDict(self.actId)
	local list = {}

	if storeGroupDict then
		for _, storelist in pairs(storeGroupDict) do
			for _, v in pairs(storelist) do
				table.insert(list, v)
			end
		end
	end

	table.sort(list, Season1_6StoreView.sortGoods)

	for i = 1, math.max(#list, #self.storeItemList) do
		local storeItem = self.storeItemList[i]

		if not storeItem then
			storeItem = Season1_6StoreItem.New(self:getItemGo(i))
			self.storeItemList[i] = storeItem
		end

		storeItem:setData(list[i])
	end
end

function Season1_6StoreView.sortGoods(goodCo1, goodCo2)
	local goods1SellOut = goodCo1.maxBuyCount ~= 0 and goodCo1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(goodCo1.activityId, goodCo1.id) <= 0
	local goods2SellOut = goodCo2.maxBuyCount ~= 0 and goodCo2.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(goodCo2.activityId, goodCo2.id) <= 0

	if goods1SellOut ~= goods2SellOut then
		if goods1SellOut then
			return false
		end

		return true
	end

	return goodCo1.id < goodCo2.id
end

function Season1_6StoreView:getItemGo(index)
	local setting = self.viewContainer:getSetting()
	local resPath = setting.otherRes.itemPath
	local go = self.viewContainer:getResInst(resPath, self._goContent, string.format("item%s", index))

	return go
end

function Season1_6StoreView:refreshTime()
	local actInfoMo = ActivityModel.instance:getActMO(self.actId)
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
	local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
	local hourSecond = offsetSecond % TimeUtil.OneDaySecond
	local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)
	local minuteSecond = hourSecond % TimeUtil.OneHourSecond
	local minute = Mathf.Ceil(minuteSecond / TimeUtil.OneMinuteSecond)

	self._txttime.text = string.format(luaLang("versionactivitystoreview_remaintime"), day, hour, minute)
end

function Season1_6StoreView:onClose()
	TaskDispatcher.cancelTask(self.refreshTime, self)
	self:removeEventCb(VersionActivityController.instance, VersionActivityEvent.OnGet107GoodsInfo, self._onGet107GoodsInfo, self)
	self:removeEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self._onBuyGoodsSuccess, self)
end

function Season1_6StoreView:onDestroyView()
	self._simagebg:UnLoadImage()

	for _, storeItem in ipairs(self.storeItemList) do
		storeItem:destory()
	end

	self.storeItemList = nil
end

return Season1_6StoreView
