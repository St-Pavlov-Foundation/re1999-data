﻿-- chunkname: @modules/logic/versionactivity1_9/lucy/view/ActLucyTaskViewContainer.lua

module("modules.logic.versionactivity1_9.lucy.view.ActLucyTaskViewContainer", package.seeall)

local ActLucyTaskViewContainer = class("ActLucyTaskViewContainer", BaseViewContainer)

function ActLucyTaskViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_TaskList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = ActLucyTaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1160
	scrollParam.cellHeight = 165
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	local animationDelayTimes = {}

	for i = 1, 6 do
		local delayTime = (i - 1) * 0.06

		animationDelayTimes[i] = delayTime
	end

	local scrollView = LuaListScrollViewWithAnimator.New(RoleActivityTaskListModel.instance, scrollParam, animationDelayTimes)

	scrollView.dontPlayCloseAnimation = true

	table.insert(views, scrollView)
	table.insert(views, ActLucyTaskView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function ActLucyTaskViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return ActLucyTaskViewContainer
