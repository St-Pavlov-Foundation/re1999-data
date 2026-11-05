-- chunkname: @modules/configs/excel2json/lua_udimo_temperature.lua

module("modules.configs.excel2json.lua_udimo_temperature", package.seeall)

local lua_udimo_temperature = {}
local fields = {
	udimoWeatherId = 1,
	temperature = 2,
	description = 3
}
local primaryKey = {
	"udimoWeatherId",
	"temperature"
}
local mlStringKey = {
	description = 1
}
local _configList, _configDict
local configPath = "configs.udimo_temperature_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_udimo_temperature, "configList", _configList)
	rawset(lua_udimo_temperature, "configDict", _configDict)
end

setmetatable(lua_udimo_temperature, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_udimo_temperature.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_udimo_temperature, "configList", nil)
	rawset(lua_udimo_temperature, "configDict", nil)
end

return lua_udimo_temperature
