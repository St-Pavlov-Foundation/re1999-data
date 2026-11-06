-- chunkname: @modules/logic/versionactivity4_1/act248/model/Act248RoleMO.lua

module("modules.logic.versionactivity4_1.act248.model.Act248RoleMO", package.seeall)

local Act248RoleMO = pureTable("Act248RoleMO")

function Act248RoleMO:init(id)
	self.id = id
	self.co = Act248Config.instance:getReportOptionCo(id)
end

function Act248RoleMO:onFill(isFill)
	self._isFill = isFill
end

function Act248RoleMO:isFill()
	return self._isFill
end

function Act248RoleMO:clearStatus()
	self:onFill()
end

return Act248RoleMO
