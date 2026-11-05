-- chunkname: @modules/configs/excel2json/lua_scene_click.lua

module("modules.configs.excel2json.lua_scene_click", package.seeall)

local lua_scene_click = {}
local fields = {
	itemId = 3,
	effect = 6,
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
local configPath = "configs.scene_click_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_scene_click, "configList", _configList)
	rawset(lua_scene_click, "configDict", _configDict)
end

setmetatable(lua_scene_click, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_scene_click.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_scene_click, "configList", nil)
	rawset(lua_scene_click, "configDict", nil)
end

return lua_scene_click
