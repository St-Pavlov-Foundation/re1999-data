-- chunkname: @modules/configs/excel2json/lua_activity109_episode.lua

module("modules.configs.excel2json.lua_activity109_episode", package.seeall)

local lua_activity109_episode = {}
local fields = {
	openDay = 14,
	winCondition = 7,
	id = 2,
	chapterId = 5,
	conditionStr = 10,
	preEpisode = 3,
	mapId = 11,
	extStarCondition = 8,
	storyBefore = 12,
	maxRound = 9,
	storyClear = 13,
	name = 6,
	orderId = 4,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	conditionStr = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity109_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity109_episode, "configList", _configList)
	rawset(lua_activity109_episode, "configDict", _configDict)
end

setmetatable(lua_activity109_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity109_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity109_episode, "configList", nil)
	rawset(lua_activity109_episode, "configDict", nil)
end

return lua_activity109_episode
