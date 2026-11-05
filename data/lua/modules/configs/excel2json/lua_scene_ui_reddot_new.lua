-- chunkname: @modules/configs/excel2json/lua_scene_ui_reddot_new.lua

module("modules.configs.excel2json.lua_scene_ui_reddot_new", package.seeall)

local lua_scene_ui_reddot_new = {}
local fields = {
	id = 1,
	style = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.scene_ui_reddot_new_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_scene_ui_reddot_new, "configList", _configList)
	rawset(lua_scene_ui_reddot_new, "configDict", _configDict)
end

setmetatable(lua_scene_ui_reddot_new, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_scene_ui_reddot_new.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_scene_ui_reddot_new, "configList", nil)
	rawset(lua_scene_ui_reddot_new, "configDict", nil)
end

return lua_scene_ui_reddot_new
