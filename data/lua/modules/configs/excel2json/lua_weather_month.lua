-- chunkname: @modules/configs/excel2json/lua_weather_month.lua

module("modules.configs.excel2json.lua_weather_month", package.seeall)

local lua_weather_month = {}
local fields = {
	id = 1,
	weekList = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.weather_month_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_weather_month, "configList", _configList)
	rawset(lua_weather_month, "configDict", _configDict)
end

setmetatable(lua_weather_month, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_weather_month.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_weather_month, "configList", nil)
	rawset(lua_weather_month, "configDict", nil)
end

return lua_weather_month
