-- chunkname: @modules/logic/versionactivity4_1/library/view/V4a1_Library_MainViewContainer.lua

module("modules.logic.versionactivity4_1.library.view.V4a1_Library_MainViewContainer", package.seeall)

local V4a1_Library_MainViewContainer = class("V4a1_Library_MainViewContainer", BaseViewContainer)
local kTabContainerId_NavigateButtonsView = 1

function V4a1_Library_MainViewContainer:buildViews()
	self._mainView = V4a1_Library_MainView.New()

	local views = {
		self._mainView,
		TabViewGroup.New(kTabContainerId_NavigateButtonsView, "#go_lefttop")
	}

	return views
end

function V4a1_Library_MainViewContainer:getMainView()
	return self._mainView
end

function V4a1_Library_MainViewContainer:actId()
	return V4a1_LibraryController.instance:actId()
end

function V4a1_Library_MainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == kTabContainerId_NavigateButtonsView then
		self._navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigationView:setOverrideClose(self._overrideClose, self)

		return {
			self._navigationView
		}
	end
end

function V4a1_Library_MainViewContainer:_overrideClose()
	V4a1_LibraryController.instance:exitScene()
end

function V4a1_Library_MainViewContainer:getActMO(actId)
	return ActivityModel.instance:getActMO(actId)
end

function V4a1_Library_MainViewContainer:isEnteredActivity(actId)
	return ActivityEnterMgr.instance:isEnteredActivity(actId)
end

function V4a1_Library_MainViewContainer:getActivityStatus(actId, noError)
	return ActivityModel.instance:getActivityStatus(actId, noError)
end

function V4a1_Library_MainViewContainer:getActivityConfig(actId)
	return ActivityModel.instance:getActivityConfig(actId)
end

function V4a1_Library_MainViewContainer:getEntryBtnMaxCount()
	return V4a1_LibraryEnum.Entry.__End - 1
end

function V4a1_Library_MainViewContainer:getRemainTimeStr(actId)
	local actMO = self:getActMO(actId)

	if not actMO then
		return luaLang("turnback_end")
	end

	local startTime = actMO.startTime / 1000
	local endTime = actMO.endTime / 1000
	local curTime = ServerTime.now()

	if curTime < startTime then
		local remainTimeSec = startTime - curTime

		return self:_getCommingSoonTimeStr(remainTimeSec)
	elseif startTime <= curTime and curTime < endTime then
		local remainTimeSec = endTime - ServerTime.now()

		return self:_getRunningTimeStr(remainTimeSec)
	end

	return luaLang("turnback_end")
end

local kFallbackCommingSoon, kCommingSoonLess1Min

function V4a1_Library_MainViewContainer:_getCommingSoonTimeStr(dtSec)
	if not kFallbackCommingSoon then
		kFallbackCommingSoon = GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			1
		})
	end

	if not kCommingSoonLess1Min then
		kCommingSoonLess1Min = string.format(luaLang("v4a1_subentry_not_open"), GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			1
		}))
	end

	if dtSec <= 0 then
		return kFallbackCommingSoon
	end

	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(dtSec)

	if day > 0 then
		local str = GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			day,
			hour
		})

		return string.format(luaLang("v4a1_subentry_not_open"), str)
	elseif hour > 0 then
		local str = GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			hour,
			min
		})

		return string.format(luaLang("v4a1_subentry_not_open"), str)
	elseif min > 0 then
		local str = GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			min
		})

		return string.format(luaLang("v4a1_subentry_not_open"), str)
	elseif sec > 0 then
		return kCommingSoonLess1Min
	end

	return kFallbackCommingSoon
end

local kFallbackRunning, kRunningLess1Min

function V4a1_Library_MainViewContainer:_getRunningTimeStr(dtSec)
	if not kFallbackRunning then
		kFallbackRunning = luaLang("turnback_end")
	end

	if not kRunningLess1Min then
		kRunningLess1Min = GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			1
		})
	end

	if dtSec <= 0 then
		return kFallbackRunning
	end

	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(dtSec)
	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(dtSec)

	if day > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
			day,
			hour
		})
	elseif hour > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			hour,
			min
		})
	elseif min > 0 then
		return GameUtil.getSubPlaceholderLuaLang(luaLang("summonmain_deadline_time"), {
			0,
			min
		})
	elseif sec > 0 then
		return kRunningLess1Min
	end

	return kFallbackRunning
end

return V4a1_Library_MainViewContainer
