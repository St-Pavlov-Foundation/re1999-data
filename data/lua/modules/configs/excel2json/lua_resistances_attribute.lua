-- chunkname: @modules/configs/excel2json/lua_resistances_attribute.lua

module("modules.configs.excel2json.lua_resistances_attribute", package.seeall)

local lua_resistances_attribute = {}
local fields = {
	forbid = 7,
	sleep = 3,
	dizzy = 2,
	frozen = 5,
	petrified = 4,
	delExPointResilience = 14,
	delExPoint = 11,
	stressUp = 12,
	controlResilience = 13,
	charm = 10,
	stressUpResilience = 15,
	seal = 8,
	id = 1,
	disarm = 6,
	cantGetExskill = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.resistances_attribute_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_resistances_attribute, "configList", _configList)
	rawset(lua_resistances_attribute, "configDict", _configDict)
end

setmetatable(lua_resistances_attribute, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_resistances_attribute.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_resistances_attribute, "configList", nil)
	rawset(lua_resistances_attribute, "configDict", nil)
end

return lua_resistances_attribute
