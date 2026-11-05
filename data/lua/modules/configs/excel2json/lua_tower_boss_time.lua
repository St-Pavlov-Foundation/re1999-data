-- chunkname: @modules/configs/excel2json/lua_tower_boss_time.lua

module("modules.configs.excel2json.lua_tower_boss_time", package.seeall)

local lua_tower_boss_time = {}
local fields = {
	taskEndTime = 7,
	isOnline = 8,
	isPermanent = 3,
	endTime = 5,
	startTime = 4,
	taskGroupId = 6,
	round = 2,
	towerId = 1
}
local primaryKey = {
	"towerId",
	"round"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.tower_boss_time_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_boss_time, "configList", _configList)
	rawset(lua_tower_boss_time, "configDict", _configDict)
end

setmetatable(lua_tower_boss_time, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_boss_time.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_boss_time, "configList", nil)
	rawset(lua_tower_boss_time, "configDict", nil)
end

return lua_tower_boss_time
