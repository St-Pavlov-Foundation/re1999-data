-- chunkname: @modules/logic/sodache/view/outside/SodacheHandbookViewContainer.lua

module("modules.logic.sodache.view.outside.SodacheHandbookViewContainer", package.seeall)

local SodacheHandbookViewContainer = class("SodacheHandbookViewContainer", BaseViewContainer)

function SodacheHandbookViewContainer:buildViews()
	local views = {}

	self.scrollView = LuaMixScrollView.New(SodacheHandbookListModel.instance, self:getMixContentParam())

	table.insert(views, self.scrollView)
	table.insert(views, SodacheHandbookView.New())
	table.insert(views, SodacheHandbookViewFold.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function SodacheHandbookViewContainer:buildTabViews(tabContainerId)
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

function SodacheHandbookViewContainer:getMixContentParam()
	local scrollParam = MixScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_Card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_Card/Viewport/Content/go_HandbookItem"
	scrollParam.cellClass = SodacheHandbookGroupItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.endSpace = 20

	return scrollParam
end

return SodacheHandbookViewContainer
