-- chunkname: @modules/configs/excel2json/lua_sodache_building.lua

module("modules.configs.excel2json.lua_sodache_building", package.seeall)

local lua_sodache_building = {}
local fields = {
	defaultUnlock = 7,
	effect = 8,
	name = 3,
	type = 1,
	consumePram = 6,
	unlockPram = 5,
	buildingDesc = 12,
	requiredLevel = 11,
	unlockDesc = 13,
	location = 14,
	globalAttri = 10,
	prefab = 15,
	effectDesc = 9,
	icon = 4,
	level = 2
}
local primaryKey = {
	"type",
	"level"
}
local mlStringKey = {
	effectDesc = 2,
	name = 1,
	unlockDesc = 4,
	buildingDesc = 3
}
local _configList, _configDict
local configPath = "configs.sodache_building_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sodache_building, "configList", _configList)
	rawset(lua_sodache_building, "configDict", _configDict)
end

setmetatable(lua_sodache_building, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sodache_building.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sodache_building, "configList", nil)
	rawset(lua_sodache_building, "configDict", nil)
end

return lua_sodache_building
