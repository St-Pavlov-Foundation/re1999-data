-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_MainViewContainer.lua

module("modules.logic.rouge2.outside.view.Rouge2_MainViewContainer", package.seeall)

local Rouge2_MainViewContainer = class("Rouge2_MainViewContainer", BaseViewContainer)

function Rouge2_MainViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_MainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function Rouge2_MainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		}, nil, self.closeCallback, nil, nil, self)

		return {
			self.navigateView
		}
	end
end

function Rouge2_MainViewContainer:closeCallback()
	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.BackEnterScene, Rouge2_OutsideEnum.SceneIndex.EnterScene)
end

return Rouge2_MainViewContainer
