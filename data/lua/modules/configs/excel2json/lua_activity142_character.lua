-- chunkname: @modules/configs/excel2json/lua_activity142_character.lua

module("modules.configs.excel2json.lua_activity142_character", package.seeall)

local lua_activity142_character = {}
local fields = {
	activityId = 1,
	canTriggerPedal = 3,
	canUseFireball = 5,
	canBreakTile = 6,
	characterType = 2,
	canLightBrazier = 4
}
local primaryKey = {
	"activityId",
	"characterType"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity142_character_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity142_character, "configList", _configList)
	rawset(lua_activity142_character, "configDict", _configDict)
end

setmetatable(lua_activity142_character, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity142_character.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity142_character, "configList", nil)
	rawset(lua_activity142_character, "configDict", nil)
end

return lua_activity142_character
