-- chunkname: @modules/configs/excel2json/lua_device_power.lua

module("modules.configs.excel2json.lua_device_power", package.seeall)

local lua_device_power = {}
local fields = {
	powerIcon = 3,
	powerType = 1,
	powerNum = 2
}
local primaryKey = {
	"powerType",
	"powerNum"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.device_power_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_device_power, "configList", _configList)
	rawset(lua_device_power, "configDict", _configDict)
end

setmetatable(lua_device_power, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_device_power.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_device_power, "configList", nil)
	rawset(lua_device_power, "configDict", nil)
end

return lua_device_power
