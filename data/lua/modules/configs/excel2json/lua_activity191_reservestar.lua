-- chunkname: @modules/configs/excel2json/lua_activity191_reservestar.lua

module("modules.configs.excel2json.lua_activity191_reservestar", package.seeall)

local lua_activity191_reservestar = {}
local fields = {
	id = 1,
	attribute = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity191_reservestar_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity191_reservestar, "configList", _configList)
	rawset(lua_activity191_reservestar, "configDict", _configDict)
end

setmetatable(lua_activity191_reservestar, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity191_reservestar.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity191_reservestar, "configList", nil)
	rawset(lua_activity191_reservestar, "configDict", nil)
end

return lua_activity191_reservestar
