-- chunkname: @modules/configs/excel2json/lua_fight_monster_display_condition.lua

module("modules.configs.excel2json.lua_fight_monster_display_condition", package.seeall)

local lua_fight_monster_display_condition = {}
local fields = {
	id = 1,
	buffId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_monster_display_condition_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_monster_display_condition, "configList", _configList)
	rawset(lua_fight_monster_display_condition, "configDict", _configDict)
end

setmetatable(lua_fight_monster_display_condition, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_monster_display_condition.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_monster_display_condition, "configList", nil)
	rawset(lua_fight_monster_display_condition, "configDict", nil)
end

return lua_fight_monster_display_condition
