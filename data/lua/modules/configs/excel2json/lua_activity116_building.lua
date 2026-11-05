-- chunkname: @modules/configs/excel2json/lua_activity116_building.lua

module("modules.configs.excel2json.lua_activity116_building", package.seeall)

local lua_activity116_building = {}
local fields = {
	cost = 7,
	name = 2,
	configType = 6,
	desc = 8,
	filterEpisode = 11,
	buildingType = 4,
	elementId = 3,
	lightBgUrl = 10,
	id = 1,
	icon = 9,
	level = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity116_building_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity116_building, "configList", _configList)
	rawset(lua_activity116_building, "configDict", _configDict)
end

setmetatable(lua_activity116_building, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity116_building.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity116_building, "configList", nil)
	rawset(lua_activity116_building, "configDict", nil)
end

return lua_activity116_building
