-- chunkname: @modules/logic/versionactivity4_1/evelyn/view/EvelynPanelViewContainer.lua

module("modules.logic.versionactivity4_1.evelyn.view.EvelynPanelViewContainer", package.seeall)

local EvelynPanelViewContainer = class("EvelynPanelViewContainer", BaseViewContainer)

function EvelynPanelViewContainer:buildViews()
	local views = {}

	table.insert(views, EvelynPanelView.New())

	return views
end

return EvelynPanelViewContainer
