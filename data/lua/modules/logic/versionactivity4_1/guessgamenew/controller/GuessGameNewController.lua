-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/controller/GuessGameNewController.lua

module("modules.logic.versionactivity4_1.guessgamenew.controller.GuessGameNewController", package.seeall)

local GuessGameNewController = class("GuessGameNewController", BaseController)

function GuessGameNewController:onInit()
	self:reInit()
end

function GuessGameNewController:reInit()
	self._hasGet = nil
end

function GuessGameNewController:onInitFinish()
	return
end

function GuessGameNewController:addConstEvents()
	self:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function GuessGameNewController:_onDailyRefresh()
	self._hasGet = nil

	self:onRefreshActivity()
end

function GuessGameNewController:onRefreshActivity()
	local actId = VersionActivity4_1Enum.ActivityId.GuessGameNew
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	if not actInfoMo then
		return
	end

	local isExpired = actInfoMo:getRealEndTimeStamp() - ServerTime.now() < 1
	local couldGet = actInfoMo:isOnline() and actInfoMo:isOpen() and not isExpired

	if couldGet and self._hasGet ~= couldGet then
		Activity234Rpc.instance:sendGet234InfoRequest(actId)
	end

	self._hasGet = couldGet
end

function GuessGameNewController:openGuessGameNewMainView()
	ViewMgr.instance:openView(ViewName.GuessGameNewMainView)
end

function GuessGameNewController:openGuessGameNewPlayView()
	ViewMgr.instance:openView(ViewName.GuessGameNewPlayView)
end

function GuessGameNewController:openGuessGameNewPlayPlayerGuessView()
	ViewMgr.instance:openView(ViewName.GuessGameNewPlayPlayerGuessView)
end

function GuessGameNewController:openGuessGameNewPlayNpcGuessView()
	ViewMgr.instance:openView(ViewName.GuessGameNewPlayNpcGuessView)
end

function GuessGameNewController:openGuessGameNewPlayRoundTipsView()
	ViewMgr.instance:openView(ViewName.GuessGameNewPlayRoundTipsView)
end

function GuessGameNewController:openGuessGameNewPlayRoleTipsView()
	ViewMgr.instance:openView(ViewName.GuessGameNewPlayRoleTipsView)
end

function GuessGameNewController:openGuessGameNewPlayResultView(param)
	ViewMgr.instance:openView(ViewName.GuessGameNewPlayResultView, param)
end

function GuessGameNewController:exitGame()
	self:closeAllGuessGameNewViews()
end

function GuessGameNewController:restartGame()
	self:closeAllGuessGameNewViews()
	TaskDispatcher.runDelay(self.openGuessGameNewPlayView, self, 0.1)
end

function GuessGameNewController:closeAllGuessGameNewViews()
	ViewMgr.instance:closeView(ViewName.GuessGameNewPlayView, true)
	ViewMgr.instance:closeView(ViewName.GuessGameNewPlayPlayerGuessView, true)
	ViewMgr.instance:closeView(ViewName.GuessGameNewPlayNpcGuessView, true)
	ViewMgr.instance:closeView(ViewName.GuessGameNewPlayRoundTipsView, true)
	ViewMgr.instance:closeView(ViewName.GuessGameNewPlayRoleTipsView, true)
	ViewMgr.instance:closeView(ViewName.GuessGameNewPlayResultView, true)
end

GuessGameNewController.instance = GuessGameNewController.New()

return GuessGameNewController
