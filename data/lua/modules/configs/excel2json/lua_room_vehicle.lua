-- chunkname: @modules/configs/excel2json/lua_room_vehicle.lua

module("modules.configs.excel2json.lua_room_vehicle", package.seeall)

local lua_room_vehicle = {}
local fields = {
	audioStop = 14,
	radius = 5,
	audioTurn = 9,
	rotate = 12,
	moveSpeed = 6,
	name = 2,
	followRotateStr = 17,
	path = 3,
	audioTurnAround = 10,
	takeoffTime = 19,
	endPathWaitTime = 8,
	audioCrossload = 11,
	firstCameraId = 20,
	resId = 4,
	uiIcon = 22,
	replaceConditionStr = 24,
	waterOffseY = 25,
	buildIcon = 23,
	rotationSpeed = 7,
	useType = 18,
	followNodePathStr = 15,
	followRadiusStr = 16,
	id = 1,
	thirdCameraId = 21,
	audioWalk = 13
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.room_vehicle_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_room_vehicle, "configList", _configList)
	rawset(lua_room_vehicle, "configDict", _configDict)
end

setmetatable(lua_room_vehicle, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_vehicle.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_vehicle, "configList", nil)
	rawset(lua_room_vehicle, "configDict", nil)
end

return lua_room_vehicle
