-- chunkname: @modules/configs/excel2json/lua_talent_cube_attr.lua

module("modules.configs.excel2json.lua_talent_cube_attr", package.seeall)

local lua_talent_cube_attr = {}
local fields = {
	cri = 9,
	calculateType = 4,
	cri_def = 12,
	defenseIgnore = 19,
	cri_dmg = 11,
	clutch = 17,
	mdef = 8,
	heal = 18,
	add_dmg = 13,
	def = 7,
	normalSkillRate = 20,
	atk = 6,
	icon = 3,
	level = 2,
	absorb = 16,
	revive = 15,
	recri = 10,
	drop_dmg = 14,
	hp = 5,
	id = 1
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.talent_cube_attr_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_talent_cube_attr, "configList", _configList)
	rawset(lua_talent_cube_attr, "configDict", _configDict)
end

setmetatable(lua_talent_cube_attr, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_talent_cube_attr.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_talent_cube_attr, "configList", nil)
	rawset(lua_talent_cube_attr, "configDict", nil)
end

return lua_talent_cube_attr
