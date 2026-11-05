-- chunkname: @modules/configs/excel2json/lua_activity124_episode.lua

module("modules.configs.excel2json.lua_activity124_episode", package.seeall)

local lua_activity124_episode = {}
local fields = {
	openDay = 4,
	name = 6,
	firstBonus = 5,
	mapId = 7,
	preEpisode = 3,
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
local configPath = "configs.activity124_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity124_episode, "configList", _configList)
	rawset(lua_activity124_episode, "configDict", _configDict)
end

setmetatable(lua_activity124_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity124_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity124_episode, "configList", nil)
	rawset(lua_activity124_episode, "configDict", nil)
end

return lua_activity124_episode
