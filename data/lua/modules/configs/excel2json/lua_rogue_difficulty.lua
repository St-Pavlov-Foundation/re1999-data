-- chunkname: @modules/configs/excel2json/lua_rogue_difficulty.lua

module("modules.configs.excel2json.lua_rogue_difficulty", package.seeall)

local lua_rogue_difficulty = {}
local fields = {
	effect1 = 15,
	initRoom = 5,
	effectDesc1 = 14,
	scoreAdd = 11,
	effect3 = 19,
	title = 2,
	initHeroCount = 12,
	effect2 = 17,
	effectDesc3 = 18,
	initCurrency = 6,
	initHeart = 7,
	difficulty = 1,
	preDifficulty = 3,
	attrAdd = 10,
	rule = 8,
	effectDesc2 = 16,
	showDifficulty = 9,
	retries = 13,
	initLevel = 4
}
local primaryKey = {
	"difficulty"
}
local mlStringKey = {
	effectDesc1 = 2,
	title = 1,
	effectDesc3 = 4,
	effectDesc2 = 3
}
local _configList, _configDict
local configPath = "configs.rogue_difficulty_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_difficulty, "configList", _configList)
	rawset(lua_rogue_difficulty, "configDict", _configDict)
end

setmetatable(lua_rogue_difficulty, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_difficulty.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_difficulty, "configList", nil)
	rawset(lua_rogue_difficulty, "configDict", nil)
end

return lua_rogue_difficulty
