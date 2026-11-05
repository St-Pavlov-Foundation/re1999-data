-- chunkname: @modules/configs/excel2json/lua_critter_attribute.lua

module("modules.configs.excel2json.lua_critter_attribute", package.seeall)

local lua_critter_attribute = {}
local fields = {
	id = 1,
	name = 2,
	icon = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.critter_attribute_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_critter_attribute, "configList", _configList)
	rawset(lua_critter_attribute, "configDict", _configDict)
end

setmetatable(lua_critter_attribute, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_critter_attribute.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_critter_attribute, "configList", nil)
	rawset(lua_critter_attribute, "configDict", nil)
end

return lua_critter_attribute
