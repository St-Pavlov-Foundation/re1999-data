-- chunkname: @modules/configs/excel2json/lua_activity109_map.lua

module("modules.configs.excel2json.lua_activity109_map", package.seeall)

local lua_activity109_map = {}
local fields = {
	bgPath = 6,
	height = 4,
	activityId = 1,
	objects = 9,
	offset = 7,
	audioAmbient = 5,
	tilebase = 8,
	id = 2,
	width = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity109_map_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity109_map, "configList", _configList)
	rawset(lua_activity109_map, "configDict", _configDict)
end

setmetatable(lua_activity109_map, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity109_map.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity109_map, "configList", nil)
	rawset(lua_activity109_map, "configDict", nil)
end

return lua_activity109_map
