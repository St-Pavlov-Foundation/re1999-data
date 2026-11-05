-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_level.lua

module("modules.configs.excel2json.lua_arcade_survivor_level", package.seeall)

local lua_arcade_survivor_level = {}
local fields = {
	addDiamond = 10,
	name = 2,
	addCassette = 11,
	hpMul = 7,
	title = 3,
	atkMul = 8,
	shopId = 5,
	ruleId = 4,
	monsterGroupPool = 9,
	id = 1,
	priceMul = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.arcade_survivor_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_level, "configList", _configList)
	rawset(lua_arcade_survivor_level, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_level, "configList", nil)
	rawset(lua_arcade_survivor_level, "configDict", nil)
end

return lua_arcade_survivor_level
