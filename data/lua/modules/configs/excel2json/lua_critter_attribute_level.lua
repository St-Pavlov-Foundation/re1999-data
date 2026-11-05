-- chunkname: @modules/configs/excel2json/lua_critter_attribute_level.lua

module("modules.configs.excel2json.lua_critter_attribute_level", package.seeall)

local lua_critter_attribute_level = {}
local fields = {
	name = 3,
	minValue = 2,
	icon = 4,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.critter_attribute_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_critter_attribute_level, "configList", _configList)
	rawset(lua_critter_attribute_level, "configDict", _configDict)
end

setmetatable(lua_critter_attribute_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_critter_attribute_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_critter_attribute_level, "configList", nil)
	rawset(lua_critter_attribute_level, "configDict", nil)
end

return lua_critter_attribute_level
