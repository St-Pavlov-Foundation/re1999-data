-- chunkname: @modules/configs/excel2json/lua_room_building_skin.lua

module("modules.configs.excel2json.lua_room_building_skin", package.seeall)

local lua_room_building_skin = {}
local fields = {
	itemId = 3,
	name = 4,
	useDesc = 5,
	path = 11,
	vehicleId = 12,
	rare = 9,
	desc = 6,
	buildingId = 2,
	id = 1,
	icon = 7,
	rewardIcon = 8,
	nameEn = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	useDesc = 2,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.room_building_skin_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_building_skin, "configList", _configList)
	rawset(lua_room_building_skin, "configDict", _configDict)
end

setmetatable(lua_room_building_skin, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_building_skin.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_building_skin, "configList", nil)
	rawset(lua_room_building_skin, "configDict", nil)
end

return lua_room_building_skin
