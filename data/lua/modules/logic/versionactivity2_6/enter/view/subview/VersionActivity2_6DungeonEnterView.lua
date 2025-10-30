﻿-- chunkname: @modules/logic/versionactivity2_6/enter/view/subview/VersionActivity2_6DungeonEnterView.lua

module("modules.logic.versionactivity2_6.enter.view.subview.VersionActivity2_6DungeonEnterView", package.seeall)

local VersionActivity2_6DungeonEnterView = class("VersionActivity2_6DungeonEnterView", BaseView)

function VersionActivity2_6DungeonEnterView:onInitView()
	self._txtdesc = gohelper.findChildText(self.viewGO, "logo/#txt_dec")
	self._gotime = gohelper.findChild(self.viewGO, "logo/actbg")
	self._txttime = gohelper.findChildText(self.viewGO, "logo/actbg/#txt_time")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_store")
	self._txtStoreNum = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/#txt_num")
	self._txtStoreTime = gohelper.findChildText(self.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	self._btnenter = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_enter")
	self._goreddot = gohelper.findChild(self.viewGO, "entrance/#btn_enter/#go_reddot")
	self._btnFinished = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_Finished")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_6DungeonEnterView:addEvents()
	self:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStoreCurrency, self)
	self:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	self._btnstore:AddClickListener(self._btnstoreOnClick, self)
	self._btnenter:AddClickListener(self._btnenterOnClick, self)
	self._btnFinished:AddClickListener(self._btnFinishedOnClick, self)
end

function VersionActivity2_6DungeonEnterView:removeEvents()
	self:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStoreCurrency, self)
	self:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	self._btnstore:RemoveClickListener()
	self._btnenter:RemoveClickListener()
	self._btnFinished:RemoveClickListener()
end

function VersionActivity2_6DungeonEnterView:onRefreshActivity(actId)
	if actId ~= self.actId then
		return
	end

	self:refreshActivityState()
end

function VersionActivity2_6DungeonEnterView:_btnstoreOnClick()
	VersionActivity2_6DungeonController.instance:openStoreView()
end

function VersionActivity2_6DungeonEnterView:_btnenterOnClick()
	VersionActivity2_6DungeonController.instance:openVersionActivityDungeonMapView()
end

function VersionActivity2_6DungeonEnterView:_btnFinishedOnClick()
	return
end

function VersionActivity2_6DungeonEnterView:_editableInitView()
	self._txtstorename = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/txt_shop")
	self.actId = VersionActivity2_6Enum.ActivityId.Dungeon
	self.animComp = VersionActivity2_6SubAnimatorComp.get(self.viewGO, self)
	self.goEnter = self._btnenter.gameObject
	self.goFinish = self._btnFinished.gameObject
	self.goStore = self._btnstore.gameObject
	self.actId = VersionActivity2_6Enum.ActivityId.Dungeon
	self.actCo = ActivityConfig.instance:getActivityCo(self.actId)

	self:_setDesc()
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V2a6DungeonEnter)
end

function VersionActivity2_6DungeonEnterView:_setDesc()
	if not self.actCo or not self._txtdesc then
		return
	end

	self._txtdesc.text = self.actCo.actDesc
end

function VersionActivity2_6DungeonEnterView:onUpdateParam()
	self:refreshUI()
end

function VersionActivity2_6DungeonEnterView:onOpen()
	self:refreshUI()
	self.animComp:playOpenAnim()
	TaskDispatcher.runRepeat(self.everyMinuteCall, self, TimeUtil.OneMinuteSecond)
end

function VersionActivity2_6DungeonEnterView:everyMinuteCall()
	self:refreshUI()
end

function VersionActivity2_6DungeonEnterView:refreshUI()
	self:refreshRemainTime()
	self:refreshActivityState()
	self:refreshStoreCurrency()
end

function VersionActivity2_6DungeonEnterView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		local dateStr = TimeUtil.SecondToActivityTimeFormat(offsetSecond)

		self._txttime.text = dateStr

		gohelper.setActive(self._txttime, true)
	else
		gohelper.setActive(self._txttime, false)
	end

	local storeActInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_6Enum.ActivityId.DungeonStore]

	self._txtstorename.text = storeActInfoMo.config.name
	self._txtStoreTime.text = storeActInfoMo:getRemainTimeStr2ByEndTime(true)
end

function VersionActivity2_6DungeonEnterView:refreshActivityState()
	local status = ActivityHelper.getActivityStatusAndToast(self.actId)
	local isNormal = status == ActivityEnum.ActivityStatus.Normal

	if not isNormal then
		local enterStatus = ActivityHelper.getActivityStatusAndToast(VersionActivity2_6Enum.ActivityId.EnterView)

		isNormal = enterStatus == ActivityEnum.ActivityStatus.Normal
	end

	gohelper.setActive(self.goEnter, isNormal)
	gohelper.setActive(self.goFinish, not isNormal)

	local isExpired = status == ActivityEnum.ActivityStatus.Expired

	gohelper.setActive(self._gotime, not isExpired)

	local storeStatus = ActivityHelper.getActivityStatusAndToast(VersionActivity2_6Enum.ActivityId.DungeonStore)
	local isStoreNormal = storeStatus == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(self.goStore, isStoreNormal)
end

function VersionActivity2_6DungeonEnterView:refreshStoreCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a6Dungeon)
	local quantity = currencyMO and currencyMO.quantity or 0

	self._txtStoreNum.text = GameUtil.numberDisplay(quantity)
end

function VersionActivity2_6DungeonEnterView:onClose()
	TaskDispatcher.cancelTask(self.everyMinuteCall, self)
end

function VersionActivity2_6DungeonEnterView:onDestroyView()
	self.animComp:destroy()
end

return VersionActivity2_6DungeonEnterView
