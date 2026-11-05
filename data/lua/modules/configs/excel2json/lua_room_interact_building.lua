-- chunkname: @modules/configs/excel2json/lua_room_interact_building.lua

module("modules.configs.excel2json.lua_room_interact_building", package.seeall)

local lua_room_interact_building = {}
local fields = {
	buildingId = 1,
	heroCount = 2,
	cameraId = 8,
	heroAnimStr = 6,
	interactType = 4,
	intervalTime = 3,
	buildingAnim = 7,
	showTime = 5
}
local primaryKey = {
	"buildingId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.room_interact_building_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_interact_building, "configList", _configList)
	rawset(lua_room_interact_building, "configDict", _configDict)
end

setmetatable(lua_room_interact_building, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_interact_building.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_interact_building, "configList", nil)
	rawset(lua_room_interact_building, "configDict", nil)
end

return lua_room_interact_building
