-- chunkname: @modules/configs/excel2json/lua_hero_story_mode_fugaoren_story.lua

module("modules.configs.excel2json.lua_hero_story_mode_fugaoren_story", package.seeall)

local lua_hero_story_mode_fugaoren_story = {}
local fields = {
	baseId = 2,
	id = 1,
	preId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.hero_story_mode_fugaoren_story_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_mode_fugaoren_story, "configList", _configList)
	rawset(lua_hero_story_mode_fugaoren_story, "configDict", _configDict)
end

setmetatable(lua_hero_story_mode_fugaoren_story, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_mode_fugaoren_story.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_mode_fugaoren_story, "configList", nil)
	rawset(lua_hero_story_mode_fugaoren_story, "configDict", nil)
end

return lua_hero_story_mode_fugaoren_story
