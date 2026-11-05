-- chunkname: @modules/configs/excel2json/lua_tower_v3a7_map.lua

module("modules.configs.excel2json.lua_tower_v3a7_map", package.seeall)

local lua_tower_v3a7_map = {}
local fields = {
	map = 8,
	desc2 = 4,
	time = 7,
	desc1 = 3,
	title = 2,
	story = 9,
	quest = 6,
	id = 1,
	desc3 = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc2 = 3,
	title = 1,
	desc3 = 4,
	desc1 = 2
}
local _configList, _configDict
local configPath = "configs.tower_v3a7_map_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_v3a7_map, "configList", _configList)
	rawset(lua_tower_v3a7_map, "configDict", _configDict)
end

setmetatable(lua_tower_v3a7_map, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_v3a7_map.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_v3a7_map, "configList", nil)
	rawset(lua_tower_v3a7_map, "configDict", nil)
end

return lua_tower_v3a7_map
