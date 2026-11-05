-- chunkname: @modules/configs/excel2json/lua_activity149_episode.lua

module("modules.configs.excel2json.lua_activity149_episode", package.seeall)

local lua_activity149_episode = {}
local fields = {
	order = 4,
	multi = 5,
	firstPassScore = 6,
	id = 1,
	effectCondition = 7,
	activityId = 2,
	episodeId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity149_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity149_episode, "configList", _configList)
	rawset(lua_activity149_episode, "configDict", _configDict)
end

setmetatable(lua_activity149_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity149_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity149_episode, "configList", nil)
	rawset(lua_activity149_episode, "configDict", nil)
end

return lua_activity149_episode
