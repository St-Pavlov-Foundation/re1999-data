-- chunkname: @modules/logic/rouge2/map/view/attributeup/Rouge2_MapAttributeUpViewContainer.lua

module("modules.logic.rouge2.map.view.attributeup.Rouge2_MapAttributeUpViewContainer", package.seeall)

local Rouge2_MapAttributeUpViewContainer = class("Rouge2_MapAttributeUpViewContainer", BaseViewContainer)

function Rouge2_MapAttributeUpViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_MapAttributeUpView.New())

	return views
end

return Rouge2_MapAttributeUpViewContainer
