-- chunkname: @modules/logic/versionactivity4_1/linkgift/view/V4a1_LinkGift_PanelViewContainer.lua

module("modules.logic.versionactivity4_1.linkgift.view.V4a1_LinkGift_PanelViewContainer", package.seeall)

local V4a1_LinkGift_PanelViewContainer = class("V4a1_LinkGift_PanelViewContainer", V4a1_LinkGift_BaseViewContainer)

function V4a1_LinkGift_PanelViewContainer:buildViews()
	local views = {}

	self._view = V4a1_LinkGift_PanelView.New()

	table.insert(views, self._view)

	return views
end

function V4a1_LinkGift_PanelViewContainer:view()
	return self._view
end

return V4a1_LinkGift_PanelViewContainer
