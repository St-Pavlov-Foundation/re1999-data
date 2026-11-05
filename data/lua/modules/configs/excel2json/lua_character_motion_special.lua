-- chunkname: @modules/configs/excel2json/lua_character_motion_special.lua

module("modules.configs.excel2json.lua_character_motion_special", package.seeall)

local lua_character_motion_special = {}
local fields = {
	heroResName = 1,
	skipStopMouth = 2
}
local primaryKey = {
	"heroResName"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.character_motion_special_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_character_motion_special, "configList", _configList)
	rawset(lua_character_motion_special, "configDict", _configDict)
end

setmetatable(lua_character_motion_special, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_character_motion_special.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_character_motion_special, "configList", nil)
	rawset(lua_character_motion_special, "configDict", nil)
end

return lua_character_motion_special
