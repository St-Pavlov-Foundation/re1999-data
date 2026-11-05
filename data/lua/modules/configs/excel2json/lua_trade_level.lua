-- chunkname: @modules/configs/excel2json/lua_trade_level.lua

module("modules.configs.excel2json.lua_trade_level", package.seeall)

local lua_trade_level = {}
local fields = {
	maxRestBuildingNum = 2,
	maxTrainSlotCount = 8,
	jobCard = 6,
	job = 5,
	dimension = 4,
	levelUpNeedTask = 7,
	trainsRoundCount = 9,
	unlockId = 10,
	addBlockMax = 3,
	silenceBonus = 11,
	bonus = 12,
	taskName = 13,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {
	dimension = 1,
	taskName = 3,
	job = 2
}
local _configList, _configDict
local configPath = "configs.trade_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_trade_level, "configList", _configList)
	rawset(lua_trade_level, "configDict", _configDict)
end

setmetatable(lua_trade_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_trade_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_trade_level, "configList", nil)
	rawset(lua_trade_level, "configDict", nil)
end

return lua_trade_level
