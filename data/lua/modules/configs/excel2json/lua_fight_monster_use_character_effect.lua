-- chunkname: @modules/configs/excel2json/lua_fight_monster_use_character_effect.lua

module("modules.configs.excel2json.lua_fight_monster_use_character_effect", package.seeall)

local lua_fight_monster_use_character_effect = {}
local fields = {
	id = 1,
	characterId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_monster_use_character_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_monster_use_character_effect, "configList", _configList)
	rawset(lua_fight_monster_use_character_effect, "configDict", _configDict)
end

setmetatable(lua_fight_monster_use_character_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_monster_use_character_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_monster_use_character_effect, "configList", nil)
	rawset(lua_fight_monster_use_character_effect, "configDict", nil)
end

return lua_fight_monster_use_character_effect
