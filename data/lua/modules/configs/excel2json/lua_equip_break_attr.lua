-- chunkname: @modules/configs/excel2json/lua_equip_break_attr.lua

module("modules.configs.excel2json.lua_equip_break_attr", package.seeall)

local lua_equip_break_attr = {}
local fields = {
	dropDmg = 12,
	def = 5,
	cri = 7,
	defenseIgnore = 15,
	id = 1,
	normalSkillRate = 17,
	mdef = 6,
	addDmg = 11,
	criDmg = 9,
	attack = 3,
	criDef = 10,
	clutch = 18,
	absorb = 16,
	revive = 14,
	recri = 8,
	hp = 4,
	breakLevel = 2,
	heal = 13
}
local primaryKey = {
	"id",
	"breakLevel"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.equip_break_attr_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_equip_break_attr, "configList", _configList)
	rawset(lua_equip_break_attr, "configDict", _configDict)
end

setmetatable(lua_equip_break_attr, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_equip_break_attr.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_equip_break_attr, "configList", nil)
	rawset(lua_equip_break_attr, "configDict", nil)
end

return lua_equip_break_attr
