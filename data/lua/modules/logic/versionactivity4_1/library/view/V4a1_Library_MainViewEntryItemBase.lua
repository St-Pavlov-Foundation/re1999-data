-- chunkname: @modules/logic/versionactivity4_1/library/view/V4a1_Library_MainViewEntryItemBase.lua

module("modules.logic.versionactivity4_1.library.view.V4a1_Library_MainViewEntryItemBase", package.seeall)

local V4a1_Library_MainViewEntryItemBase = class("V4a1_Library_MainViewEntryItemBase", RougeSimpleItemBase)

function V4a1_Library_MainViewEntryItemBase:ctor(...)
	self:__onInit()
	V4a1_Library_MainViewEntryItemBase.super.ctor(self, ...)
end

function V4a1_Library_MainViewEntryItemBase:onDestroyView()
	V4a1_Library_MainViewEntryItemBase.super.onDestroyView(self)
	self:__onDispose()
end

function V4a1_Library_MainViewEntryItemBase:mo()
	return self._mo
end

function V4a1_Library_MainViewEntryItemBase:actId()
	return self:index()
end

function V4a1_Library_MainViewEntryItemBase:getActMO()
	local c = self:baseViewContainer()

	return c:getActMO(self:actId())
end

function V4a1_Library_MainViewEntryItemBase:isEnteredActivity()
	return ActivityEnterMgr.instance:isEnteredActivity(self:actId())
end

function V4a1_Library_MainViewEntryItemBase:getActivityStatus()
	return ActivityHelper.getActivityStatus(self:actId(), true)
end

function V4a1_Library_MainViewEntryItemBase:getActivityCo()
	return ActivityConfig.instance:getActivityCo(self:actId())
end

function V4a1_Library_MainViewEntryItemBase:getRemainTimeStr()
	local c = self:baseViewContainer()

	return c:getRemainTimeStr(self:actId())
end

function V4a1_Library_MainViewEntryItemBase:isActOpen()
	return ActivityType101Model.instance:isOpen(self:actId())
end

return V4a1_Library_MainViewEntryItemBase
