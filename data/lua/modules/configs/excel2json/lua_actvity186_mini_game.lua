-- chunkname: @modules/configs/excel2json/lua_actvity186_mini_game.lua

module("modules.configs.excel2json.lua_actvity186_mini_game", package.seeall)

local lua_actvity186_mini_game = {}
local fields = {
	gameType2Prob = 6,
	expireSeconds = 7,
	triggerConditionParams = 4,
	triggerConditionType = 3,
	id = 2,
	activityId = 1,
	conditionStage = 5
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.actvity186_mini_game_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_actvity186_mini_game, "configList", _configList)
	rawset(lua_actvity186_mini_game, "configDict", _configDict)
end

setmetatable(lua_actvity186_mini_game, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_actvity186_mini_game.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_actvity186_mini_game, "configList", nil)
	rawset(lua_actvity186_mini_game, "configDict", nil)
end

return lua_actvity186_mini_game
