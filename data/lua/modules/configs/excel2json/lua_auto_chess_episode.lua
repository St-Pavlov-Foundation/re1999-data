-- chunkname: @modules/configs/excel2json/lua_auto_chess_episode.lua

module("modules.configs.excel2json.lua_auto_chess_episode", package.seeall)

local lua_auto_chess_episode = {}
local fields = {
	preEpisode = 6,
	name = 3,
	firstBounds = 14,
	type = 5,
	winCondition = 11,
	image = 4,
	lostCondition = 12,
	functionOn = 16,
	mallIds = 9,
	maxRound = 10,
	masterLibraryId = 15,
	enemyId = 7,
	id = 2,
	masterId = 13,
	activityId = 1,
	npcEnemyId = 8
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.auto_chess_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_episode, "configList", _configList)
	rawset(lua_auto_chess_episode, "configDict", _configDict)
end

setmetatable(lua_auto_chess_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_episode, "configList", nil)
	rawset(lua_auto_chess_episode, "configDict", nil)
end

return lua_auto_chess_episode
