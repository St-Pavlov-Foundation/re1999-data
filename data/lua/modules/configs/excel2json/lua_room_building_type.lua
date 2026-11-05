-- chunkname: @modules/configs/excel2json/lua_room_building_type.lua

module("modules.configs.excel2json.lua_room_building_type", package.seeall)

local lua_room_building_type = {}
local fields = {
	icon = 2,
	type = 1
}
local primaryKey = {
	"type"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.room_building_type_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_building_type, "configList", _configList)
	rawset(lua_room_building_type, "configDict", _configDict)
end

setmetatable(lua_room_building_type, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_building_type.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_building_type, "configList", nil)
	rawset(lua_room_building_type, "configDict", nil)
end

return lua_room_building_type
