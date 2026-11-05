-- chunkname: @modules/configs/excel2json/lua_handbook_character.lua

module("modules.configs.excel2json.lua_handbook_character", package.seeall)

local lua_handbook_character = {}
local fields = {
	id = 1,
	name = 2,
	nameEng = 3,
	icon = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.handbook_character_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_handbook_character, "configList", _configList)
	rawset(lua_handbook_character, "configDict", _configDict)
end

setmetatable(lua_handbook_character, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_handbook_character.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_handbook_character, "configList", nil)
	rawset(lua_handbook_character, "configDict", nil)
end

return lua_handbook_character
