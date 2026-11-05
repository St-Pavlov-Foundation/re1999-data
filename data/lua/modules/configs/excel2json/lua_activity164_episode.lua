-- chunkname: @modules/configs/excel2json/lua_activity164_episode.lua

module("modules.configs.excel2json.lua_activity164_episode", package.seeall)

local lua_activity164_episode = {}
local fields = {
	activityId = 1,
	name = 3,
	preEpisode = 9,
	mapIds = 4,
	mainConditionStr = 5,
	storyClear = 8,
	storyRepeat = 10,
	mapName = 6,
	id = 2,
	storyBefore = 7
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	mainConditionStr = 2,
	name = 1,
	mapName = 3
}
local _configList, _configDict
local configPath = "configs.activity164_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity164_episode, "configList", _configList)
	rawset(lua_activity164_episode, "configDict", _configDict)
end

setmetatable(lua_activity164_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity164_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity164_episode, "configList", nil)
	rawset(lua_activity164_episode, "configDict", nil)
end

return lua_activity164_episode
