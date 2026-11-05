-- chunkname: @modules/configs/excel2json/lua_udimo_weather.lua

module("modules.configs.excel2json.lua_udimo_weather", package.seeall)

local lua_udimo_weather = {}
local fields = {
	color = 6,
	effect = 7,
	name = 4,
	minTemperature = 10,
	weatherIds = 2,
	maxTemperature = 11,
	windLevel = 3,
	audioId = 8,
	stopAudioId = 9,
	id = 1,
	icon = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.udimo_weather_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_udimo_weather, "configList", _configList)
	rawset(lua_udimo_weather, "configDict", _configDict)
end

setmetatable(lua_udimo_weather, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_udimo_weather.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_udimo_weather, "configList", nil)
	rawset(lua_udimo_weather, "configDict", nil)
end

return lua_udimo_weather
