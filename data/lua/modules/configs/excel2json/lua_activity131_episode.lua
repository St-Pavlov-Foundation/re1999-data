-- chunkname: @modules/configs/excel2json/lua_activity131_episode.lua

module("modules.configs.excel2json.lua_activity131_episode", package.seeall)

local lua_activity131_episode = {}
local fields = {
	beforeStoryId = 8,
	name = 6,
	desc = 7,
	mapId = 5,
	afterStoryId = 9,
	elements = 10,
	scenes = 11,
	episodeId = 2,
	preEpisodeId = 4,
	episodetag = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"episodeId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity131_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity131_episode, "configList", _configList)
	rawset(lua_activity131_episode, "configDict", _configDict)
end

setmetatable(lua_activity131_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity131_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity131_episode, "configList", nil)
	rawset(lua_activity131_episode, "configDict", nil)
end

return lua_activity131_episode
