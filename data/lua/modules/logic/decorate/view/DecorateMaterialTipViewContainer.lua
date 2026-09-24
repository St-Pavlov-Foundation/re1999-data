-- chunkname: @modules/logic/decorate/view/DecorateMaterialTipViewContainer.lua

module("modules.logic.decorate.view.DecorateMaterialTipViewContainer", package.seeall)

local DecorateMaterialTipViewContainer = class("DecorateMaterialTipViewContainer", BaseViewContainer)

function DecorateMaterialTipViewContainer:buildViews()
	local views = {}

	self._materialTipView = self:getMaterialTipView()
	self._materialTipViewBanner = self:getMaterialTipViewBanner()

	table.insert(views, self._materialTipView)
	table.insert(views, self._materialTipViewBanner)

	return views
end

function DecorateMaterialTipViewContainer:getMaterialTipView()
	if not self._materialTipView then
		self._materialTipView = DecorateMaterialTipView.New()
	end

	return self._materialTipView
end

function DecorateMaterialTipViewContainer:getMaterialTipViewBanner()
	if not self._materialTipViewBanner then
		self._materialTipViewBanner = DecorateMaterialTipViewBanner.New()
	end

	return self._materialTipViewBanner
end

return DecorateMaterialTipViewContainer
