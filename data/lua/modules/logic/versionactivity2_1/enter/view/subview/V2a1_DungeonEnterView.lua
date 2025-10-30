﻿-- chunkname: @modules/logic/versionactivity2_1/enter/view/subview/V2a1_DungeonEnterView.lua

module("modules.logic.versionactivity2_1.enter.view.subview.V2a1_DungeonEnterView", package.seeall)

local V2a1_DungeonEnterView = class("V2a1_DungeonEnterView", BaseView)

function V2a1_DungeonEnterView:onInitView()
	self._txtdesc = gohelper.findChildText(self.viewGO, "logo/#txt_dec")
	self._gotime = gohelper.findChild(self.viewGO, "logo/actbg")
	self._txttime = gohelper.findChildText(self.viewGO, "logo/actbg/#txt_time")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "entrance/#btn_task")
	self._gotaskreddot = gohelper.findChild(self.viewGO, "entrance/#btn_task/#go_reddot")
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

function V2a1_DungeonEnterView:addEvents()
	self:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStoreCurrency, self)
	self:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btnstore:AddClickListener(self._btnstoreOnClick, self)
	self._btnenter:AddClickListener(self._btnenterOnClick, self)
	self._btnFinished:AddClickListener(self._btnFinishedOnClick, self)
end

function V2a1_DungeonEnterView:removeEvents()
	self:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshStoreCurrency, self)
	self:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	self._btntask:RemoveClickListener()
	self._btnstore:RemoveClickListener()
	self._btnenter:RemoveClickListener()
	self._btnFinished:RemoveClickListener()
end

function V2a1_DungeonEnterView:onRefreshActivity(actId)
	if actId ~= self.actId then
		return
	end

	self:refreshActivityState()
end

function V2a1_DungeonEnterView:_btntaskOnClick()
	VersionActivity2_1DungeonController.instance:openTaskView()
end

function V2a1_DungeonEnterView:_btnstoreOnClick()
	VersionActivity2_1DungeonController.instance:openStoreView()
end

function V2a1_DungeonEnterView:_btnenterOnClick()
	VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView()
end

function V2a1_DungeonEnterView:_btnFinishedOnClick()
	GameFacade.showToast(ToastEnum.ActivityEnd)
end

function V2a1_DungeonEnterView:_editableInitView()
	self._txtstorename = gohelper.findChildText(self.viewGO, "entrance/#btn_store/normal/txt_shop")
	self.actId = VersionActivity2_1Enum.ActivityId.Dungeon
	self.animComp = VersionActivity2_1SubAnimatorComp.get(self.viewGO, self)
	self.goEnter = self._btnenter.gameObject
	self.goFinish = self._btnFinished.gameObject
	self.goStore = self._btnstore.gameObject
	self.actId = VersionActivity2_1Enum.ActivityId.Dungeon
	self.actCo = ActivityConfig.instance:getActivityCo(self.actId)

	self:_setDesc()
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V2a1DungeonEnter)
	RedDotController.instance:addRedDot(self._gotaskreddot, RedDotEnum.DotNode.V2a1DungeonTask)
end

function V2a1_DungeonEnterView:_setDesc()
	if not self.actCo or not self._txtdesc then
		return
	end

	self._txtdesc.text = self.actCo.actDesc
end

function V2a1_DungeonEnterView:onUpdateParam()
	self:refreshUI()
end

function V2a1_DungeonEnterView:onOpen()
	self:refreshUI()

	if self.viewParam.isDirectOpen then
		self.viewContainer:markPlayedSubViewAnim()
	end

	if self.viewContainer:getIsFirstPlaySubViewAnim() then
		Activity165Model.instance:onInitInfo()
	end

	self.animComp:playOpenAnim()
	TaskDispatcher.runRepeat(self.everyMinuteCall, self, TimeUtil.OneMinuteSecond)
end

function V2a1_DungeonEnterView:everyMinuteCall()
	self:refreshUI()
end

function V2a1_DungeonEnterView:refreshUI()
	self:refreshRemainTime()
	self:refreshActivityState()
	self:refreshStoreCurrency()
end

function V2a1_DungeonEnterView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		local dateStr = actInfoMo:getRemainTimeStr3(false, false)

		self._txttime.text = dateStr

		gohelper.setActive(self._txttime, true)
	else
		gohelper.setActive(self._txttime, false)
	end

	local storeActInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_1Enum.ActivityId.DungeonStore]

	self._txtstorename.text = storeActInfoMo.config.name
	self._txtStoreTime.text = storeActInfoMo:getRemainTimeStr2ByEndTime(true)
end

function V2a1_DungeonEnterView:refreshActivityState()
	local status = ActivityHelper.getActivityStatusAndToast(self.actId)
	local isNormal = status == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(self.goEnter, isNormal)
	gohelper.setActive(self.goFinish, not isNormal)

	local isExpired = status == ActivityEnum.ActivityStatus.Expired

	gohelper.setActive(self._gotime, not isExpired)

	local storeStatus = ActivityHelper.getActivityStatusAndToast(VersionActivity2_1Enum.ActivityId.DungeonStore)
	local isStoreNormal = storeStatus == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(self.goStore, isStoreNormal)
end

function V2a1_DungeonEnterView:refreshStoreCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a1Dungeon)
	local quantity = currencyMO and currencyMO.quantity or 0

	self._txtStoreNum.text = GameUtil.numberDisplay(quantity)
end

function V2a1_DungeonEnterView:onClose()
	TaskDispatcher.cancelTask(self.everyMinuteCall, self)
end

function V2a1_DungeonEnterView:onDestroyView()
	self.animComp:destroy()
end

return V2a1_DungeonEnterView
