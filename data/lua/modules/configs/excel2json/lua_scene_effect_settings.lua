-- chunkname: @modules/configs/excel2json/lua_scene_effect_settings.lua

module("modules.configs.excel2json.lua_scene_effect_settings", package.seeall)

local lua_scene_effect_settings = {}
local fields = {
	tag = 4,
	lightColor3 = 8,
	path = 3,
	sceneId = 1,
	lightColor2 = 7,
	colorKey = 5,
	id = 2,
	lightColor4 = 9,
	lightColor1 = 6
}
local primaryKey = {
	"sceneId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.scene_effect_settings_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_scene_effect_settings, "configList", _configList)
	rawset(lua_scene_effect_settings, "configDict", _configDict)
end

setmetatable(lua_scene_effect_settings, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_scene_effect_settings.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_scene_effect_settings, "configList", nil)
	rawset(lua_scene_effect_settings, "configDict", nil)
end

return lua_scene_effect_settings
