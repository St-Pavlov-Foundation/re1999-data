-- chunkname: @modules/configs/excel2json/lua_weather_week.lua

module("modules.configs.excel2json.lua_weather_week", package.seeall)

local lua_weather_week = {}
local fields = {
	id = 1,
	day6 = 7,
	day4 = 5,
	day5 = 6,
	day3 = 4,
	day1 = 2,
	day7 = 8,
	day2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.weather_week_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_weather_week, "configList", _configList)
	rawset(lua_weather_week, "configDict", _configDict)
end

setmetatable(lua_weather_week, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_weather_week.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_weather_week, "configList", nil)
	rawset(lua_weather_week, "configDict", nil)
end

return lua_weather_week
