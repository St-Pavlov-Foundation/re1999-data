-- chunkname: @modules/configs/excel2json/lua_activity188_game.lua

module("modules.configs.excel2json.lua_activity188_game", package.seeall)

local lua_activity188_game = {}
local fields = {
	bossAbilityPool = 10,
	activityId = 1,
	count = 13,
	portrait = 19,
	abilityIds = 5,
	passRound = 18,
	bossCount = 14,
	bossAbilityIds = 6,
	bossHurt = 16,
	abilityPool = 9,
	bossHp = 12,
	rowColumn = 7,
	round = 3,
	hurt = 15,
	hp = 11,
	cardBuild = 8,
	id = 2,
	difficult = 17,
	readNum = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity188_game_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity188_game, "configList", _configList)
	rawset(lua_activity188_game, "configDict", _configDict)
end

setmetatable(lua_activity188_game, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity188_game.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity188_game, "configList", nil)
	rawset(lua_activity188_game, "configDict", nil)
end

return lua_activity188_game
