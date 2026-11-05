-- chunkname: @modules/configs/excel2json/lua_activity220_episode.lua

module("modules.configs.excel2json.lua_activity220_episode", package.seeall)

local lua_activity220_episode = {}
local fields = {
	storyBefore = 6,
	name = 5,
	preEpisodeBranchId = 4,
	type = 11,
	storyClear = 9,
	episodeId = 2,
	disactiveEpisodeIds = 10,
	preEpisodeId = 3,
	fightEpisodeId = 7,
	activityId = 1,
	gameId = 8
}
local primaryKey = {
	"activityId",
	"episodeId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity220_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_episode, "configList", _configList)
	rawset(lua_activity220_episode, "configDict", _configDict)
end

setmetatable(lua_activity220_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_episode, "configList", nil)
	rawset(lua_activity220_episode, "configDict", nil)
end

return lua_activity220_episode
