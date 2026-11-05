-- chunkname: @modules/configs/excel2json/lua_activity167_episode.lua

module("modules.configs.excel2json.lua_activity167_episode", package.seeall)

local lua_activity167_episode = {}
local fields = {
	name = 4,
	winCondition = 7,
	id = 2,
	subConditionStr = 9,
	exStarCondition = 10,
	subCondition = 8,
	conditionStr = 11,
	storyBefore = 12,
	storyClear = 13,
	mapId = 6,
	preEpisode = 14,
	cubeList = 15,
	episodeType = 3,
	activityId = 1,
	nameEn = 5
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	conditionStr = 3,
	name = 1,
	subConditionStr = 2
}
local _configList, _configDict
local configPath = "configs.activity167_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity167_episode, "configList", _configList)
	rawset(lua_activity167_episode, "configDict", _configDict)
end

setmetatable(lua_activity167_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity167_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity167_episode, "configList", nil)
	rawset(lua_activity167_episode, "configDict", nil)
end

return lua_activity167_episode
