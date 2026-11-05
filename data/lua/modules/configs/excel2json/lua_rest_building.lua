-- chunkname: @modules/configs/excel2json/lua_rest_building.lua

module("modules.configs.excel2json.lua_rest_building", package.seeall)

local lua_rest_building = {}
local fields = {
	id = 1,
	restSlotNum = 2,
	buySlotCost = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rest_building_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rest_building, "configList", _configList)
	rawset(lua_rest_building, "configDict", _configDict)
end

setmetatable(lua_rest_building, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rest_building.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rest_building, "configList", nil)
	rawset(lua_rest_building, "configDict", nil)
end

return lua_rest_building
