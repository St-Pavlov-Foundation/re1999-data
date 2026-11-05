-- chunkname: @modules/configs/excel2json/lua_activity225_red_envelope_rain_pool.lua

module("modules.configs.excel2json.lua_activity225_red_envelope_rain_pool", package.seeall)

local lua_activity225_red_envelope_rain_pool = {}
local fields = {
	source = 1
}
local primaryKey = {}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity225_red_envelope_rain_pool_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity225_red_envelope_rain_pool, "configList", _configList)
	rawset(lua_activity225_red_envelope_rain_pool, "configDict", _configDict)
end

setmetatable(lua_activity225_red_envelope_rain_pool, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity225_red_envelope_rain_pool.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity225_red_envelope_rain_pool, "configList", nil)
	rawset(lua_activity225_red_envelope_rain_pool, "configDict", nil)
end

return lua_activity225_red_envelope_rain_pool
