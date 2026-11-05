-- chunkname: @modules/configs/excel2json/lua_activity115_episode.lua

module("modules.configs.excel2json.lua_activity115_episode", package.seeall)

local lua_activity115_episode = {}
local fields = {
	openDay = 11,
	winCondition = 7,
	conditionStr = 9,
	chapterId = 3,
	index = 4,
	preEpisode = 5,
	name = 6,
	extStarCondition = 8,
	tooth = 12,
	mapId = 10,
	unlockSkill = 13,
	maxRound = 14,
	id = 2,
	aniPos = 16,
	activityId = 1,
	trialTemplate = 15
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	conditionStr = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity115_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity115_episode, "configList", _configList)
	rawset(lua_activity115_episode, "configDict", _configDict)
end

setmetatable(lua_activity115_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity115_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity115_episode, "configList", nil)
	rawset(lua_activity115_episode, "configDict", nil)
end

return lua_activity115_episode
