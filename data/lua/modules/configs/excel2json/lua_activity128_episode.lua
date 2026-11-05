-- chunkname: @modules/configs/excel2json/lua_activity128_episode.lua

module("modules.configs.excel2json.lua_activity128_episode", package.seeall)

local lua_activity128_episode = {}
local fields = {
	openDay = 9,
	enhanceRole = 5,
	recommendLevelDesc = 8,
	type = 4,
	episodeId = 6,
	evaluate = 10,
	desc = 7,
	stage = 2,
	activityId = 1,
	layer = 3
}
local primaryKey = {
	"activityId",
	"stage",
	"layer"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity128_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity128_episode, "configList", _configList)
	rawset(lua_activity128_episode, "configDict", _configDict)
end

setmetatable(lua_activity128_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity128_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity128_episode, "configList", nil)
	rawset(lua_activity128_episode, "configDict", nil)
end

return lua_activity128_episode
