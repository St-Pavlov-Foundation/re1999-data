-- chunkname: @modules/configs/excel2json/lua_teamchess_enemy.lua

module("modules.configs.excel2json.lua_teamchess_enemy", package.seeall)

local lua_teamchess_enemy = {}
local fields = {
	name = 2,
	passiveSkillIds = 7,
	specialAttr1 = 9,
	behaviorId = 8,
	specialAttr2 = 10,
	headImg = 4,
	specialAttr3 = 11,
	specialAttr5 = 13,
	specialAttr4 = 12,
	hp = 3,
	id = 1,
	skillIcon = 5,
	skillDesc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	skillDesc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.teamchess_enemy_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_teamchess_enemy, "configList", _configList)
	rawset(lua_teamchess_enemy, "configDict", _configDict)
end

setmetatable(lua_teamchess_enemy, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_teamchess_enemy.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_teamchess_enemy, "configList", nil)
	rawset(lua_teamchess_enemy, "configDict", nil)
end

return lua_teamchess_enemy
