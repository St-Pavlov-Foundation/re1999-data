-- chunkname: @modules/configs/excel2json/lua_story_hero_to_character.lua

module("modules.configs.excel2json.lua_story_hero_to_character", package.seeall)

local lua_story_hero_to_character = {}
local fields = {
	heroIndex = 1,
	heroId = 2
}
local primaryKey = {
	"heroIndex"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.story_hero_to_character_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_story_hero_to_character, "configList", _configList)
	rawset(lua_story_hero_to_character, "configDict", _configDict)
end

setmetatable(lua_story_hero_to_character, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_story_hero_to_character.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_story_hero_to_character, "configList", nil)
	rawset(lua_story_hero_to_character, "configDict", nil)
end

return lua_story_hero_to_character
