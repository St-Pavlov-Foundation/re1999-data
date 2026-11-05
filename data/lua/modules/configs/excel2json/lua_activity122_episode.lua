-- chunkname: @modules/configs/excel2json/lua_activity122_episode.lua

module("modules.configs.excel2json.lua_activity122_episode", package.seeall)

local lua_activity122_episode = {}
local fields = {
	openDay = 15,
	name = 6,
	conditionStr = 9,
	chapterId = 5,
	extStarCondition = 10,
	preEpisode = 3,
	extConditionStr = 11,
	starCondition = 8,
	mapIds = 12,
	storyBefore = 13,
	hp = 7,
	storyClear = 14,
	orderId = 4,
	id = 2,
	activityId = 1,
	storyRepeat = 16
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	conditionStr = 2,
	name = 1,
	extConditionStr = 3
}
local _configList, _configDict
local configPath = "configs.activity122_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity122_episode, "configList", _configList)
	rawset(lua_activity122_episode, "configDict", _configDict)
end

setmetatable(lua_activity122_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity122_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity122_episode, "configList", nil)
	rawset(lua_activity122_episode, "configDict", nil)
end

return lua_activity122_episode
