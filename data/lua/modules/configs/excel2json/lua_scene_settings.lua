-- chunkname: @modules/configs/excel2json/lua_scene_settings.lua

module("modules.configs.excel2json.lua_scene_settings", package.seeall)

local lua_scene_settings = {}
local fields = {
	spineOffset = 2,
	lightColor2 = 4,
	prefabLightStartRotation = 7,
	lightColor3 = 5,
	id = 1,
	lightColor4 = 6,
	effectLightStartRotation = 8,
	lightColor1 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.scene_settings_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_scene_settings, "configList", _configList)
	rawset(lua_scene_settings, "configDict", _configDict)
end

setmetatable(lua_scene_settings, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_scene_settings.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_scene_settings, "configList", nil)
	rawset(lua_scene_settings, "configDict", nil)
end

return lua_scene_settings
