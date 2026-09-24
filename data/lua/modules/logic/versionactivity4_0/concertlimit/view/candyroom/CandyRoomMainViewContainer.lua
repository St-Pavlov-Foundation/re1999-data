-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/candyroom/CandyRoomMainViewContainer.lua

module("modules.logic.versionactivity4_0.concertlimit.view.candyroom.CandyRoomMainViewContainer", package.seeall)

local CandyRoomMainViewContainer = class("CandyRoomMainViewContainer", BaseViewContainer)

function CandyRoomMainViewContainer:buildViews()
	local views = {}

	table.insert(views, CandyRoomMainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function CandyRoomMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonView
		}
	end
end

return CandyRoomMainViewContainer
