-- chunkname: @modules/configs/excel2json/lua_teamchess_character.lua

module("modules.configs.excel2json.lua_teamchess_character", package.seeall)

local lua_teamchess_character = {}
local fields = {
	activeSkillIds = 8,
	name = 2,
	id = 1,
	specialAttr1 = 10,
	specialAttr2 = 11,
	initPower = 4,
	passiveSkillIds = 9,
	specialAttr3 = 12,
	specialAttr4 = 13,
	hp = 3,
	resPic = 7,
	maxPowerLimit = 6,
	initDiamonds = 5,
	specialAttr5 = 14
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.teamchess_character_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_teamchess_character, "configList", _configList)
	rawset(lua_teamchess_character, "configDict", _configDict)
end

setmetatable(lua_teamchess_character, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_teamchess_character.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_teamchess_character, "configList", nil)
	rawset(lua_teamchess_character, "configDict", nil)
end

return lua_teamchess_character
