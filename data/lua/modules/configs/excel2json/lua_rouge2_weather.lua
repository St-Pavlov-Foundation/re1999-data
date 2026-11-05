-- chunkname: @modules/configs/excel2json/lua_rouge2_weather.lua

module("modules.configs.excel2json.lua_rouge2_weather", package.seeall)

local lua_rouge2_weather = {}
local fields = {
	id = 1,
	title = 2,
	icon = 3,
	pathSelectWeatherUrl = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 1
}
local _configList, _configDict
local configPath = "configs.rouge2_weather_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_weather, "configList", _configList)
	rawset(lua_rouge2_weather, "configDict", _configDict)
end

setmetatable(lua_rouge2_weather, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_weather.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_weather, "configList", nil)
	rawset(lua_rouge2_weather, "configDict", nil)
end

return lua_rouge2_weather
