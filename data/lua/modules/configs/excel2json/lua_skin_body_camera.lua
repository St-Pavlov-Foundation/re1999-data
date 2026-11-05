-- chunkname: @modules/configs/excel2json/lua_skin_body_camera.lua

module("modules.configs.excel2json.lua_skin_body_camera", package.seeall)

local lua_skin_body_camera = {}
local fields = {
	behavior = 2,
	res = 3,
	body = 4,
	camera_revert = 6,
	id = 1,
	camera = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.skin_body_camera_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skin_body_camera, "configList", _configList)
	rawset(lua_skin_body_camera, "configDict", _configDict)
end

setmetatable(lua_skin_body_camera, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skin_body_camera.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skin_body_camera, "configList", nil)
	rawset(lua_skin_body_camera, "configDict", nil)
end

return lua_skin_body_camera
