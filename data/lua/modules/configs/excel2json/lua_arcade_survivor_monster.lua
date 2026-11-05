-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_monster.lua

module("modules.configs.excel2json.lua_arcade_survivor_monster", package.seeall)

local lua_arcade_survivor_monster = {}
local fields = {
	resName = 4,
	name = 2,
	dialogGroupIds = 6,
	type = 8,
	dropCoin = 11,
	iconOffset = 18,
	bgmId = 22,
	desc = 3,
	iconScale2 = 19,
	iconOffset2 = 20,
	hpCap = 9,
	atk = 10,
	maxCount = 12,
	icon = 5,
	skillIds = 14,
	hpPos = 21,
	treeIds = 13,
	posOffset = 16,
	iconScale = 17,
	id = 1,
	shape = 7,
	scale = 15
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.arcade_survivor_monster_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_monster, "configList", _configList)
	rawset(lua_arcade_survivor_monster, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_monster, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_monster.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_monster, "configList", nil)
	rawset(lua_arcade_survivor_monster, "configDict", nil)
end

return lua_arcade_survivor_monster
