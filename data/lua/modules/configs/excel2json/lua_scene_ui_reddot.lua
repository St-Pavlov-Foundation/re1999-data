-- chunkname: @modules/configs/excel2json/lua_scene_ui_reddot.lua

module("modules.configs.excel2json.lua_scene_ui_reddot", package.seeall)

local lua_scene_ui_reddot = {}
local fields = {
	id = 1,
	reddotId = 2,
	style = 3
}
local primaryKey = {
	"id",
	"reddotId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.scene_ui_reddot_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_scene_ui_reddot, "configList", _configList)
	rawset(lua_scene_ui_reddot, "configDict", _configDict)
end

setmetatable(lua_scene_ui_reddot, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_scene_ui_reddot.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_scene_ui_reddot, "configList", nil)
	rawset(lua_scene_ui_reddot, "configDict", nil)
end

return lua_scene_ui_reddot
