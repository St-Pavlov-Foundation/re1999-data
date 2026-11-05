-- chunkname: @modules/configs/excel2json/lua_hero_story_ending.lua

module("modules.configs.excel2json.lua_hero_story_ending", package.seeall)

local lua_hero_story_ending = {}
local fields = {
	id = 1,
	name = 4,
	storyStep = 3,
	storyId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.hero_story_ending_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_ending, "configList", _configList)
	rawset(lua_hero_story_ending, "configDict", _configDict)
end

setmetatable(lua_hero_story_ending, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_ending.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_ending, "configList", nil)
	rawset(lua_hero_story_ending, "configDict", nil)
end

return lua_hero_story_ending
