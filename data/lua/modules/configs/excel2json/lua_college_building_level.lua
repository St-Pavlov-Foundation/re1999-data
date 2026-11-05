-- chunkname: @modules/configs/excel2json/lua_college_building_level.lua

module("modules.configs.excel2json.lua_college_building_level", package.seeall)

local lua_college_building_level = {}
local fields = {
	param = 5,
	skillIds = 6,
	description = 7,
	buildingAsset = 8,
	id = 1,
	slots = 3,
	upgradeCost = 4,
	level = 2
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {
	description = 1
}
local _configList, _configDict
local configPath = "configs.college_building_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_college_building_level, "configList", _configList)
	rawset(lua_college_building_level, "configDict", _configDict)
end

setmetatable(lua_college_building_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_college_building_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_college_building_level, "configList", nil)
	rawset(lua_college_building_level, "configDict", nil)
end

return lua_college_building_level
