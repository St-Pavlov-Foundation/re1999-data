-- chunkname: @modules/configs/excel2json/lua_scene_mat_report_settings.lua

module("modules.configs.excel2json.lua_scene_mat_report_settings", package.seeall)

local lua_scene_mat_report_settings = {}
local fields = {
	id = 2,
	sceneId = 1,
	lightmap = 4,
	mat = 3
}
local primaryKey = {
	"sceneId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.scene_mat_report_settings_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_scene_mat_report_settings, "configList", _configList)
	rawset(lua_scene_mat_report_settings, "configDict", _configDict)
end

setmetatable(lua_scene_mat_report_settings, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_scene_mat_report_settings.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_scene_mat_report_settings, "configList", nil)
	rawset(lua_scene_mat_report_settings, "configDict", nil)
end

return lua_scene_mat_report_settings
