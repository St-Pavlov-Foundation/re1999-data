-- chunkname: @modules/logic/versionactivity4_1/linkgift/view/V4a1_LinkGift_FullViewContainer.lua

module("modules.logic.versionactivity4_1.linkgift.view.V4a1_LinkGift_FullViewContainer", package.seeall)

local V4a1_LinkGift_FullViewContainer = class("V4a1_LinkGift_FullViewContainer", V4a1_LinkGift_BaseViewContainer)

function V4a1_LinkGift_FullViewContainer:buildViews()
	local views = {}

	self._view = V4a1_LinkGift_FullView.New()

	table.insert(views, self._view)

	return views
end

function V4a1_LinkGift_FullViewContainer:view()
	return self._view
end

return V4a1_LinkGift_FullViewContainer
