-- chunkname: @modules/configs/excel2json/lua_room_character_building_interact_camera.lua

module("modules.configs.excel2json.lua_room_character_building_interact_camera", package.seeall)

local lua_room_character_building_interact_camera = {}
local fields = {
	nodesXYZ = 6,
	focusXYZ = 5,
	distance = 3,
	rotate = 4,
	id = 1,
	nextCameraParams = 7,
	angle = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.room_character_building_interact_camera_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_character_building_interact_camera, "configList", _configList)
	rawset(lua_room_character_building_interact_camera, "configDict", _configDict)
end

setmetatable(lua_room_character_building_interact_camera, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_character_building_interact_camera.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_character_building_interact_camera, "configList", nil)
	rawset(lua_room_character_building_interact_camera, "configDict", nil)
end

return lua_room_character_building_interact_camera
