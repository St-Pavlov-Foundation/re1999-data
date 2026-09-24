-- chunkname: @modules/logic/versionactivity4_0/deleike/view/DeleikeGameViewContainer.lua

module("modules.logic.versionactivity4_0.deleike.view.DeleikeGameViewContainer", package.seeall)

local DeleikeGameViewContainer = class("DeleikeGameViewContainer", BaseViewContainer)

function DeleikeGameViewContainer:buildViews()
	local views = {}

	table.insert(views, DeleikeGameView.New())
	table.insert(views, DeleikeGameScene.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function DeleikeGameViewContainer:buildTabViews(tabContainerId)
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

return DeleikeGameViewContainer
