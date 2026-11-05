-- chunkname: @modules/configs/excel2json/lua_activity130_episode.lua

module("modules.configs.excel2json.lua_activity130_episode", package.seeall)

local lua_activity130_episode = {}
local fields = {
	lvscene = 11,
	name = 6,
	desc = 7,
	mapId = 5,
	afterStoryId = 9,
	elements = 10,
	beforeStoryId = 8,
	episodeId = 2,
	scenes = 12,
	preEpisodeId = 4,
	winCondition = 13,
	conditionStr = 14,
	episodetag = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"episodeId"
}
local mlStringKey = {
	conditionStr = 3,
	name = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.activity130_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity130_episode, "configList", _configList)
	rawset(lua_activity130_episode, "configDict", _configDict)
end

setmetatable(lua_activity130_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity130_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity130_episode, "configList", nil)
	rawset(lua_activity130_episode, "configDict", nil)
end

return lua_activity130_episode
