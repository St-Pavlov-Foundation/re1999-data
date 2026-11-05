-- chunkname: @modules/configs/excel2json/lua_activity192_episode.lua

module("modules.configs.excel2json.lua_activity192_episode", package.seeall)

local lua_activity192_episode = {}
local fields = {
	storyBefore = 7,
	name = 6,
	preEpisodeBranchId = 4,
	isExtra = 9,
	storyClear = 8,
	episodeId = 2,
	preEpisodeId = 3,
	activityId = 1,
	gameId = 5
}
local primaryKey = {
	"activityId",
	"episodeId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity192_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity192_episode, "configList", _configList)
	rawset(lua_activity192_episode, "configDict", _configDict)
end

setmetatable(lua_activity192_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity192_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity192_episode, "configList", nil)
	rawset(lua_activity192_episode, "configDict", nil)
end

return lua_activity192_episode
