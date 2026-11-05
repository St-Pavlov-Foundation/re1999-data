-- chunkname: @modules/configs/excel2json/lua_activity178_building.lua

module("modules.configs.excel2json.lua_activity178_building", package.seeall)

local lua_activity178_building = {}
local fields = {
	cost = 12,
	effect = 7,
	desc2 = 11,
	type = 4,
	name = 5,
	uiOffset = 13,
	condition = 6,
	desc = 10,
	destory = 14,
	res = 8,
	limit = 15,
	size = 16,
	id = 2,
	icon = 9,
	activityId = 1,
	level = 3
}
local primaryKey = {
	"activityId",
	"id",
	"level"
}
local mlStringKey = {
	desc2 = 3,
	name = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.activity178_building_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity178_building, "configList", _configList)
	rawset(lua_activity178_building, "configDict", _configDict)
end

setmetatable(lua_activity178_building, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity178_building.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity178_building, "configList", nil)
	rawset(lua_activity178_building, "configDict", nil)
end

return lua_activity178_building
