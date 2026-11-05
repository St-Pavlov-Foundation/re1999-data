-- chunkname: @modules/configs/excel2json/lua_activity123_equip_attr.lua

module("modules.configs.excel2json.lua_activity123_equip_attr", package.seeall)

local lua_activity123_equip_attr = {}
local fields = {
	dropDmg = 11,
	def = 4,
	cri = 6,
	defenseIgnore = 14,
	atk = 3,
	normalSkillRate = 17,
	mdef = 5,
	addDmg = 10,
	criDmg = 8,
	criDef = 9,
	clutch = 16,
	attrId = 1,
	absorb = 15,
	revive = 13,
	recri = 7,
	hp = 2,
	heal = 12
}
local primaryKey = {
	"attrId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity123_equip_attr_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity123_equip_attr, "configList", _configList)
	rawset(lua_activity123_equip_attr, "configDict", _configDict)
end

setmetatable(lua_activity123_equip_attr, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity123_equip_attr.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity123_equip_attr, "configList", nil)
	rawset(lua_activity123_equip_attr, "configDict", nil)
end

return lua_activity123_equip_attr
