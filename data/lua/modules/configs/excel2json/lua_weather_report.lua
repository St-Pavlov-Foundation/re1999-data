-- chunkname: @modules/configs/excel2json/lua_weather_report.lua

module("modules.configs.excel2json.lua_weather_report", package.seeall)

local lua_weather_report = {}
local fields = {
	audioLength = 6,
	effect = 4,
	roomMode = 5,
	id = 1,
	lightMode = 2,
	roleMode = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.weather_report_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_weather_report, "configList", _configList)
	rawset(lua_weather_report, "configDict", _configDict)
end

setmetatable(lua_weather_report, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_weather_report.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_weather_report, "configList", nil)
	rawset(lua_weather_report, "configDict", nil)
end

return lua_weather_report
