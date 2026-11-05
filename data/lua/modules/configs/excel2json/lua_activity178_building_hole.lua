-- chunkname: @modules/configs/excel2json/lua_activity178_building_hole.lua

module("modules.configs.excel2json.lua_activity178_building_hole", package.seeall)

local lua_activity178_building_hole = {}
local fields = {
	activityId = 1,
	condition = 5,
	index = 2,
	size = 4,
	pos = 3
}
local primaryKey = {
	"activityId",
	"index"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity178_building_hole_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity178_building_hole, "configList", _configList)
	rawset(lua_activity178_building_hole, "configDict", _configDict)
end

setmetatable(lua_activity178_building_hole, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity178_building_hole.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity178_building_hole, "configList", nil)
	rawset(lua_activity178_building_hole, "configDict", nil)
end

return lua_activity178_building_hole
