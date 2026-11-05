-- chunkname: @modules/configs/excel2json/lua_log_room_character.lua

module("modules.configs.excel2json.lua_log_room_character", package.seeall)

local lua_log_room_character = {}
local fields = {
	id = 1,
	upTime = 3,
	tag = 4,
	logkind = 2,
	content = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 1
}
local _configList, _configDict
local configPath = "configs.log_room_character_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_log_room_character, "configList", _configList)
	rawset(lua_log_room_character, "configDict", _configDict)
end

setmetatable(lua_log_room_character, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_log_room_character.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_log_room_character, "configList", nil)
	rawset(lua_log_room_character, "configDict", nil)
end

return lua_log_room_character
