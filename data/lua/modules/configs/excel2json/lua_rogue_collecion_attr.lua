-- chunkname: @modules/configs/excel2json/lua_rogue_collecion_attr.lua

module("modules.configs.excel2json.lua_rogue_collecion_attr", package.seeall)

local lua_rogue_collecion_attr = {}
local fields = {
	revive = 13,
	def = 4,
	dropDmg = 11,
	defenseIgnore = 14,
	cri = 6,
	id = 1,
	mdef = 5,
	addDmg = 10,
	criDmg = 8,
	attack = 3,
	criDef = 9,
	clutch = 17,
	absorb = 15,
	normalSkillRate = 16,
	recri = 7,
	hp = 2,
	heal = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rogue_collecion_attr_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_collecion_attr, "configList", _configList)
	rawset(lua_rogue_collecion_attr, "configDict", _configDict)
end

setmetatable(lua_rogue_collecion_attr, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_collecion_attr.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_collecion_attr, "configList", nil)
	rawset(lua_rogue_collecion_attr, "configDict", nil)
end

return lua_rogue_collecion_attr
