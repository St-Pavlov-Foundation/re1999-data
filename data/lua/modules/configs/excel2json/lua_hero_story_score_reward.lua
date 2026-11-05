-- chunkname: @modules/configs/excel2json/lua_hero_story_score_reward.lua

module("modules.configs.excel2json.lua_hero_story_score_reward", package.seeall)

local lua_hero_story_score_reward = {}
local fields = {
	score = 3,
	storyId = 2,
	id = 1,
	keyReward = 5,
	bonus = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.hero_story_score_reward_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_story_score_reward, "configList", _configList)
	rawset(lua_hero_story_score_reward, "configDict", _configDict)
end

setmetatable(lua_hero_story_score_reward, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_story_score_reward.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_story_score_reward, "configList", nil)
	rawset(lua_hero_story_score_reward, "configDict", nil)
end

return lua_hero_story_score_reward
