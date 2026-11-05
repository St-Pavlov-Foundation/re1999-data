-- chunkname: @modules/configs/excel2json/lua_arcade_monster.lua

module("modules.configs.excel2json.lua_arcade_monster", package.seeall)

local lua_arcade_monster = {}
local fields = {
	defense = 8,
	name = 2,
	drop = 12,
	iconScale = 19,
	iconOffset = 20,
	iconScale2 = 21,
	iconOffset2 = 22,
	desc = 3,
	race = 5,
	moveType = 10,
	hpCap = 7,
	hasCorpse = 23,
	attack = 6,
	icon = 18,
	resPath = 13,
	skillIds = 9,
	illustrationShow = 11,
	hpPos = 16,
	posOffset = 15,
	category = 17,
	id = 1,
	shape = 4,
	scale = 14
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.arcade_monster_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_monster, "configList", _configList)
	rawset(lua_arcade_monster, "configDict", _configDict)
end

setmetatable(lua_arcade_monster, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_monster.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_monster, "configList", nil)
	rawset(lua_arcade_monster, "configDict", nil)
end

return lua_arcade_monster
