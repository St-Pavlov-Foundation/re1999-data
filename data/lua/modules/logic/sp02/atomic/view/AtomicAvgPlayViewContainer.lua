-- chunkname: @modules/logic/sp02/atomic/view/AtomicAvgPlayViewContainer.lua

module("modules.logic.sp02.atomic.view.AtomicAvgPlayViewContainer", package.seeall)

local AtomicAvgPlayViewContainer = class("AtomicAvgPlayViewContainer", BaseViewContainer)

function AtomicAvgPlayViewContainer:buildViews()
	local views = {}

	table.insert(views, AtomicAvgPlayView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function AtomicAvgPlayViewContainer:buildTabViews(tabContainerId)
	local view = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		view
	}
end

return AtomicAvgPlayViewContainer
