-- chunkname: @modules/configs/excel2json/lua_activity194_game.lua

module("modules.configs.excel2json.lua_activity194_game", package.seeall)

local lua_activity194_game = {}
local fields = {
	maxRoundLimit = 5,
	winCondition = 7,
	extraConditionStr = 10,
	eventGroup = 4,
	winConditionStr = 8,
	startEnergy = 6,
	initialItem = 3,
	extraCondition = 9,
	initialTeam = 2,
	gameId = 1
}
local primaryKey = {
	"gameId"
}
local mlStringKey = {
	extraConditionStr = 2,
	winConditionStr = 1
}
local _configList, _configDict
local configPath = "configs.activity194_game_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity194_game, "configList", _configList)
	rawset(lua_activity194_game, "configDict", _configDict)
end

setmetatable(lua_activity194_game, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity194_game.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity194_game, "configList", nil)
	rawset(lua_activity194_game, "configDict", nil)
end

return lua_activity194_game
