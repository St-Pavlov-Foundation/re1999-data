-- chunkname: @modules/configs/excel2json/lua_war_chess_episode.lua

module("modules.configs.excel2json.lua_war_chess_episode", package.seeall)

local lua_war_chess_episode = {}
local fields = {
	unlockSlotIds = 13,
	failCondition = 10,
	unlockChessSoldierIds = 12,
	presetSoldier = 18,
	extraWinConditionDesc = 7,
	presetCharacter = 17,
	preset = 16,
	winCondition = 6,
	strongHoldIds = 4,
	maxRound = 3,
	extraWinCondition = 8,
	unlockCharacterIds = 11,
	chessScene = 15,
	dialogueId = 19,
	eliminateScene = 14,
	failConditionDesc = 9,
	enemyId = 2,
	id = 1,
	winConditionDesc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	extraWinConditionDesc = 2,
	winConditionDesc = 1,
	failConditionDesc = 3
}
local _configList, _configDict
local configPath = "configs.war_chess_episode_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_war_chess_episode, "configList", _configList)
	rawset(lua_war_chess_episode, "configDict", _configDict)
end

setmetatable(lua_war_chess_episode, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_war_chess_episode.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_war_chess_episode, "configList", nil)
	rawset(lua_war_chess_episode, "configDict", nil)
end

return lua_war_chess_episode
