-- chunkname: @modules/configs/excel2json/lua_243_episode.lua

module("modules.configs.excel2json.lua_243_episode", package.seeall)

local lua_243_episode = {}
local fields = {
	name = 5,
	preEpisodeId = 4,
	gameId = 6,
	clearBonus = 7,
	episodeType = 2,
	activityId = 3,
	episodeId = 1
}
local primaryKey = {
	"episodeId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.243_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_243_episode, "configList", _configList)
	rawset(lua_243_episode, "configDict", _configDict)
end

setmetatable(lua_243_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_243_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_243_episode, "configList", nil)
	rawset(lua_243_episode, "configDict", nil)
end

return lua_243_episode
