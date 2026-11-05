-- chunkname: @modules/configs/excel2json/lua_fight_scene_level_camera_shadow.lua

module("modules.configs.excel2json.lua_fight_scene_level_camera_shadow", package.seeall)

local lua_fight_scene_level_camera_shadow = {}
local fields = {
	shadowDistance = 2,
	rotation = 3,
	shadowDepthBias = 5,
	shadowNormalBias = 6,
	id = 1,
	lightShadowResolution = 7,
	invokeRotateImmediately = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_scene_level_camera_shadow_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_scene_level_camera_shadow, "configList", _configList)
	rawset(lua_fight_scene_level_camera_shadow, "configDict", _configDict)
end

setmetatable(lua_fight_scene_level_camera_shadow, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_scene_level_camera_shadow.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_scene_level_camera_shadow, "configList", nil)
	rawset(lua_fight_scene_level_camera_shadow, "configDict", nil)
end

return lua_fight_scene_level_camera_shadow
