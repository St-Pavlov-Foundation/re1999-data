-- chunkname: @modules/configs/excel2json/lua_rouge_difficulty.lua

module("modules.configs.excel2json.lua_rouge_difficulty", package.seeall)

local lua_rouge_difficulty = {}
local fields = {
	title_en = 5,
	preDifficulty = 6,
	scoreReward = 8,
	startView = 9,
	season = 1,
	title = 4,
	initEffects = 11,
	desc = 12,
	monsterDesc = 7,
	balanceLevel = 13,
	initCollections = 10,
	version = 3,
	difficulty = 2
}
local primaryKey = {
	"season",
	"difficulty"
}
local mlStringKey = {
	title_en = 2,
	title = 1,
	monsterDesc = 3,
	desc = 4
}
local _configList, _configDict
local configPath = "configs.rouge_difficulty_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_difficulty, "configList", _configList)
	rawset(lua_rouge_difficulty, "configDict", _configDict)
end

setmetatable(lua_rouge_difficulty, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_difficulty.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_difficulty, "configList", nil)
	rawset(lua_rouge_difficulty, "configDict", nil)
end

return lua_rouge_difficulty
