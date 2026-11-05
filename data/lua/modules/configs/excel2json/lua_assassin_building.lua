-- chunkname: @modules/configs/excel2json/lua_assassin_building.lua

module("modules.configs.excel2json.lua_assassin_building", package.seeall)

local lua_assassin_building = {}
local fields = {
	cost = 7,
	buildingBgIcon = 10,
	unlockDesc = 5,
	type = 3,
	effectDesc = 6,
	title = 2,
	lockBuildingIcon = 9,
	desc = 13,
	levelupPic = 12,
	itemIcon = 11,
	id = 1,
	buildingIcon = 8,
	level = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	effectDesc = 3,
	title = 1,
	unlockDesc = 2,
	desc = 4
}
local _configList, _configDict
local configPath = "configs.assassin_building_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_building, "configList", _configList)
	rawset(lua_assassin_building, "configDict", _configDict)
end

setmetatable(lua_assassin_building, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_building.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_building, "configList", nil)
	rawset(lua_assassin_building, "configDict", nil)
end

return lua_assassin_building
