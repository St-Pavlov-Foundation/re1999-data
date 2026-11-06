-- chunkname: @modules/logic/versionactivity4_1/library/view/V4a1_LibraryMainBtnItem.lua

module("modules.logic.versionactivity4_1.library.view.V4a1_LibraryMainBtnItem", package.seeall)

local V4a1_LibraryMainBtnItem = class("V4a1_LibraryMainBtnItem", ActCenterItemBase)

function V4a1_LibraryMainBtnItem:init(go)
	V4a1_LibraryMainBtnItem.super.init(self, gohelper.cloneInPlace(go))
end

function V4a1_LibraryMainBtnItem:onInit(go)
	self:_addNotEventRedDot(self._checkRed, self)
end

function V4a1_LibraryMainBtnItem:onAddEvent()
	RedDotController.instance:registerCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
	MainUISwitchController.instance:registerCallback(MainUISwitchEvent.UseMainUI, self.refreshDot, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.refreshDot, self)
	GuessGameController.instance:registerCallback(GuessGameEvent.OnGetInfo, self.refreshDot, self)
	GuessGameController.instance:registerCallback(GuessGameEvent.OnFinishGame, self.refreshDot, self)
	GuessGameController.instance:registerCallback(GuessGameEvent.OnReceiveAcceptReward, self.refreshDot, self)
end

function V4a1_LibraryMainBtnItem:onRemoveEvent()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self.refreshDot, self)
	MainUISwitchController.instance:unregisterCallback(MainUISwitchEvent.UseMainUI, self.refreshDot, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.refreshDot, self)
	GuessGameController.instance:unregisterCallback(GuessGameEvent.OnGetInfo, self.refreshDot, self)
	GuessGameController.instance:unregisterCallback(GuessGameEvent.OnFinishGame, self.refreshDot, self)
	GuessGameController.instance:unregisterCallback(GuessGameEvent.OnReceiveAcceptReward, self.refreshDot, self)
end

function V4a1_LibraryMainBtnItem:onDestroyView()
	V4a1_LibraryMainBtnItem.super.onDestroyView(self)
end

function V4a1_LibraryMainBtnItem:onClick()
	V4a1_LibraryController.instance:enterScene()
end

function V4a1_LibraryMainBtnItem:_checkRed()
	local reddotId = RedDotEnum.DotNode.V4a1LibarayMainViewEntry

	self:_checkRedotShowType(reddotId)

	if RedDotModel.instance:isDotShow(reddotId, 0) then
		return true
	end

	if V4a1_Library_MainViewEntryItem_GuessGame.isRedDotShow(VersionActivity4_1Enum.ActivityId.GuessGameNew) then
		return true
	end

	return false
end

function V4a1_LibraryMainBtnItem:refreshDot()
	self:_refreshRedDot()
end

function V4a1_LibraryMainBtnItem:isShowRedDot()
	return self._redDot and self._redDot.isShowRedDot or false
end

function V4a1_LibraryMainBtnItem:_actId()
	local data = self:getCustomData()

	return data.actId
end

function V4a1_LibraryMainBtnItem:_gm_ActIds()
	return {
		self:_actId()
	}
end

function V4a1_LibraryMainBtnItem:_isOpen()
	return ActivityType101Model.instance:isOpen(self:_actId())
end

function V4a1_LibraryMainBtnItem:onRefresh()
	local isShow = ActivityModel.showActivityEffect()
	local spriteName = self:getActBtnPrefixIconName(isShow, "icon_12")

	self:_setMainSprite(spriteName, true)
	self:setFestival(isShow)
	self:_refreshRedDot()
end

return V4a1_LibraryMainBtnItem
