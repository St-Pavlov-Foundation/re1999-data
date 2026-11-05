-- chunkname: @modules/configs/excel2json/lua_activity234_gameroles.lua

module("modules.configs.excel2json.lua_activity234_gameroles", package.seeall)

local lua_activity234_gameroles = {}
local fields = {
	week = 1,
	gameroles = 2
}
local primaryKey = {
	"week"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity234_gameroles_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity234_gameroles, "configList", _configList)
	rawset(lua_activity234_gameroles, "configDict", _configDict)
end

setmetatable(lua_activity234_gameroles, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity234_gameroles.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity234_gameroles, "configList", nil)
	rawset(lua_activity234_gameroles, "configDict", nil)
end

return lua_activity234_gameroles
