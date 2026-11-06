-- chunkname: @modules/logic/versionactivity4_1/library/view/V4a1_Library_MainViewEntryItem_GuessGame.lua

module("modules.logic.versionactivity4_1.library.view.V4a1_Library_MainViewEntryItem_GuessGame", package.seeall)

local V4a1_Library_MainViewEntryItem_GuessGame = class("V4a1_Library_MainViewEntryItem_GuessGame", V4a1_Library_MainViewEntryItemImpl)

function V4a1_Library_MainViewEntryItem_GuessGame:onInitView()
	self._btnimage = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_image")
	self._golock = gohelper.findChild(self.viewGO, "root/#go_lock")
	self._txttime = gohelper.findChildText(self.viewGO, "root/time/#txt_time")
	self._goreddot = gohelper.findChild(self.viewGO, "root/#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_Library_MainViewEntryItem_GuessGame:addEvents()
	self._btnimage:AddClickListener(self._btnimageOnClick, self)
end

function V4a1_Library_MainViewEntryItem_GuessGame:removeEvents()
	self._btnimage:RemoveClickListener()
end

function V4a1_Library_MainViewEntryItem_GuessGame:ctor(...)
	V4a1_Library_MainViewEntryItem_GuessGame.super.ctor(self, ...)
end

function V4a1_Library_MainViewEntryItem_GuessGame:onDestroyView()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self._refreshRedDot, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self._refreshRedDot, self)
	GuessGameController.instance:unregisterCallback(GuessGameEvent.OnGetInfo, self._refreshRedDot, self)
	GuessGameController.instance:unregisterCallback(GuessGameEvent.OnFinishGame, self._refreshRedDot, self)
	GuessGameController.instance:unregisterCallback(GuessGameEvent.OnReceiveAcceptReward, self._refreshRedDot, self)
	V4a1_Library_MainViewEntryItem_GuessGame.super.onDestroyView(self)
end

function V4a1_Library_MainViewEntryItem_GuessGame:_editableInitView()
	V4a1_Library_MainViewEntryItem_GuessGame.super._editableInitView(self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self._refreshRedDot, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._refreshRedDot, self)
	GuessGameController.instance:registerCallback(GuessGameEvent.OnGetInfo, self._refreshRedDot, self)
	GuessGameController.instance:registerCallback(GuessGameEvent.OnFinishGame, self._refreshRedDot, self)
	GuessGameController.instance:registerCallback(GuessGameEvent.OnReceiveAcceptReward, self._refreshRedDot, self)
end

function V4a1_Library_MainViewEntryItem_GuessGame:_editableAddEvents()
	V4a1_Library_MainViewEntryItem_GuessGame.super._editableAddEvents(self)
end

function V4a1_Library_MainViewEntryItem_GuessGame:_editableRemoveEvents()
	V4a1_Library_MainViewEntryItem_GuessGame.super._editableRemoveEvents(self)
end

function V4a1_Library_MainViewEntryItem_GuessGame:setData(mo)
	V4a1_Library_MainViewEntryItem_GuessGame.super.setData(self, mo)
end

function V4a1_Library_MainViewEntryItem_GuessGame:exec_addRedDot0()
	self._redDotIcon = RedDotController.instance:addNotEventRedDot(self._goreddot, self._isShowRedDot, self)
end

function V4a1_Library_MainViewEntryItem_GuessGame:exec_addRedDotActId()
	self:exec_addRedDot0()
end

function V4a1_Library_MainViewEntryItem_GuessGame:_refreshRedDot()
	if self._redDotIcon then
		self._redDotIcon:refreshRedDot()
	end
end

function V4a1_Library_MainViewEntryItem_GuessGame:_isShowRedDot()
	return V4a1_Library_MainViewEntryItem_GuessGame.isRedDotShow(self:actId())
end

function V4a1_Library_MainViewEntryItem_GuessGame.isRedDotShow(actId)
	actId = actId or VersionActivity4_1Enum.ActivityId.GuessGameNew

	if ActivityHelper.getActivityStatus(actId, true) ~= ActivityEnum.ActivityStatus.Normal then
		return false
	end

	if V4a1_Library_MainViewEntryItem_GuessGame.isTripleScoreCanGet(actId) then
		return true
	end

	if V4a1_Library_MainViewEntryItem_GuessGame.hasMilestoneRewardCouldGet(actId) then
		return true
	end

	local redDotId = ActivityConfig.instance:getActivityRedDotId(actId)

	if redDotId and redDotId > 0 and RedDotModel.instance:isDotShow(redDotId, 0) then
		return true
	end

	return false
end

function V4a1_Library_MainViewEntryItem_GuessGame.isTripleScoreCanGet(actId)
	local ctrlCo = GuessGameNewConfig.instance:getCtrlCo(actId)
	local magnificationRate = ctrlCo and ctrlCo.magnificationRate or 1

	if magnificationRate <= 1 then
		return false
	end

	if V4a1_Library_MainViewEntryItem_GuessGame.isAllMilestoneRewardGet(actId) then
		return false
	end

	return GuessGameNewModel.instance:isFirstShow(actId)
end

function V4a1_Library_MainViewEntryItem_GuessGame.isAllMilestoneRewardGet(actId)
	local bonusCos = GuessGameNewConfig.instance:getBonusCos(actId)

	if not bonusCos or next(bonusCos) == nil then
		return true
	end

	for _, bonusCo in pairs(bonusCos) do
		if not GuessGameNewModel.instance:isRewardGet(bonusCo.rewardId, actId) then
			return false
		end
	end

	return true
end

function V4a1_Library_MainViewEntryItem_GuessGame.hasMilestoneRewardCouldGet(actId)
	local bonusCos = GuessGameNewConfig.instance:getBonusCos(actId)

	if not bonusCos then
		return false
	end

	for _, bonusCo in pairs(bonusCos) do
		if GuessGameNewModel.instance:isRewardCanGet(bonusCo.rewardId, actId) then
			return true
		end
	end

	return false
end

function V4a1_Library_MainViewEntryItem_GuessGame:isShowRedDot()
	return self._redDotIcon and self._redDotIcon.isShowRedDot or false
end

return V4a1_Library_MainViewEntryItem_GuessGame
