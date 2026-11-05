-- chunkname: @modules/configs/excel2json/lua_trad_gameroles.lua

module("modules.configs.excel2json.lua_trad_gameroles", package.seeall)

local lua_trad_gameroles = {}
local fields = {
	week = 1,
	gameroles = 2
}
local primaryKey = {
	"week"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.trad_gameroles_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_trad_gameroles, "configList", _configList)
	rawset(lua_trad_gameroles, "configDict", _configDict)
end

setmetatable(lua_trad_gameroles, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_trad_gameroles.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_trad_gameroles, "configList", nil)
	rawset(lua_trad_gameroles, "configDict", nil)
end

return lua_trad_gameroles
