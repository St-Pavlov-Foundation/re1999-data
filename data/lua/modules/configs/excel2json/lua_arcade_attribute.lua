-- chunkname: @modules/configs/excel2json/lua_arcade_attribute.lua

module("modules.configs.excel2json.lua_arcade_attribute", package.seeall)

local lua_arcade_attribute = {}
local fields = {
	extend = 5,
	min = 2,
	icon = 6,
	name = 8,
	id = 1,
	initVal = 4,
	currencyIcon = 7,
	max = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_attribute_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_attribute, "configList", _configList)
	rawset(lua_arcade_attribute, "configDict", _configDict)
end

setmetatable(lua_arcade_attribute, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_attribute.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_attribute, "configList", nil)
	rawset(lua_arcade_attribute, "configDict", nil)
end

return lua_arcade_attribute
