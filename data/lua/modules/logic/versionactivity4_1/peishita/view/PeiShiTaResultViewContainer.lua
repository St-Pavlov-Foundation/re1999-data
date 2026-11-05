-- chunkname: @modules/logic/versionactivity4_1/peishita/view/PeiShiTaResultViewContainer.lua

module("modules.logic.versionactivity4_1.peishita.view.PeiShiTaResultViewContainer", package.seeall)

local PeiShiTaResultViewContainer = class("PeiShiTaResultViewContainer", BaseViewContainer)

function PeiShiTaResultViewContainer:buildViews()
	local views = {}

	table.insert(views, PeiShiTaResultView.New())

	return views
end

return PeiShiTaResultViewContainer
