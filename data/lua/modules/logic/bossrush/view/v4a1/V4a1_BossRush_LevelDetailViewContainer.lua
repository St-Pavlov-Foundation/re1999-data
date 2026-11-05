-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_LevelDetailViewContainer.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_LevelDetailViewContainer", package.seeall)

local V4a1_BossRush_LevelDetailViewContainer = class("V4a1_BossRush_LevelDetailViewContainer", BaseViewContainer)

function V4a1_BossRush_LevelDetailViewContainer:buildViews()
	local views = {}

	table.insert(views, V4a1_BossRush_LevelDetailView.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function V4a1_BossRush_LevelDetailViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

return V4a1_BossRush_LevelDetailViewContainer
