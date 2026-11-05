-- chunkname: @modules/configs/excel2json/lua_assassin_stealth_map.lua

module("modules.configs.excel2json.lua_assassin_stealth_map", package.seeall)

local lua_assassin_stealth_map = {}
local fields = {
	mission = 4,
	player = 5,
	id = 1,
	title = 2,
	forbidScaleGuide = 6,
	born = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 1
}
local _configList, _configDict
local configPath = "configs.assassin_stealth_map_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_stealth_map, "configList", _configList)
	rawset(lua_assassin_stealth_map, "configDict", _configDict)
end

setmetatable(lua_assassin_stealth_map, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_stealth_map.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_stealth_map, "configList", nil)
	rawset(lua_assassin_stealth_map, "configDict", nil)
end

return lua_assassin_stealth_map
