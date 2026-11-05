-- chunkname: @modules/configs/excel2json/lua_camera.lua

module("modules.configs.excel2json.lua_camera", package.seeall)

local lua_camera = {}
local fields = {
	focusZ = 6,
	far = 9,
	distance = 4,
	foucsX = 8,
	yaw = 2,
	id = 1,
	pitch = 3,
	fov = 5,
	yOffset = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.camera_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_camera, "configList", _configList)
	rawset(lua_camera, "configDict", _configDict)
end

setmetatable(lua_camera, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_camera.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_camera, "configList", nil)
	rawset(lua_camera, "configDict", nil)
end

return lua_camera
