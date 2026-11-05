-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_level_rule.lua

module("modules.configs.excel2json.lua_arcade_survivor_level_rule", package.seeall)

local lua_arcade_survivor_level_rule = {}
local fields = {
	maxAddEliteCount = 13,
	startPos = 6,
	boardSize = 2,
	tileRes = 4,
	bossPos = 11,
	tileSize = 5,
	maxAddCount = 12,
	waveExtraAdd = 17,
	waveInterval = 15,
	eliteWeight = 9,
	bossIds = 10,
	viewSize = 3,
	waveCount = 14,
	initMonsterCount = 7,
	id = 1,
	normalWeight = 8,
	waveAdd = 16
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_survivor_level_rule_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_level_rule, "configList", _configList)
	rawset(lua_arcade_survivor_level_rule, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_level_rule, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_level_rule.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_level_rule, "configList", nil)
	rawset(lua_arcade_survivor_level_rule, "configDict", nil)
end

return lua_arcade_survivor_level_rule
