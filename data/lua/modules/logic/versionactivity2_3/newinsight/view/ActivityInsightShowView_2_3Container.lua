﻿-- chunkname: @modules/logic/versionactivity2_3/newinsight/view/ActivityInsightShowView_2_3Container.lua

module("modules.logic.versionactivity2_3.newinsight.view.ActivityInsightShowView_2_3Container", package.seeall)

local ActivityInsightShowView_2_3Container = class("ActivityInsightShowView_2_3Container", BaseViewContainer)

function ActivityInsightShowView_2_3Container:buildViews()
	local views = {}

	table.insert(views, ActivityInsightShowView_2_3.New())

	return views
end

return ActivityInsightShowView_2_3Container
