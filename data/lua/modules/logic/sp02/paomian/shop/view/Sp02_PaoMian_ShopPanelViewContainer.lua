-- chunkname: @modules/logic/sp02/paomian/shop/view/Sp02_PaoMian_ShopPanelViewContainer.lua

module("modules.logic.sp02.paomian.shop.view.Sp02_PaoMian_ShopPanelViewContainer", package.seeall)

local Sp02_PaoMian_ShopPanelViewContainer = class("Sp02_PaoMian_ShopPanelViewContainer", BaseViewContainer)

function Sp02_PaoMian_ShopPanelViewContainer:buildViews()
	local views = {}

	table.insert(views, Sp02_PaoMian_ShopPanelView.New())

	return views
end

function Sp02_PaoMian_ShopPanelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		})

		return {
			self.navigateView
		}
	end
end

return Sp02_PaoMian_ShopPanelViewContainer
