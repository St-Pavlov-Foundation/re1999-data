-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_ResultReportListModel.lua

module("modules.logic.rouge2.outside.model.Rouge2_ResultReportListModel", package.seeall)

local Rouge2_ResultReportListModel = class("Rouge2_ResultReportListModel", ListScrollModel)

function Rouge2_ResultReportListModel:initList()
	local tempList = {}
	local infoList = Rouge2_OutsideModel.instance:getReviewInfoList()

	if infoList then
		for _, info in ipairs(infoList) do
			local mo = {}

			mo.info = info

			table.insert(tempList, mo)
		end
	end

	self:setList(tempList)
end

Rouge2_ResultReportListModel.instance = Rouge2_ResultReportListModel.New()

return Rouge2_ResultReportListModel
