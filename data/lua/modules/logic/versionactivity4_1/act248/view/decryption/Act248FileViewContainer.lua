-- chunkname: @modules/logic/versionactivity4_1/act248/view/decryption/Act248FileViewContainer.lua

module("modules.logic.versionactivity4_1.act248.view.decryption.Act248FileViewContainer", package.seeall)

local Act248FileViewContainer = class("Act248FileViewContainer", BaseViewContainer)

function Act248FileViewContainer:buildViews()
	local views = {}

	table.insert(views, Act248FileView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act248FileViewContainer:buildTabViews(tabContainerId)
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

return Act248FileViewContainer
