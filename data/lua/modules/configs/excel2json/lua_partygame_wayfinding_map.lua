-- chunkname: @modules/configs/excel2json/lua_partygame_wayfinding_map.lua

module("modules.configs.excel2json.lua_partygame_wayfinding_map", package.seeall)

local lua_partygame_wayfinding_map = {}
local fields = {
	id = 1,
	mapData = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.partygame_wayfinding_map_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_wayfinding_map, "configList", _configList)
	rawset(lua_partygame_wayfinding_map, "configDict", _configDict)
end

setmetatable(lua_partygame_wayfinding_map, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_wayfinding_map.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_wayfinding_map, "configList", nil)
	rawset(lua_partygame_wayfinding_map, "configDict", nil)
end

return lua_partygame_wayfinding_map
