-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_attribute.lua

module("modules.configs.excel2json.lua_arcade_survivor_attribute", package.seeall)

local lua_arcade_survivor_attribute = {}
local fields = {
	name = 2,
	min = 3,
	sort = 6,
	id = 1,
	icon = 5,
	max = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.arcade_survivor_attribute_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_attribute, "configList", _configList)
	rawset(lua_arcade_survivor_attribute, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_attribute, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_attribute.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_attribute, "configList", nil)
	rawset(lua_arcade_survivor_attribute, "configDict", nil)
end

return lua_arcade_survivor_attribute
