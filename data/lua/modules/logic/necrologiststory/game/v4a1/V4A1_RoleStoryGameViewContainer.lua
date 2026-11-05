-- chunkname: @modules/logic/necrologiststory/game/v4a1/V4A1_RoleStoryGameViewContainer.lua

module("modules.logic.necrologiststory.game.v4a1.V4A1_RoleStoryGameViewContainer", package.seeall)

local V4A1_RoleStoryGameViewContainer = class("V4A1_RoleStoryGameViewContainer", BaseViewContainer)

function V4A1_RoleStoryGameViewContainer:buildViews()
	local views = {}

	self.gameView = V4A1_RoleStoryGameView.New()

	table.insert(views, self.gameView)
	table.insert(views, NecrologistStoryCommonView.New("#go_topright"))
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function V4A1_RoleStoryGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			navView
		}
	end
end

return V4A1_RoleStoryGameViewContainer
