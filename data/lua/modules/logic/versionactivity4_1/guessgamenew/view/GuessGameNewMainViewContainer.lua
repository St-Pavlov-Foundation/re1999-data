-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewMainViewContainer.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewMainViewContainer", package.seeall)

local GuessGameNewMainViewContainer = class("GuessGameNewMainViewContainer", BaseViewContainer)

function GuessGameNewMainViewContainer:buildViews()
	local views = {}

	table.insert(views, GuessGameNewMainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function GuessGameNewMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonsView
		}
	end
end

return GuessGameNewMainViewContainer
