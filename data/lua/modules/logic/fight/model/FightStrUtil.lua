﻿-- chunkname: @modules/logic/fight/model/FightStrUtil.lua

local FightStrUtil = class("FightStrUtil")
local NumberTrue = "true"
local NumberFalse = "false"

function FightStrUtil:ctor()
	return
end

function FightStrUtil.split(input, delimiter)
	input = tostring(input)
	delimiter = tostring(delimiter)

	if delimiter == "" then
		return false
	end

	local pos, arr = 0, {}

	for st, sp in function()
		return string.find(input, delimiter, pos, true)
	end do
		table.insert(arr, string.sub(input, pos, st - 1))

		pos = sp + 1
	end

	table.insert(arr, string.sub(input, pos))

	return arr
end

function FightStrUtil.splitToNumber(input, delimiter)
	local arr = {}

	for i, v in ipairs(FightStrUtil.split(input, delimiter)) do
		arr[i] = tonumber(v)
	end

	return arr
end

function FightStrUtil.splitString2(str, isNumber, separation1, separation2)
	if string.nilorempty(str) then
		return
	end

	separation1 = separation1 or "|"
	separation2 = separation2 or "#"

	local ans = FightStrUtil.split(str, separation1)

	for i, each in ipairs(ans) do
		if isNumber then
			ans[i] = FightStrUtil.splitToNumber(each, separation2)
		else
			ans[i] = FightStrUtil.split(each, separation2)
		end
	end

	return ans
end

function FightStrUtil:init()
	self.inited = true
end

function FightStrUtil:getSplitCache(content, delimiter)
	self:logNoInFight()

	local cacheKey = tostring(delimiter)

	if not self._splitCache then
		self._splitCache = {}
	end

	if not self._splitCache[cacheKey] then
		self._splitCache[cacheKey] = {}
	end

	local cacheTable = self._splitCache[cacheKey]
	local key = tostring(content)

	if not cacheTable[key] then
		cacheTable[key] = self.split(content, delimiter)
	end

	return cacheTable[key]
end

function FightStrUtil:getSplitToNumberCache(content, delimiter)
	self:logNoInFight()

	local cacheKey = tostring(delimiter)

	if not self._splitToNumberCache then
		self._splitToNumberCache = {}
	end

	if not self._splitToNumberCache[cacheKey] then
		self._splitToNumberCache[cacheKey] = {}
	end

	local cacheTable = self._splitToNumberCache[cacheKey]
	local key = tostring(content)

	if not cacheTable[key] then
		cacheTable[key] = self.splitToNumber(content, delimiter)
	end

	return cacheTable[key]
end

function FightStrUtil:getSplitString2Cache(content, isNumber, separation1, separation2)
	self:logNoInFight()

	if string.nilorempty(content) then
		return
	end

	separation1 = separation1 or "|"
	separation2 = separation2 or "#"

	local numberStr = isNumber and NumberTrue or NumberFalse

	if not self._splitString2Cache then
		self._splitString2Cache = {}
	end

	if not self._splitString2Cache[numberStr] then
		self._splitString2Cache[numberStr] = {}
	end

	if not self._splitString2Cache[numberStr][separation1] then
		self._splitString2Cache[numberStr][separation1] = {}
	end

	if not self._splitString2Cache[numberStr][separation1][separation2] then
		self._splitString2Cache[numberStr][separation1][separation2] = {}
	end

	local cacheTable = self._splitString2Cache[numberStr][separation1][separation2]
	local key = tostring(content)

	if not cacheTable[key] then
		cacheTable[key] = self.splitString2(content, isNumber, separation1, separation2)
	end

	return cacheTable[key]
end

function FightStrUtil:logNoInFight()
	if not self.inited and GameUtil.needLogInOtherSceneUseFightStrUtilFunc() then
		logError("不在战斗内，不要调用`FightStrUtil`相关接口")
	end
end

function FightStrUtil:dispose()
	self.inited = nil

	if self._splitCache then
		self._splitCache = nil
	end

	if self._splitToNumberCache then
		self._splitToNumberCache = nil
	end

	if self._splitString2Cache then
		self._splitString2Cache = nil
	end
end

FightStrUtil.instance = FightStrUtil.New()

return FightStrUtil
