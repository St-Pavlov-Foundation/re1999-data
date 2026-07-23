-- chunkname: @modules/logic/sp02/paomian/enter/view/Sp02_PaoMianBtnItem.lua

module("modules.logic.sp02.paomian.enter.view.Sp02_PaoMianBtnItem", package.seeall)

local Sp02_PaoMianBtnItem = class("Sp02_PaoMianBtnItem", ActCenterItemBase)

function Sp02_PaoMianBtnItem:onOpen()
	self:_addNotEventRedDot(self._checkRed, self)
end

function Sp02_PaoMianBtnItem:onInit()
	self._actId = ActivityEnum.Activity.SP02_PaoMianActivityMain
	self._activityCo = ActivityConfig.instance:getActivityCo(self._actId)
	self._redDotId = self._activityCo and self._activityCo.redDotId

	self:refresh()
end

function Sp02_PaoMianBtnItem:onRefresh()
	local isShow = ActivityModel.showActivityEffect()
	local spriteName = self:getActBtnPrefixIconName(isShow, "icon_11")

	self:setFestival(isShow)
	self:_setMainSprite(spriteName)
end

function Sp02_PaoMianBtnItem:onAddEvent()
	RedDotController.instance:registerCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.RefreshClientCharacterDot, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self.refreshActivityState, self)
end

function Sp02_PaoMianBtnItem:onRemoveEvent()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.RefreshClientCharacterDot, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshActivityState, self.refreshActivityState, self)
end

function Sp02_PaoMianBtnItem:onClick()
	ViewMgr.instance:openView(ViewName.Sp02_PaoMian_MainView, {
		actId = self._actId
	})
end

function Sp02_PaoMianBtnItem:_checkRed()
	if not ActivityHelper.isOpen(self._actId) then
		return false
	end

	self:_checkRedotShowType(self._redDotId)

	return RedDotModel.instance:isDotShow(self._redDotId, 0) or Sp02_PaoMianController.instance:isShowWebReddot()
end

function Sp02_PaoMianBtnItem:refreshActivityState(actId)
	if actId == ActivityEnum.Activity.SP02_PaoMianActivityWeb then
		self:refreshDot()
	end
end

function Sp02_PaoMianBtnItem:refreshDot()
	self:_refreshRedDot()
end

function Sp02_PaoMianBtnItem:_gm_ActIds()
	local actIds = {
		self._actId
	}

	return actIds
end

function Sp02_PaoMianBtnItem:onDestroy()
	return
end

return Sp02_PaoMianBtnItem
