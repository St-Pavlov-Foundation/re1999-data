-- chunkname: @modules/configs/excel2json/lua_manufacture_building_level.lua

module("modules.configs.excel2json.lua_manufacture_building_level", package.seeall)

local lua_manufacture_building_level = {}
local fields = {
	cost = 4,
	effect = 3,
	id = 2,
	productions = 5,
	groupId = 1,
	needTradeLevel = 6,
	slotCount = 7
}
local primaryKey = {
	"groupId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.manufacture_building_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_manufacture_building_level, "configList", _configList)
	rawset(lua_manufacture_building_level, "configDict", _configDict)
end

setmetatable(lua_manufacture_building_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_manufacture_building_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_manufacture_building_level, "configList", nil)
	rawset(lua_manufacture_building_level, "configDict", nil)
end

return lua_manufacture_building_level
