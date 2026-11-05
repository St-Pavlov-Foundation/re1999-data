-- chunkname: @modules/logic/versionactivity4_1/act248/view/enter/Act248EnterViewContainer.lua

module("modules.logic.versionactivity4_1.act248.view.enter.Act248EnterViewContainer", package.seeall)

local Act248EnterViewContainer = class("Act248EnterViewContainer", BaseViewContainer)

function Act248EnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Act248EnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act248EnterViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return Act248EnterViewContainer
