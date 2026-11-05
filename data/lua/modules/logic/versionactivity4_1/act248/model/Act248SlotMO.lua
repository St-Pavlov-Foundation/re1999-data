-- chunkname: @modules/logic/versionactivity4_1/act248/model/Act248SlotMO.lua

module("modules.logic.versionactivity4_1.act248.model.Act248SlotMO", package.seeall)

local Act248SlotMO = pureTable("Act248SlotMO")

function Act248SlotMO:init(co)
	self._co = co
	self.id = co.id

	if self:isAutoFill() then
		self._status = Act248Enum.SlotFillStatus.Correct
	end

	self._actId = Act248Model.instance:getActId()
end

function Act248SlotMO:getConfig()
	return self._co
end

function Act248SlotMO:isAutoFill()
	return self._co.isAutoFill == 1
end

function Act248SlotMO:initFillClueInfo(clueId)
	self:setFillClueId(clueId)

	if not clueId then
		self:setStatus(Act248Enum.SlotFillStatus.Normal)

		return
	end

	if clueId == self:getCorrectClueId() then
		self:setStatus(Act248Enum.SlotFillStatus.Correct)

		return
	end

	self:setStatus(Act248Enum.SlotFillStatus.Error)
end

function Act248SlotMO:getCorrectClueId()
	return self._co.clueId
end

function Act248SlotMO:clearFillClue()
	if self:isAutoFill() then
		self:setFillClueId(self:getCorrectClueId())

		return
	end

	self:setFillClueId()
end

function Act248SlotMO:setFillClueId(clueId)
	self._fillClueId = clueId
end

function Act248SlotMO:getFillClueId()
	if self:isAutoFill() then
		return self:getCorrectClueId()
	end

	return self._fillClueId
end

function Act248SlotMO:setStatus(status)
	if self._status == status then
		return
	end

	self._status = status
end

function Act248SlotMO:getStatus()
	if self:isAutoFill() then
		return Act248Enum.SlotFillStatus.Correct
	end

	return self._status
end

return Act248SlotMO
