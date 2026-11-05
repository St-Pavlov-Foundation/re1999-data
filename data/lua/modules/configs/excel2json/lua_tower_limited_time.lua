-- chunkname: @modules/configs/excel2json/lua_tower_limited_time.lua

module("modules.configs.excel2json.lua_tower_limited_time", package.seeall)

local lua_tower_limited_time = {}
local fields = {
	bossPool = 4,
	isOnline = 6,
	endTime = 3,
	season = 1,
	taskGroupId = 5,
	startTime = 2
}
local primaryKey = {
	"season"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.tower_limited_time_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_limited_time, "configList", _configList)
	rawset(lua_tower_limited_time, "configDict", _configDict)
end

setmetatable(lua_tower_limited_time, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_limited_time.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_limited_time, "configList", nil)
	rawset(lua_tower_limited_time, "configDict", nil)
end

return lua_tower_limited_time
