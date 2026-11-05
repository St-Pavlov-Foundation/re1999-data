-- chunkname: @modules/configs/excel2json/lua_room_building_area.lua

module("modules.configs.excel2json.lua_room_building_area", package.seeall)

local lua_room_building_area = {}
local fields = {
	id = 1,
	icon = 3,
	area = 2,
	occupy = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.room_building_area_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_building_area, "configList", _configList)
	rawset(lua_room_building_area, "configDict", _configDict)
end

setmetatable(lua_room_building_area, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_building_area.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_building_area, "configList", nil)
	rawset(lua_room_building_area, "configDict", nil)
end

return lua_room_building_area
