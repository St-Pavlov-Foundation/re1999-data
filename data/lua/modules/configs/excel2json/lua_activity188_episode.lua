-- chunkname: @modules/configs/excel2json/lua_activity188_episode.lua

module("modules.configs.excel2json.lua_activity188_episode", package.seeall)

local lua_activity188_episode = {}
local fields = {
	name = 4,
	preEpisodeId = 3,
	gameId = 6,
	storyId = 5,
	resource = 7,
	activityId = 1,
	episodeId = 2
}
local primaryKey = {
	"activityId",
	"episodeId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity188_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity188_episode, "configList", _configList)
	rawset(lua_activity188_episode, "configDict", _configDict)
end

setmetatable(lua_activity188_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity188_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity188_episode, "configList", nil)
	rawset(lua_activity188_episode, "configDict", nil)
end

return lua_activity188_episode
