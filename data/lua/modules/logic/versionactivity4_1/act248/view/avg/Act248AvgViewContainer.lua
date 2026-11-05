-- chunkname: @modules/logic/versionactivity4_1/act248/view/avg/Act248AvgViewContainer.lua

module("modules.logic.versionactivity4_1.act248.view.avg.Act248AvgViewContainer", package.seeall)

local Act248AvgViewContainer = class("Act248AvgViewContainer", BaseViewContainer)

function Act248AvgViewContainer:buildViews()
	local views = {}

	table.insert(views, Act248AvgView.New())

	return views
end

return Act248AvgViewContainer
