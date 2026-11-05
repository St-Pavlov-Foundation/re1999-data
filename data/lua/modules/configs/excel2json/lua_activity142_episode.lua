-- chunkname: @modules/configs/excel2json/lua_activity142_episode.lua

module("modules.configs.excel2json.lua_activity142_episode", package.seeall)

local lua_activity142_episode = {}
local fields = {
	activityId = 1,
	name = 6,
	id = 2,
	chapterId = 5,
	conditionStr = 12,
	preEpisode = 3,
	normalSprite = 7,
	storyClear = 17,
	maxRound = 13,
	storyBefore = 16,
	openDay = 18,
	storyRepeat = 19,
	mapIds = 14,
	mainConditionStr = 10,
	pickUpObjIds = 15,
	extStarCondition = 11,
	mainConfition = 9,
	orderId = 4,
	lockSprite = 8
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
local configPath = "configs.activity142_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity142_episode, "configList", _configList)
	rawset(lua_activity142_episode, "configDict", _configDict)
end

setmetatable(lua_activity142_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity142_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity142_episode, "configList", nil)
	rawset(lua_activity142_episode, "configDict", nil)
end

return lua_activity142_episode
