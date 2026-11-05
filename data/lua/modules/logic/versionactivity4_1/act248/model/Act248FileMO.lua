-- chunkname: @modules/logic/versionactivity4_1/act248/model/Act248FileMO.lua

module("modules.logic.versionactivity4_1.act248.model.Act248FileMO", package.seeall)

local Act248FileMO = pureTable("Act248FileMO")

function Act248FileMO:initCo(co)
	self._co = co
	self.id = self._co.id
	self._isLock = true
	self._actId = Act248Model.instance:getActId()
end

function Act248FileMO:getConfig()
	return self._co
end

function Act248FileMO:isNew()
	if self:isLock() or self:isFinish() or self:isFinishFill() then
		return false
	end

	local key = string.format("%s_%s_%s", Act248Enum.PlayerPrefKey.NewFile, self._actId, self.id)

	return GameUtil.playerPrefsGetNumberByUserId(key, 0) == 0
end

function Act248FileMO:cancelNew()
	if self:isLock() or self:isFinish() or self:isFinishFill() then
		return
	end

	local key = string.format("%s_%s_%s", Act248Enum.PlayerPrefKey.NewFile, self._actId, self.id)

	GameUtil.playerPrefsSetNumberByUserId(key, 1)
end

function Act248FileMO:refreshInfo(info)
	self._fileId = info.fileId

	local mos = self:getSlotMos()

	for _, mo in ipairs(mos) do
		mo:clearFillClues()
	end

	for _, v in ipairs(info.slotInfos) do
		local slotCo = lua_activity248_slot.configDict[v.slotId]
		local slotGroupMo = slotCo and self:getSlotMoByPileId(slotCo.pileId)

		if slotGroupMo then
			slotGroupMo:setFillClue(v.slotId, v.fillClueId)
		end
	end

	self:onFinishFill(info.hasReport)
	self:onFinish(info.hasFinishedReport)
	self:setLock(false)
end

function Act248FileMO:isLock()
	if self._co.previous > 0 then
		local preMo = Act248Model.instance:getFileById(self._co.previous)

		if preMo and not preMo:isFinish() then
			return true
		end
	end

	return self._isLock
end

function Act248FileMO:setLock(lock)
	self._isLock = lock
end

function Act248FileMO:isFinishFill()
	return self._isFinishFill
end

function Act248FileMO:onFinishFill(isFinish)
	self._isFinishFill = isFinish
end

function Act248FileMO:isFinish()
	return self._isFinish
end

function Act248FileMO:onFinish(isFinish)
	self._isFinish = isFinish
end

function Act248FileMO:getReportCo()
	return Act248Config.instance:getReportCo(self.id)
end

function Act248FileMO:getSlotMos()
	if not self._slotMos then
		self._slotMos = {}
		self._slotMoDict = {}

		local slotIds = string.splitToNumber(self._co.slotIds, "|")

		for i, id in pairs(slotIds) do
			local co = lua_activity248_slot.configDict[id]

			if not self._slotMoDict[co.pileId] then
				local mo = Act248SlotGroupMO.New()

				mo:init(self.id, co.pileId)
				table.insert(self._slotMos, mo)

				self._slotMoDict[co.pileId] = mo
			end
		end
	end

	return self._slotMos
end

function Act248FileMO:getSlotMoByPileId(pileId)
	local mos = self:getSlotMos()

	for _, slotGroupMo in ipairs(mos) do
		if pileId == slotGroupMo.id then
			return slotGroupMo
		end
	end
end

function Act248FileMO:getSlotMoBySlotId(slotId)
	local mos = self:getSlotMos()

	for _, slotGroupMo in ipairs(mos) do
		local slotMo = slotGroupMo:getSlotMoById(slotId)

		if slotMo then
			return slotMo
		end
	end
end

function Act248FileMO:isLackClue()
	local mos = self:getSlotMos()

	for _, slotGroupMo in ipairs(mos) do
		for _, mo in ipairs(slotGroupMo:getMos()) do
			local clueId = mo:getCorrectClueId()

			if not Act248Model.instance:isUnlockClue(clueId) then
				return true
			end
		end
	end
end

return Act248FileMO
