-- chunkname: @modules/configs/excel2json/lua_partygame_carddrop_drop.lua

module("modules.configs.excel2json.lua_partygame_carddrop_drop", package.seeall)

local lua_partygame_carddrop_drop = {}
local fields = {
	chooseMode7 = 24,
	round = 3,
	chooseMode1 = 6,
	dropGroup6 = 20,
	maxHpUp1 = 7,
	dropGroup3 = 11,
	maxHpUp7 = 25,
	playerNum = 2,
	chooseMode3 = 12,
	maxHpUp6 = 22,
	chooseMode6 = 21,
	chooseMode8 = 27,
	chooseMode5 = 18,
	dropGroup7 = 23,
	dropGroup1 = 5,
	dropGroup4 = 14,
	maxHpUp4 = 16,
	chooseMode2 = 9,
	groupType = 4,
	maxHpUp2 = 10,
	chooseMode4 = 15,
	dropGroup8 = 26,
	dropGroup5 = 17,
	maxHpUp5 = 19,
	dropGroup2 = 8,
	id = 1,
	maxHpUp3 = 13,
	maxHpUp8 = 28
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.partygame_carddrop_drop_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_carddrop_drop, "configList", _configList)
	rawset(lua_partygame_carddrop_drop, "configDict", _configDict)
end

setmetatable(lua_partygame_carddrop_drop, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_carddrop_drop.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_carddrop_drop, "configList", nil)
	rawset(lua_partygame_carddrop_drop, "configDict", nil)
end

return lua_partygame_carddrop_drop
