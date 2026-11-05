-- chunkname: @modules/configs/excel2json/lua_activity122_character.lua

module("modules.configs.excel2json.lua_activity122_character", package.seeall)

local lua_activity122_character = {}
local fields = {
	activityId = 1,
	pushOverObstacle = 7,
	fireDecrHp = 6,
	trapDecrHp = 5,
	destroyObstacle = 4,
	moveObstacle = 3,
	characterType = 2
}
local primaryKey = {
	"activityId",
	"characterType"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity122_character_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity122_character, "configList", _configList)
	rawset(lua_activity122_character, "configDict", _configDict)
end

setmetatable(lua_activity122_character, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity122_character.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity122_character, "configList", nil)
	rawset(lua_activity122_character, "configDict", nil)
end

return lua_activity122_character
