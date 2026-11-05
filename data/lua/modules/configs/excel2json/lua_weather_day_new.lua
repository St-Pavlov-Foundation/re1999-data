-- chunkname: @modules/configs/excel2json/lua_weather_day_new.lua

module("modules.configs.excel2json.lua_weather_day_new", package.seeall)

local lua_weather_day_new = {}
local fields = {
	id = 2,
	sceneId = 1,
	reportList = 3
}
local primaryKey = {
	"sceneId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.weather_day_new_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_weather_day_new, "configList", _configList)
	rawset(lua_weather_day_new, "configDict", _configDict)
end

setmetatable(lua_weather_day_new, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_weather_day_new.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_weather_day_new, "configList", nil)
	rawset(lua_weather_day_new, "configDict", nil)
end

return lua_weather_day_new
