-- chunkname: @modules/configs/excel2json/lua_activity144_episode.lua

module("modules.configs.excel2json.lua_activity144_episode", package.seeall)

local lua_activity144_episode = {}
local fields = {
	bgPath = 7,
	name = 4,
	picture = 6,
	nameen = 10,
	taskId = 8,
	preEpisode = 3,
	unlockDesc = 9,
	episodeId = 2,
	desc = 5,
	storyBefore = 11,
	storyClear = 12,
	showTargets = 13,
	bonus = 15,
	activityId = 1,
	showBonus = 14
}
local primaryKey = {
	"activityId",
	"episodeId"
}
local mlStringKey = {
	unlockDesc = 3,
	name = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.activity144_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity144_episode, "configList", _configList)
	rawset(lua_activity144_episode, "configDict", _configDict)
end

setmetatable(lua_activity144_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity144_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity144_episode, "configList", nil)
	rawset(lua_activity144_episode, "configDict", nil)
end

return lua_activity144_episode
