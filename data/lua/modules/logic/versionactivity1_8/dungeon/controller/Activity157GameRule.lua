﻿-- chunkname: @modules/logic/versionactivity1_8/dungeon/controller/Activity157GameRule.lua

module("modules.logic.versionactivity1_8.dungeon.controller.Activity157GameRule", package.seeall)

local Activity157GameRule = class("Activity157GameRule")
local LEFT = ArmPuzzlePipeEnum.dir.left
local RIGHT = ArmPuzzlePipeEnum.dir.right
local DOWN = ArmPuzzlePipeEnum.dir.down
local UP = ArmPuzzlePipeEnum.dir.up
local EmptyChange = 0

function Activity157GameRule:ctor()
	self._ruleChange = {
		[0] = 0,
		[28] = 46,
		[248] = 468,
		[24] = 48,
		[46] = 28,
		[48] = 68,
		[246] = 248,
		[268] = 246,
		[468] = 268,
		[26] = 24,
		[68] = 26,
		[2468] = 2468
	}
	self._ruleConnect = {}

	for k, v in pairs(self._ruleChange) do
		local rule = {}
		local val = k

		while val > 0 do
			local mod = val % 10

			val = math.floor(val / 10)
			rule[mod] = true
		end

		self._ruleConnect[k] = rule
	end

	self._ruleConnect[EmptyChange] = {
		[RIGHT] = false,
		[LEFT] = false,
		[DOWN] = false,
		[UP] = false
	}
end

function Activity157GameRule:setGameSize(w, h)
	self._gameWidth = w
	self._gameHeight = h
end

function Activity157GameRule:isGameClear(resultTable)
	for entryMo, result in pairs(resultTable) do
		if not self:getIsEntryClear(entryMo) then
			return false
		end
	end

	return true
end

function Activity157GameRule:getIsEntryClear(entryMo)
	if entryMo.typeId == ArmPuzzlePipeEnum.type.first or entryMo.typeId == ArmPuzzlePipeEnum.type.last then
		return entryMo.entryCount >= 1
	end

	return entryMo.entryCount >= ArmPuzzlePipeEnum.pipeEntryClearCount and entryMo:getConnectValue() >= ArmPuzzlePipeEnum.pipeEntryClearDecimal
end

function Activity157GameRule:getReachTable()
	local entryTable, resultTable = {}, {}
	local openSet = {}
	local orderList = {}
	local entryList = Activity157RepairGameModel.instance:getEntryList()

	table.sort(entryList, Activity157GameRule._sortOrderList)

	for i, entryMo in ipairs(entryList) do
		table.insert(openSet, entryMo)

		local traceTable, resultEntry = self:_getSearchPipeResult(entryMo, openSet)

		resultTable[entryMo] = resultEntry
		entryTable[entryMo] = traceTable
		entryMo.entryCount = #resultEntry

		if entryMo.pathType == ArmPuzzlePipeEnum.PathType.Order then
			table.insert(orderList, entryMo)
		end
	end

	if #orderList > 0 then
		self:_mergeReachDir(entryTable)
		table.sort(orderList, Activity157GameRule._sortOrderList)

		local isCanConn = false

		for i, entryMo in ipairs(orderList) do
			if entryMo.typeId == ArmPuzzlePipeEnum.type.first then
				isCanConn = entryMo.entryCount > 0
			else
				if not isCanConn then
					entryMo:cleanEntrySet()

					entryMo.entryCount = 0
					resultTable[entryMo] = {}
					entryTable[entryMo] = {}
				end

				if isCanConn and not self:getIsEntryClear(entryMo) then
					isCanConn = false
				end
			end
		end

		self:_cleaConnMark()
	end

	return entryTable, resultTable
end

function Activity157GameRule:_cleaConnMark()
	for x = 1, self._gameWidth do
		for y = 1, self._gameHeight do
			local entryMo = Activity157RepairGameModel.instance:getData(x, y)
			local entryCount = entryMo.entryCount

			entryMo:cleanEntrySet()

			entryMo.entryCount = entryCount
		end
	end
end

function Activity157GameRule._sortOrderList(a, b)
	if a.pathIndex ~= b.pathIndex then
		return a.pathIndex < b.pathIndex
	end

	if a.numIndex ~= b.numIndex then
		return a.numIndex < b.numIndex
	end
end

function Activity157GameRule:_getSearchPipeResult(entryMo, openSet)
	local entryList = {}
	local traceSet = {}

	while #openSet > 0 do
		local tmpMo = table.remove(openSet)

		self:_addToOpenSet(tmpMo, traceSet, openSet, entryList)
	end

	for i = #entryList, 1, -1 do
		local tmpMo = entryList[i]

		if not self:_checkEntryConnect(entryMo, tmpMo) or entryMo == tmpMo then
			traceSet[tmpMo] = nil

			table.remove(entryList, i)
		end
	end

	if #entryList < 1 then
		traceSet = {}
	end

	return traceSet, entryList
end

function Activity157GameRule:_checkEntryConnect(entryMo, tmpMo)
	if tmpMo.pathIndex ~= entryMo.pathIndex or tmpMo.pathType ~= entryMo.pathType then
		return false
	end

	if tmpMo.pathType == ArmPuzzlePipeEnum.PathType.Order then
		local act157GameModel = Activity157RepairGameModel.instance
		local tmpIndex = act157GameModel:getIndexByMO(tmpMo)
		local curIndex = act157GameModel:getIndexByMO(entryMo)

		if math.abs(curIndex - tmpIndex) ~= 1 then
			return false
		end
	end

	return true
