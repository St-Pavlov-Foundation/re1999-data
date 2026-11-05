-- chunkname: @modules/logic/necrologiststory/prefs/NecrologistStoryPlayerPrefsDataBase.lua

module("modules.logic.necrologiststory.prefs.NecrologistStoryPlayerPrefsDataBase", package.seeall)

local NecrologistStoryPlayerPrefsDataBase = class("NecrologistStoryPlayerPrefsDataBase")

function NecrologistStoryPlayerPrefsDataBase:ctor(key)
	self.prefsKey = key

	self:initData()
end

function NecrologistStoryPlayerPrefsDataBase:initData()
	local keyType = self:getKeyType()

	if keyType == NecrologistStoryEnum.PrefsKeyType.NumberList then
		self.dict = {}

		local val = GameUtil.playerPrefsGetStringByUserId(self.prefsKey, "")
		local list = string.splitToNumber(val, "#")

		for _, v in ipairs(list) do
			self.dict[v] = true
		end
	elseif keyType == NecrologistStoryEnum.PrefsKeyType.String then
		self.value = GameUtil.playerPrefsGetStringByUserId(self.prefsKey, "")
	elseif keyType == NecrologistStoryEnum.PrefsKeyType.Number then
		self.value = GameUtil.playerPrefsGetNumberByUserId(self.prefsKey, 0)
	elseif keyType == NecrologistStoryEnum.PrefsKeyType.Bool then
		local val = GameUtil.playerPrefsGetNumberByUserId(self.prefsKey, 0)

		self.value = val == 1
	end
end

function NecrologistStoryPlayerPrefsDataBase:isExist(value)
	local keyType = self:getKeyType()

	if keyType == NecrologistStoryEnum.PrefsKeyType.NumberList then
		return self.dict[value]
	else
		return self.value == value
	end
end

function NecrologistStoryPlayerPrefsDataBase:setExist(value)
	if self:isExist(value) then
		return
	end

	local keyType = self:getKeyType()

	if keyType == NecrologistStoryEnum.PrefsKeyType.NumberList then
		self.dict[value] = true
	else
		self.value = value
	end

	self:saveData()
end

function NecrologistStoryPlayerPrefsDataBase:saveData()
	local saveVal
	local keyType = self:getKeyType()

	if keyType == NecrologistStoryEnum.PrefsKeyType.NumberList then
		local list = {}

		for id, _ in pairs(self.dict) do
			table.insert(list, id)
		end

		saveVal = table.concat(list, "#")
	elseif keyType == NecrologistStoryEnum.PrefsKeyType.Bool then
		saveVal = self.value and 1 or 0
	elseif keyType == NecrologistStoryEnum.PrefsKeyType.Number then
		saveVal = self.value
	else
		saveVal = tostring(self.value)
	end

	if saveVal then
		local isNumber = type(saveVal) == "number"

		if isNumber then
			GameUtil.playerPrefsSetNumberByUserId(self.prefsKey, saveVal)
		else
			GameUtil.playerPrefsSetStringByUserId(self.prefsKey, saveVal)
		end
	end
end

function NecrologistStoryPlayerPrefsDataBase:getKeyType()
	return NecrologistStoryEnum.PrefsKey2Type[self.prefsKey]
end

return NecrologistStoryPlayerPrefsDataBase
