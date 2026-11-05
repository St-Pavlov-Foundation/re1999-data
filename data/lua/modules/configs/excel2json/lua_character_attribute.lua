-- chunkname: @modules/configs/excel2json/lua_character_attribute.lua

module("modules.configs.excel2json.lua_character_attribute", package.seeall)

local lua_character_attribute = {}
local fields = {
	showType = 8,
	attrType = 2,
	name = 4,
	type = 3,
	showcolor = 9,
	sortId = 11,
	desc = 5,
	isShowTips = 6,
	id = 1,
	icon = 10,
	isShow = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.character_attribute_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_attribute, "configList", _configList)
	rawset(lua_character_attribute, "configDict", _configDict)
end

setmetatable(lua_character_attribute, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_attribute.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_attribute, "configList", nil)
	rawset(lua_character_attribute, "configDict", nil)
end

return lua_character_attribute
