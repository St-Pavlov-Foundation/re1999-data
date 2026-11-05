-- chunkname: @modules/configs/excel2json/lua_racing_camera.lua

module("modules.configs.excel2json.lua_racing_camera", package.seeall)

local lua_racing_camera = {}
local fields = {
	shakeFrequency = 9,
	height = 3,
	shakeStrength = 8,
	distance = 2,
	lookHeight = 5,
	fOV = 7,
	id = 1,
	rotationSharpness = 6,
	lookAhead = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.racing_camera_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_racing_camera, "configList", _configList)
	rawset(lua_racing_camera, "configDict", _configDict)
end

setmetatable(lua_racing_camera, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_racing_camera.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_racing_camera, "configList", nil)
	rawset(lua_racing_camera, "configDict", nil)
end

return lua_racing_camera
