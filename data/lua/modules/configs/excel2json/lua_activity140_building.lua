-- chunkname: @modules/configs/excel2json/lua_activity140_building.lua

module("modules.configs.excel2json.lua_activity140_building", package.seeall)

local lua_activity140_building = {}
local fields = {
	cost = 6,
	name = 7,
	skilldesc = 5,
	type = 4,
	group = 3,
	focusPos = 12,
	pos = 11,
	desc = 13,
	previewImg = 9,
	id = 1,
	icon = 10,
	activityId = 2,
	nameEn = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	skilldesc = 1,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.activity140_building_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity140_building, "configList", _configList)
	rawset(lua_activity140_building, "configDict", _configDict)
end

setmetatable(lua_activity140_building, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity140_building.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity140_building, "configList", nil)
	rawset(lua_activity140_building, "configDict", nil)
end

return lua_activity140_building
