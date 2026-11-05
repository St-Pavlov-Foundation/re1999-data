-- chunkname: @modules/configs/excel2json/lua_activity120_episode.lua

module("modules.configs.excel2json.lua_activity120_episode", package.seeall)

local lua_activity120_episode = {}
local fields = {
	orderId = 4,
	name = 6,
	chapterId = 5,
	inactPaths = 16,
	conditionStr = 11,
	preEpisode = 3,
	storyBefore = 13,
	maxRound = 10,
	activityId = 1,
	openDay = 15,
	storyRepeat = 17,
	mapIds = 12,
	mainConditionStr = 8,
	storyClear = 14,
	extStarCondition = 9,
	mainConfition = 7,
	id = 2
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	mainConditionStr = 2,
	name = 1,
	conditionStr = 3
}
local _configList, _configDict
local configPath = "configs.activity120_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity120_episode, "configList", _configList)
	rawset(lua_activity120_episode, "configDict", _configDict)
end

setmetatable(lua_activity120_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity120_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity120_episode, "configList", nil)
	rawset(lua_activity120_episode, "configDict", nil)
end

return lua_activity120_episode
