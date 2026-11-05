-- chunkname: @modules/configs/excel2json/lua_activity157_repair_map.lua

module("modules.configs.excel2json.lua_activity157_repair_map", package.seeall)

local lua_activity157_repair_map = {}
local fields = {
	componentId = 2,
	height = 5,
	titleTip = 3,
	activityId = 1,
	tilebase = 6,
	objects = 7,
	width = 4,
	desc = 8
}
local primaryKey = {
	"activityId",
	"componentId"
}
local mlStringKey = {
	titleTip = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.activity157_repair_map_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity157_repair_map, "configList", _configList)
	rawset(lua_activity157_repair_map, "configDict", _configDict)
end

setmetatable(lua_activity157_repair_map, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity157_repair_map.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity157_repair_map, "configList", nil)
	rawset(lua_activity157_repair_map, "configDict", nil)
end

return lua_activity157_repair_map
