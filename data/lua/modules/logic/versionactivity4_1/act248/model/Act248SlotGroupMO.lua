-- chunkname: @modules/logic/versionactivity4_1/act248/model/Act248SlotGroupMO.lua

module("modules.logic.versionactivity4_1.act248.model.Act248SlotGroupMO", package.seeall)

local Act248SlotGroupMO = pureTable("Act248SlotGroupMO")

function Act248SlotGroupMO:init(fileId, id)
	self.fileId = fileId
	self.id = id

	local cos = Act248Config.instance:getSlotGroupCos(id)

	self._actId = Act248Model.instance:getActId()
	self._slotMos = {}
	self._sortSlotMos = {}
	self._correctClueIds = {}

	local isAutoFill = true

	if cos then
		for _, co in ipairs(cos) do
			local mo = Act248SlotMO.New()

			mo:init(co)
			table.insert(self._slotMos, mo)
			table.insert(self._sortSlotMos, mo)

			self._correctClueIds[co.clueId] = mo.id

			if not mo:isAutoFill() then
				isAutoFill = false
			end
		end
	end

	self:checkWrongClues()
end

function Act248SlotGroupMO:setFillClues(clues)
	local clueDic = {}
	local wrongClueDic = {}

	self._sortSlotMos = {}

	for i, clueId in ipairs(clues) do
		local slotId = self._correctClueIds[clueId]

		if slotId then
			clueDic[slotId] = clueId
			self._sortSlotMos[i] = self:getSlotMoById(slotId)
		else
			table.insert(wrongClueDic, clueId)
		end
	end

	local index = 1

	for i, mo in ipairs(self._slotMos) do
		if not clueDic[mo.id] then
			clueDic[mo.id] = wrongClueDic[index]
			index = index + 1

			local emptyIndex = self:_getEmptyIndex(self._sortSlotMos)

			if emptyIndex then
				self._sortSlotMos[emptyIndex] = mo
			end
		end

		mo:setFillClueId(clueDic[mo.id])
	end

	self:_saveErrorClues()

	return clueDic
end

function Act248SlotGroupMO:getSortSlots()
	return self._sortSlotMos
end

function Act248SlotGroupMO:_getEmptyIndex(slotDic)
	if self._slotMos and slotDic then
		for i = 1, #self._slotMos do
			if not slotDic[i] then
				return i
			end
		end
	end
end

function Act248SlotGroupMO:getSlotMoByClueId(clueId)
	local slotId = self._correctClueIds[clueId]

	if slotId then
		return self:getSlotMoById(slotId)
	end
end

function Act248SlotGroupMO:isCorrectClueId(clueId)
	return self._correctClueIds[clueId] ~= nil
end

function Act248SlotGroupMO:getConfig()
	local mo = self._slotMos[1]

	return mo:getConfig()
end

function Act248SlotGroupMO:clearFillClues()
	for _, mo in ipairs(self._slotMos) do
		mo:clearFillClue()
	end
end

function Act248SlotGroupMO:setFillClue(slotId, fillClueId)
	local mo = self:getSlotMoById(slotId)

	if mo then
		mo:initFillClueInfo(fillClueId)
	end
end

function Act248SlotGroupMO:getFillClueId()
	local fillclue

	for _, mo in ipairs(self._slotMos) do
		local fillClueId = mo:getFillClueId()

		if fillClueId and fillClueId > 0 then
			if not fillclue then
				fillclue = fillClueId
			end
		else
			return
		end
	end

	return fillclue
end

function Act248SlotGroupMO:isCorrectFill()
	if self:getStatus() == Act248Enum.SlotFillStatus.Correct then
		return true
	end

	for _, mo in ipairs(self._slotMos) do
		local status = mo:getStatus()

		if status ~= Act248Enum.SlotFillStatus.Correct then
			return false
		end
	end

	return true
end

function Act248SlotGroupMO:getMos()
	return self._slotMos
end

function Act248SlotGroupMO:getSlotMoById(id)
	for _, mo in ipairs(self._slotMos) do
		if mo.id == id then
			return mo
		end
	end
end

function Act248SlotGroupMO:getSlotMoByIndex(index)
	return self._sortSlotMos and self._sortSlotMos[index]
end

function Act248SlotGroupMO:getStatus()
	if self:isAllAutoFill() then
		return Act248Enum.SlotFillStatus.Correct
	end

	local hasError = false

	for _, mo in ipairs(self:getMos()) do
		local fillClueId = mo:getFillClueId()
		local _status = mo:getStatus()
		local isCorrectClue = self._correctClueIds[fillClueId]

		if _status == Act248Enum.SlotFillStatus.Correct then
			if not isCorrectClue then
				mo:setStatus(Act248Enum.SlotFillStatus.Error)

				hasError = true
			end
		elseif _status == Act248Enum.SlotFillStatus.Error then
			if isCorrectClue then
				mo:setStatus(Act248Enum.SlotFillStatus.Correct)
			else
				hasError = true
			end
		else
			return Act248Enum.SlotFillStatus.Normal
		end
	end

	if hasError then
		return Act248Enum.SlotFillStatus.Error
	end

	return Act248Enum.SlotFillStatus.Correct
end

function Act248SlotGroupMO:isAllAutoFill()
	for _, mo in ipairs(self._slotMos) do
		if not mo:isAutoFill() then
			return false
		end
	end

	return true
end

function Act248SlotGroupMO:isSingle()
	return self._slotMos and #self._slotMos == 1
end

function Act248SlotGroupMO:getCatrgoryCo()
	local co = self:getConfig()

	return Act248Config.instance:getCategoryCo(co.tagId)
end

function Act248SlotGroupMO:checkWrongClues()
	local key = string.format("%s_%s_%s", Act248Enum.PlayerPrefKey.SlotWrongClueIds, self._actId, self.id)
	local wrongStr = GameUtil.playerPrefsGetStringByUserId(key, "")

	self._wrongClueIds = {}

	for _, clueId in pairs(string.splitToNumber(wrongStr, "#")) do
		self._wrongClueIds[clueId] = true
	end
end

function Act248SlotGroupMO:_saveErrorClues()
	local wrongStr = ""

	for _, mo in ipairs(self._slotMos) do
		local clueId = mo:getFillClueId()

		if clueId ~= mo:getCorrectClueId() then
			self._wrongClueIds[clueId] = true
		end
	end

	for id in pairs(self._wrongClueIds) do
		wrongStr = string.format("%s#%s", wrongStr, id)
	end

	local key = string.format("%s_%s_%s", Act248Enum.PlayerPrefKey.SlotWrongClueIds, self._actId, self.id)

	GameUtil.playerPrefsSetStringByUserId(key, wrongStr)
end

function Act248SlotGroupMO:isErrorClueId(clueId)
	return self._wrongClueIds[clueId]
end

return Act248SlotGroupMO
