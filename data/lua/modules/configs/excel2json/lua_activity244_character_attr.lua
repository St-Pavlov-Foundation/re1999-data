-- chunkname: @modules/configs/excel2json/lua_activity244_character_attr.lua

module("modules.configs.excel2json.lua_activity244_character_attr", package.seeall)

local lua_activity244_character_attr = {}
local fields = {
	baseFieldName = 4,
	name = 2,
	addFieldName = 5,
	id = 1,
	icon = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity244_character_attr_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_character_attr, "configList", _configList)
	rawset(lua_activity244_character_attr, "configDict", _configDict)
end

setmetatable(lua_activity244_character_attr, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_character_attr.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_character_attr, "configList", nil)
	rawset(lua_activity244_character_attr, "configDict", nil)
end

return lua_activity244_character_attr
