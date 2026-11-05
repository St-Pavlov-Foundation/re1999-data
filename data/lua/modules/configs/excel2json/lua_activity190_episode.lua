-- chunkname: @modules/configs/excel2json/lua_activity190_episode.lua

module("modules.configs.excel2json.lua_activity190_episode", package.seeall)

local lua_activity190_episode = {}
local fields = {
	eliminateLevelId = 9,
	name = 5,
	preEpisodeBranchId = 4,
	type = 10,
	storyBefore = 6,
	storyClear = 8,
	maxRound = 12,
	episodeId = 2,
	masterId = 13,
	preEpisodeId = 3,
	enemyId = 11,
	activityId = 1,
	gameId = 7
}
local primaryKey = {
	"activityId",
	"episodeId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity190_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity190_episode, "configList", _configList)
	rawset(lua_activity190_episode, "configDict", _configDict)
end

setmetatable(lua_activity190_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity190_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity190_episode, "configList", nil)
	rawset(lua_activity190_episode, "configDict", nil)
end

return lua_activity190_episode
