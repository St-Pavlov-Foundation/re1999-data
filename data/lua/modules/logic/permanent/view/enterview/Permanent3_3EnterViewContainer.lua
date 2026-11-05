-- chunkname: @modules/logic/permanent/view/enterview/Permanent3_3EnterViewContainer.lua

module("modules.logic.permanent.view.enterview.Permanent3_3EnterViewContainer", package.seeall)

local Permanent3_3EnterViewContainer = class("Permanent3_3EnterViewContainer", BaseViewContainer)

function Permanent3_3EnterViewContainer:buildViews()
	local views = {}

	table.insert(views, Permanent3_3EnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Permanent3_3EnterViewContainer:buildTabViews(tabContainerId)
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

return Permanent3_3EnterViewContainer
