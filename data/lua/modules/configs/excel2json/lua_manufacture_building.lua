-- chunkname: @modules/configs/excel2json/lua_manufacture_building.lua

module("modules.configs.excel2json.lua_manufacture_building", package.seeall)

local lua_manufacture_building = {}
local fields = {
	tradeGroupId = 6,
	placeTradeLevel = 2,
	id = 1,
	buildIcon = 8,
	taskIcon = 9,
	upgradeGroupId = 5,
	cameraIds = 7,
	placeCost = 4,
	placeNoCost = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.manufacture_building_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_manufacture_building, "configList", _configList)
	rawset(lua_manufacture_building, "configDict", _configDict)
end

setmetatable(lua_manufacture_building, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_manufacture_building.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_manufacture_building, "configList", nil)
	rawset(lua_manufacture_building, "configDict", nil)
end

return lua_manufacture_building