end

function Activity157GameRule:_addToOpenSet(tmpMo, traceSet, openSet, entryList)
	for dir, _ in pairs(tmpMo.connectSet) do
		local nextX, nextY, reverse = Activity157GameRule.getIndexByDir(tmpMo.x, tmpMo.y, dir)

		if nextX > 0 and nextX <= self._gameWidth and nextY > 0 and nextY <= self._gameHeight then
			local nextMo = Activity157RepairGameModel.instance:getData(nextX, nextY)

			if not traceSet[nextMo] then
				traceSet[nextMo] = true

				if nextMo:isEntry() then
					table.insert(entryList, nextMo)
				else
					table.insert(openSet, nextMo)
				end
			end
		end
	end

	traceSet[tmpMo] = true
end

function Activity157GameRule:_mergeReachDir(entryTable)
	local compareList = {}
	local entryMoList = {}

	for entryMo, reachMap in pairs(entryTable) do
		table.insert(compareList, reachMap)
		table.insert(entryMoList, entryMo)
	end

	local len = #compareList

	for i = 1, len do
		local mergeMap = {}

		for j = i + 1, len do
			local entryMoI, entryMoJ = entryMoList[i], entryMoList[j]

			if self:_checkEntryConnect(entryMoI, entryMoJ) then
				local mapI, mapJ = compareList[i], compareList[j]

				for mo, _ in pairs(mapI) do
					if mapJ[mo] then
						mergeMap[mo] = entryMoI.pathIndex
					end
				end

				self:_markReachDir(mergeMap)
			end
		end
	end
end

function Activity157GameRule:_markReachDir(mergeMap)
	for mo, connPathIndex in pairs(mergeMap) do
		for dir, _ in pairs(mo.connectSet) do
			local connectX, connectY, reverse = Activity157GameRule.getIndexByDir(mo.x, mo.y, dir)

			if connectX > 0 and connectX <= self._gameWidth and connectY > 0 and connectY <= self._gameHeight then
				local connectMo = Activity157RepairGameModel.instance:getData(connectX, connectY)

				if mergeMap[connectMo] then
					mo.entryConnect[dir] = true
					connectMo.entryConnect[reverse] = true
					mo.connectPathIndex = connPathIndex
					connectMo.connectPathIndex = connPathIndex
				end
			end
		end
	end
end

function Activity157GameRule:_unmarkBranch()
	for x = 1, self._gameWidth do
		for y = 1, self._gameHeight do
			local mo = Activity157RepairGameModel.instance:getData(x, y)

			self:_unmarkSearchNode(mo)
		end
	end
end

function Activity157GameRule:_unmarkSearchNode(mo)
	local searchMo = mo

	while searchMo ~= nil do
		if tabletool.len(searchMo.entryConnect) == 1 and not searchMo:isEntry() then
			local dir

			for k, _ in pairs(searchMo.entryConnect) do
				dir = k
			end

			local nextX, nextY, reverse = Activity157GameRule.getIndexByDir(searchMo.x, searchMo.y, dir)
			local nextMo = Activity157RepairGameModel.instance:getData(nextX, nextY)

			searchMo.entryConnect[dir] = nil
			nextMo.entryConnect[reverse] = nil
			searchMo = nextMo
		else
			searchMo = nil
		end
	end
end

function Activity157GameRule:setSingleConnection(x, y, dir, reverse, centerMO)
	if x > 0 and x <= self._gameWidth and y > 0 and y <= self._gameHeight then
		local targetMO = Activity157RepairGameModel.instance:getData(x, y)
		local targetRule = self._ruleConnect[targetMO.value]
		local selfRule = self._ruleConnect[centerMO.value]
		local result = targetRule[dir] and selfRule[reverse]
		local oldSet = targetMO.connectSet[dir] == true

		if result then
			targetMO.connectSet[dir] = true
			centerMO.connectSet[reverse] = true
		else
			targetMO.connectSet[dir] = nil
			centerMO.connectSet[reverse] = nil
		end
	end
end

function Activity157GameRule:changeDirection(x, y)
	local mo = Activity157RepairGameModel.instance:getData(x, y)
	local nextVal = self._ruleChange[mo.value]

	if nextVal then
		mo.value = nextVal
	end

	return mo
end

function Activity157GameRule:getRandomSkipSet()
	local skipSet = {}
	local entryList = Activity157RepairGameModel.instance:getEntryList()

	for _, entry in ipairs(entryList) do
		skipSet[entry] = true

		local x, y = entry.x, entry.y

		self:_insertToSet(x - 1, y, skipSet)
		self:_insertToSet(x + 1, y, skipSet)
		self:_insertToSet(x, y - 1, skipSet)
		self:_insertToSet(x, y + 1, skipSet)
	end

	return skipSet
end

function Activity157GameRule:_insertToSet(x, y, targetSet)
	if x > 0 and x <= self._gameWidth and y > 0 and y <= self._gameHeight then
		local mo = Activity157RepairGameModel.instance:getData(x, y)

		targetSet[mo] = true
	end
end

function Activity157GameRule.getIndexByDir(x, y, dir)
	if dir == LEFT then
		return x - 1, y, RIGHT
	elseif dir == RIGHT then
		return x + 1, y, LEFT
	elseif dir == UP then
		return x, y + 1, DOWN
	elseif dir == DOWN then
		return x, y - 1, UP
	end
end

return Activity157GameRule
