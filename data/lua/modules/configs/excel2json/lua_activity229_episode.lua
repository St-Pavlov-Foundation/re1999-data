-- chunkname: @modules/configs/excel2json/lua_activity229_episode.lua

module("modules.configs.excel2json.lua_activity229_episode", package.seeall)

local lua_activity229_episode = {}
local fields = {
	careerPrefer = 4,
	teamRecommend = 5,
	optionalSkills = 6,
	stage = 2,
	activityId = 1,
	episodeId = 3
}
local primaryKey = {
	"activityId",
	"stage"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity229_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity229_episode, "configList", _configList)
	rawset(lua_activity229_episode, "configDict", _configDict)
end

setmetatable(lua_activity229_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity229_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity229_episode, "configList", nil)
	rawset(lua_activity229_episode, "configDict", nil)
end

return lua_activity229_episode
