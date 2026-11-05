-- chunkname: @modules/configs/excel2json/lua_critter_hero_preference.lua

module("modules.configs.excel2json.lua_critter_hero_preference", package.seeall)

local lua_critter_hero_preference = {}
local fields = {
	preferenceValue = 3,
	attachEventId = 8,
	attachAttribute = 10,
	preferenceType = 2,
	attachStoryId = 11,
	addIncrRate = 6,
	desc = 7,
	attachOption = 9,
	heroId = 1,
	spEventId = 12,
	critterIcon = 4,
	effectAttribute = 5
}
local primaryKey = {
	"heroId"
}
local mlStringKey = {
	attachOption = 2,
	desc = 1
}
local _configList, _configDict
local configPath = "configs.critter_hero_preference_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_critter_hero_preference, "configList", _configList)
	rawset(lua_critter_hero_preference, "configDict", _configDict)
end

setmetatable(lua_critter_hero_preference, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_critter_hero_preference.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_critter_hero_preference, "configList", nil)
	rawset(lua_critter_hero_preference, "configDict", nil)
end

return lua_critter_hero_preference
