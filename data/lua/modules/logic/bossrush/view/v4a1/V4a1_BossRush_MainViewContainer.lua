-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_MainViewContainer.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_MainViewContainer", package.seeall)

local V4a1_BossRush_MainViewContainer = class("V4a1_BossRush_MainViewContainer", BaseViewContainer)

function V4a1_BossRush_MainViewContainer:buildViews()
	local views = {}

	table.insert(views, V4a1_BossRush_MainView.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function V4a1_BossRush_MainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.BossRushViewHelp)

		return {
			self.navigateView
		}
	end
end

function V4a1_BossRush_MainViewContainer:playCloseTransition()
	local animator = SLFramework.AnimatorPlayer.Get(self.viewGO)

	animator:Play("close", self.onPlayCloseTransitionFinish, self)
end

return V4a1_BossRush_MainViewContainer
