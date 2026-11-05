-- chunkname: @modules/configs/excel2json/lua_rouge2_difficulty.lua

module("modules.configs.excel2json.lua_rouge2_difficulty", package.seeall)

local lua_rouge2_difficulty = {}
local fields = {
	title_en = 3,
	preDifficulty = 5,
	scoreReward = 7,
	startView = 8,
	title = 2,
	bg = 4,
	desc = 10,
	monsterDesc = 6,
	balanceLevel = 11,
	initCollections = 9,
	difficulty = 1
}
local primaryKey = {
	"difficulty"
}
local mlStringKey = {
	title_en = 2,
	title = 1,
	monsterDesc = 3,
	desc = 4
}
local _configList, _configDict
local configPath = "configs.rouge2_difficulty_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_difficulty, "configList", _configList)
	rawset(lua_rouge2_difficulty, "configDict", _configDict)
end

setmetatable(lua_rouge2_difficulty, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_difficulty.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_difficulty, "configList", nil)
	rawset(lua_rouge2_difficulty, "configDict", nil)
end

return lua_rouge2_difficulty
