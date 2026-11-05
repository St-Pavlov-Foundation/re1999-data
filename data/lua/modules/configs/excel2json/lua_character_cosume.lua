-- chunkname: @modules/configs/excel2json/lua_character_cosume.lua

module("modules.configs.excel2json.lua_character_cosume", package.seeall)

local lua_character_cosume = {}
local fields = {
	cosume = 3,
	rare = 2,
	level = 1
}
local primaryKey = {
	"level",
	"rare"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.character_cosume_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_cosume, "configList", _configList)
	rawset(lua_character_cosume, "configDict", _configDict)
end

setmetatable(lua_character_cosume, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_cosume.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_cosume, "configList", nil)
	rawset(lua_character_cosume, "configDict", nil)
end

return lua_character_cosume
