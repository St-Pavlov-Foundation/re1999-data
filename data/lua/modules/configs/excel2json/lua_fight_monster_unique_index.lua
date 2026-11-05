-- chunkname: @modules/configs/excel2json/lua_fight_monster_unique_index.lua

module("modules.configs.excel2json.lua_fight_monster_unique_index", package.seeall)

local lua_fight_monster_unique_index = {}
local fields = {
	id = 1,
	index = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_monster_unique_index_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_monster_unique_index, "configList", _configList)
	rawset(lua_fight_monster_unique_index, "configDict", _configDict)
end

setmetatable(lua_fight_monster_unique_index, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_monster_unique_index.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_monster_unique_index, "configList", nil)
	rawset(lua_fight_monster_unique_index, "configDict", nil)
end

return lua_fight_monster_unique_index
