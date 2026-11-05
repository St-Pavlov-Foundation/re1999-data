-- chunkname: @modules/configs/excel2json/lua_v3a5_character.lua

module("modules.configs.excel2json.lua_v3a5_character", package.seeall)

local lua_v3a5_character = {}
local fields = {
	id = 1,
	name = 3,
	profileId = 2,
	enName = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.v3a5_character_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v3a5_character, "configList", _configList)
	rawset(lua_v3a5_character, "configDict", _configDict)
end

setmetatable(lua_v3a5_character, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v3a5_character.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v3a5_character, "configList", nil)
	rawset(lua_v3a5_character, "configDict", nil)
end

return lua_v3a5_character
