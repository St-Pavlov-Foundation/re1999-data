-- chunkname: @modules/logic/versionactivity4_1/act248/model/Act248ReportRoleListModel.lua

module("modules.logic.versionactivity4_1.act248.model.Act248ReportRoleListModel", package.seeall)

local Act248ReportRoleListModel = class("Act248ReportRoleListModel", ListScrollModel)

function Act248ReportRoleListModel:setModel(fileId)
	if not self._roleMoList then
		self._roleMoList = {}
	end

	local list = self._roleMoList[fileId]

	if not list then
		list = {}

		local reportCo = Act248Config.instance:getReportCo(fileId)

		if not string.nilorempty(reportCo.optionIds) then
			for _, optionId in ipairs(string.split(reportCo.optionIds, "|")) do
				local mo = Act248RoleMO.New()

				mo:init(tonumber(optionId))
				table.insert(list, mo)
			end
		end

		self._roleMoList[fileId] = list
	end

	for _, mo in ipairs(list) do
		mo:clearStatus()
	end

	self:setList(list)
end

Act248ReportRoleListModel.instance = Act248ReportRoleListModel.New()

return Act248ReportRoleListModel
