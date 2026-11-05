-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_collection.lua

module("modules.configs.excel2json.lua_arcade_survivor_collection", package.seeall)

local lua_arcade_survivor_collection = {}
local fields = {
	tagId = 5,
	rarity = 6,
	maxStacks = 7,
	name = 2,
	monsterAddSkills = 9,
	prices = 11,
	desc = 3,
	addSkills = 8,
	id = 1,
	icon = 4,
	ruleIds = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.arcade_survivor_collection_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_collection, "configList", _configList)
	rawset(lua_arcade_survivor_collection, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_collection, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_collection.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_collection, "configList", nil)
	rawset(lua_arcade_survivor_collection, "configDict", nil)
end

return lua_arcade_survivor_collection
