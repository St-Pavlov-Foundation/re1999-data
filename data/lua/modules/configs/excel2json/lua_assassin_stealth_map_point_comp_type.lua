-- chunkname: @modules/configs/excel2json/lua_assassin_stealth_map_point_comp_type.lua

module("modules.configs.excel2json.lua_assassin_stealth_map_point_comp_type", package.seeall)

local lua_assassin_stealth_map_point_comp_type = {}
local fields = {
	id = 1,
	name = 2,
	icon = 3,
	smallIcon = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.assassin_stealth_map_point_comp_type_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_stealth_map_point_comp_type, "configList", _configList)
	rawset(lua_assassin_stealth_map_point_comp_type, "configDict", _configDict)
end

setmetatable(lua_assassin_stealth_map_point_comp_type, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_stealth_map_point_comp_type.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_stealth_map_point_comp_type, "configList", nil)
	rawset(lua_assassin_stealth_map_point_comp_type, "configDict", nil)
end

return lua_assassin_stealth_map_point_comp_type
