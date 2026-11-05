-- chunkname: @modules/configs/excel2json/lua_hero_story_score.lua

module("modules.configs.excel2json.lua_hero_story_score", package.seeall)

local lua_hero_story_score = {}
local fields = {
	id = 1,
	wave = 3,
	score = 4,
	storyId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.hero_story_score_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_score, "configList", _configList)
	rawset(lua_hero_story_score, "configDict", _configDict)
end

setmetatable(lua_hero_story_score, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_score.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_score, "configList", nil)
	rawset(lua_hero_story_score, "configDict", nil)
end

return lua_hero_story_score
