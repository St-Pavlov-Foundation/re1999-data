-- chunkname: @modules/logic/versionactivity4_1/library/view/V4a1_Investigation_GuessViewContainer.lua

module("modules.logic.versionactivity4_1.library.view.V4a1_Investigation_GuessViewContainer", package.seeall)

local V4a1_Investigation_GuessViewContainer = class("V4a1_Investigation_GuessViewContainer", BaseViewContainer)
local kTabContainerId_NavigateButtonsView = 1

function V4a1_Investigation_GuessViewContainer:buildViews()
	local views = {}

	table.insert(views, V4a1_Investigation_GuessView.New())
	table.insert(views, TabViewGroup.New(kTabContainerId_NavigateButtonsView, "#go_topleft"))

	return views
end

function V4a1_Investigation_GuessViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == kTabContainerId_NavigateButtonsView then
		self._navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateView
		}
	end
end

function V4a1_Investigation_GuessViewContainer:actId()
	return assert(self.viewParam.actId)
end

return V4a1_Investigation_GuessViewContainer
