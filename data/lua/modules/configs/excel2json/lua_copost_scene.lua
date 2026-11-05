-- chunkname: @modules/configs/excel2json/lua_copost_scene.lua

module("modules.configs.excel2json.lua_copost_scene", package.seeall)

local lua_copost_scene = {}
local fields = {
	scene = 2,
	leftUpRange = 3,
	scene_ui = 5,
	scene_node = 6,
	id = 1,
	rightDownRange = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.copost_scene_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_copost_scene, "configList", _configList)
	rawset(lua_copost_scene, "configDict", _configDict)
end

setmetatable(lua_copost_scene, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_copost_scene.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_copost_scene, "configList", nil)
	rawset(lua_copost_scene, "configDict", nil)
end

return lua_copost_scene
