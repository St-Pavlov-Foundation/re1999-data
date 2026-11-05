-- chunkname: @modules/configs/excel2json/lua_activity179_episode.lua

module("modules.configs.excel2json.lua_activity179_episode", package.seeall)

local lua_activity179_episode = {}
local fields = {
	name_En = 7,
	name = 6,
	orderId = 5,
	id = 2,
	storyAfter = 10,
	preEpisode = 3,
	beatId = 8,
	storyBefore = 9,
	episodeType = 4,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity179_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity179_episode, "configList", _configList)
	rawset(lua_activity179_episode, "configDict", _configDict)
end

setmetatable(lua_activity179_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity179_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity179_episode, "configList", nil)
	rawset(lua_activity179_episode, "configDict", nil)
end

return lua_activity179_episode
