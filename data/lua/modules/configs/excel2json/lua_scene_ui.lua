-- chunkname: @modules/configs/excel2json/lua_scene_ui.lua

module("modules.configs.excel2json.lua_scene_ui", package.seeall)

local lua_scene_ui = {}
local fields = {
	itemId = 3,
	previewIcon = 5,
	id = 1,
	icon = 4,
	defaultUnlock = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.scene_ui_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_scene_ui, "configList", _configList)
	rawset(lua_scene_ui, "configDict", _configDict)
end

setmetatable(lua_scene_ui, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_scene_ui.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_scene_ui, "configList", nil)
	rawset(lua_scene_ui, "configDict", nil)
end

return lua_scene_ui
