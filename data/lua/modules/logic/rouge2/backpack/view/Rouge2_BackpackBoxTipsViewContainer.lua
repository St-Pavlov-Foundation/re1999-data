-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackBoxTipsViewContainer.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackBoxTipsViewContainer", package.seeall)

local Rouge2_BackpackBoxTipsViewContainer = class("Rouge2_BackpackBoxTipsViewContainer", BaseViewContainer)

function Rouge2_BackpackBoxTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_BackpackBoxTipsView.New())

	return views
end

return Rouge2_BackpackBoxTipsViewContainer
