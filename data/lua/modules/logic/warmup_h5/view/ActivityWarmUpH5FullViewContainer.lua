﻿-- chunkname: @modules/logic/warmup_h5/view/ActivityWarmUpH5FullViewContainer.lua

module("modules.logic.warmup_h5.view.ActivityWarmUpH5FullViewContainer", package.seeall)

local ActivityWarmUpH5FullViewContainer = class("ActivityWarmUpH5FullViewContainer", BaseViewContainer)

function ActivityWarmUpH5FullViewContainer:buildViews()
	local views = {}

	table.insert(views, ActivityWarmUpH5FullView.New())

	return views
end

function ActivityWarmUpH5FullViewContainer:actId()
	return self.viewParam and self.viewParam.actId or ActivityType100Config.instance:getWarmUpH5ActivityId()
end

function ActivityWarmUpH5FullViewContainer:getH5BaseUrl()
	return ActivityType100Config.instance:getWarmUpH5Link(self:actId())
end

return ActivityWarmUpH5FullViewContainer
