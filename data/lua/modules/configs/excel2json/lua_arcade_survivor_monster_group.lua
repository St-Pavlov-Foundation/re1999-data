-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_monster_group.lua

module("modules.configs.excel2json.lua_arcade_survivor_monster_group", package.seeall)

local lua_arcade_survivor_monster_group = {}
local fields = {
	eliteMonsters = 4,
	eliteWeight = 5,
	id = 1,
	normalWeight = 3,
	normalMonsters = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_survivor_monster_group_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_monster_group, "configList", _configList)
	rawset(lua_arcade_survivor_monster_group, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_monster_group, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_monster_group.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_monster_group, "configList", nil)
	rawset(lua_arcade_survivor_monster_group, "configDict", nil)
end

return lua_arcade_survivor_monster_group
