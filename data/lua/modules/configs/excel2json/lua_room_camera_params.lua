-- chunkname: @modules/configs/excel2json/lua_room_camera_params.lua

module("modules.configs.excel2json.lua_room_camera_params", package.seeall)

local lua_room_camera_params = {}
local fields = {
	fogRangeXYZW = 15,
	gameMode = 3,
	blur = 9,
	state = 2,
	lightMin = 6,
	bendingAmount = 8,
	distance = 5,
	fogParticles = 13,
	zoom = 4,
	oceanFog = 18,
	angle = 7,
	shadowOffsetXYZW = 12,
	fogNearColorRGBA = 16,
	fogViewType = 14,
	touchMoveSpeed = 11,
	offsetHorizon = 10,
	fogFarColorRGBA = 17,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.room_camera_params_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_camera_params, "configList", _configList)
	rawset(lua_room_camera_params, "configDict", _configDict)
end

setmetatable(lua_room_camera_params, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_camera_params.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_camera_params, "configList", nil)
	rawset(lua_room_camera_params, "configDict", nil)
end

return lua_room_camera_params
