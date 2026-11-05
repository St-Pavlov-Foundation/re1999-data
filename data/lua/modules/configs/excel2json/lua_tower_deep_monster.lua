-- chunkname: @modules/configs/excel2json/lua_tower_deep_monster.lua

module("modules.configs.excel2json.lua_tower_deep_monster", package.seeall)

local lua_tower_deep_monster = {}
local fields = {
	id = 1,
	bossId = 4,
	startHighDeep = 2,
	endHighDeep = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.tower_deep_monster_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_deep_monster, "configList", _configList)
	rawset(lua_tower_deep_monster, "configDict", _configDict)
end

setmetatable(lua_tower_deep_monster, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_deep_monster.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_deep_monster, "configList", nil)
	rawset(lua_tower_deep_monster, "configDict", nil)
end

return lua_tower_deep_monster
