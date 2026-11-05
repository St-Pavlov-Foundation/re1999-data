-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_difficulty.lua

module("modules.configs.excel2json.lua_arcade_survivor_difficulty", package.seeall)

local lua_arcade_survivor_difficulty = {}
local fields = {
	monsterAddSkills = 5,
	diamondMul = 9,
	startCoin = 12,
	hpMul = 7,
	playerTurnTime = 13,
	stageIds = 2,
	atkMul = 8,
	desc = 3,
	addSkills = 4,
	cassetteMul = 10,
	startShopRefresh = 11,
	id = 1,
	priceMul = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.arcade_survivor_difficulty_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_difficulty, "configList", _configList)
	rawset(lua_arcade_survivor_difficulty, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_difficulty, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_difficulty.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_difficulty, "configList", nil)
	rawset(lua_arcade_survivor_difficulty, "configDict", nil)
end

return lua_arcade_survivor_difficulty
