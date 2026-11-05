-- chunkname: @modules/configs/excel2json/lua_manufacture_building_trade_level.lua

module("modules.configs.excel2json.lua_manufacture_building_trade_level", package.seeall)

local lua_manufacture_building_trade_level = {}
local fields = {
	maxCritterCount = 3,
	tradeGroupId = 1,
	tradeLevel = 2
}
local primaryKey = {
	"tradeGroupId",
	"tradeLevel"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.manufacture_building_trade_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_manufacture_building_trade_level, "configList", _configList)
	rawset(lua_manufacture_building_trade_level, "configDict", _configDict)
end

setmetatable(lua_manufacture_building_trade_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_manufacture_building_trade_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_manufacture_building_trade_level, "configList", nil)
	rawset(lua_manufacture_building_trade_level, "configDict", nil)
end

return lua_manufacture_building_trade_level
