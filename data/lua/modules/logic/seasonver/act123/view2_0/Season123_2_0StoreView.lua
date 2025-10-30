﻿-- chunkname: @modules/logic/seasonver/act123/view2_0/Season123_2_0StoreView.lua

module("modules.logic.seasonver.act123.view2_0.Season123_2_0StoreView", package.seeall)

local Season123_2_0StoreView = class("Season123_2_0StoreView", BaseView)

function Season123_2_0StoreView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "title/#txt_time")
	self._goContent = gohelper.findChild(self.viewGO, "mask/#scroll_store/Viewport/#go_Content")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_0StoreView:addEvents()
	return
end

function Season123_2_0StoreView:removeEvents()
	return
end

function Season123_2_0StoreView:_editableInitView()
	self.storeItemList = self:getUserDataTb_()
end

function Season123_2_0StoreView:onUpdateParam()
	return
end

function Season123_2_0StoreView:onOpen()
	self:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnGet107GoodsInfo, self._onGet107GoodsInfo, self)
	self:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self._onBuyGoodsSuccess, self)

	self.actId = self.viewParam.actId

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	TaskDispatcher.runRepeat(self.refreshTime, self, TimeUtil.OneMinuteSecond)
	self:refreshTime()
	self:refreshStoreContent()
end

function Season123_2_0StoreView:_onGet107GoodsInfo(actId)
	if actId ~= self.actId then
		return
	end

	self:refreshStoreContent()
end

function Season123_2_0StoreView:_onBuyGoodsSuccess(actId)
	if actId ~= self.actId then
		return
	end

	self:refreshStoreContent()
end

function Season123_2_0StoreView:refreshStoreContent()
	local storeGroupDict = ActivityStoreConfig.instance:getActivityStoreGroupDict(self.actId)
	local list = {}

	if storeGroupDict then
		for _, storelist in pairs(storeGroupDict) do
			for _, v in pairs(storelist) do
				table.insert(list, v)
			end
		end
	end

	Season123StoreModel.instance:setStoreItemList(list)
end

function Season123_2_0StoreView:refreshTime()
	local actInfoMo = ActivityModel.instance:getActMO(self.actId)
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
	local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
	local hourSecond = offsetSecond % TimeUtil.OneDaySecond
	local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)
	local minuteSecond = hourSecond % TimeUtil.OneHourSecond
	local minute = Mathf.Ceil(minuteSecond / TimeUtil.OneMinuteSecond)

	self._txttime.text = string.format(luaLang("versionactivitystoreview_remaintime"), day, hour, minute)
end

function Season123_2_0StoreView:onClose()
	TaskDispatcher.cancelTask(self.refreshTime, self)
	self:removeEventCb(VersionActivityController.instance, VersionActivityEvent.OnGet107GoodsInfo, self._onGet107GoodsInfo, self)
	self:removeEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self._onBuyGoodsSuccess, self)
end

function Season123_2_0StoreView:onDestroyView()
	return
end

return Season123_2_0StoreView
