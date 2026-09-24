-- chunkname: @modules/logic/decorate/view/DecorateMaterialBuyViewContainer.lua

module("modules.logic.decorate.view.DecorateMaterialBuyViewContainer", package.seeall)

local DecorateMaterialBuyViewContainer = class("DecorateMaterialBuyViewContainer", BaseViewContainer)

function DecorateMaterialBuyViewContainer:buildViews()
	local views = {}

	table.insert(views, DecorateMaterialBuyView.New())

	return views
end

function DecorateMaterialBuyViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._currencyView = CurrencyView.New({})

		return {
			self._currencyView
		}
	end
end

function DecorateMaterialBuyViewContainer:setCurrencyType(currencyTypeParam)
	if self._currencyView then
		self._currencyView:setCurrencyType(currencyTypeParam)
	end
end

function DecorateMaterialBuyViewContainer:getMaterialTipViewBanner()
	if not self._materialTipViewBanner then
		self._materialTipViewBanner = DecorateMaterialTipViewBanner.New()
	end

	return self._materialTipViewBanner
end

return DecorateMaterialBuyViewContainer
