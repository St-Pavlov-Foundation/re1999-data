-- chunkname: @modules/configs/excel2json/lua_assassin_stealth_refresh.lua

module("modules.configs.excel2json.lua_assassin_stealth_refresh", package.seeall)

local lua_assassin_stealth_refresh = {}
local fields = {
	id = 1,
	position1 = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.assassin_stealth_refresh_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_stealth_refresh, "configList", _configList)
	rawset(lua_assassin_stealth_refresh, "configDict", _configDict)
end

setmetatable(lua_assassin_stealth_refresh, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_stealth_refresh.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_stealth_refresh, "configList", nil)
	rawset(lua_assassin_stealth_refresh, "configDict", nil)
end

return lua_assassin_stealth_refresh
