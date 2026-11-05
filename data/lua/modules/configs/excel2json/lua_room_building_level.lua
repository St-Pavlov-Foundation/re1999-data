-- chunkname: @modules/configs/excel2json/lua_room_building_level.lua

module("modules.configs.excel2json.lua_room_building_level", package.seeall)

local lua_room_building_level = {}
local fields = {
	nameEn = 10,
	name = 3,
	useDesc = 4,
	path = 11,
	levelUpIcon = 7,
	rare = 9,
	desc = 5,
	id = 1,
	icon = 6,
	rewardIcon = 8,
	level = 2
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {
	name = 1,
	useDesc = 2,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.room_building_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_building_level, "configList", _configList)
	rawset(lua_room_building_level, "configDict", _configDict)
end

setmetatable(lua_room_building_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_building_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_building_level, "configList", nil)
	rawset(lua_room_building_level, "configDict", nil)
end

return lua_room_building_level
