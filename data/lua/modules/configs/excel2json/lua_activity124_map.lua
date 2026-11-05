-- chunkname: @modules/configs/excel2json/lua_activity124_map.lua

module("modules.configs.excel2json.lua_activity124_map", package.seeall)

local lua_activity124_map = {}
local fields = {
	objects = 7,
	height = 4,
	tilebase = 6,
	audioAmbient = 5,
	id = 2,
	activityId = 1,
	width = 3,
	desc = 8
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity124_map_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity124_map, "configList", _configList)
	rawset(lua_activity124_map, "configDict", _configDict)
end

setmetatable(lua_activity124_map, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity124_map.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity124_map, "configList", nil)
	rawset(lua_activity124_map, "configDict", nil)
end

return lua_activity124_map
