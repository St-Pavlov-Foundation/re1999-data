-- chunkname: @modules/configs/excel2json/lua_activity179_instrument.lua

module("modules.configs.excel2json.lua_activity179_instrument", package.seeall)

local lua_activity179_instrument = {}
local fields = {
	id = 1,
	name = 2,
	switch = 3,
	icon = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity179_instrument_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity179_instrument, "configList", _configList)
	rawset(lua_activity179_instrument, "configDict", _configDict)
end

setmetatable(lua_activity179_instrument, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity179_instrument.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity179_instrument, "configList", nil)
	rawset(lua_activity179_instrument, "configDict", nil)
end

return lua_activity179_instrument
