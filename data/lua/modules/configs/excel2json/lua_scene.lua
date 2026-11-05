-- chunkname: @modules/configs/excel2json/lua_scene.lua

module("modules.configs.excel2json.lua_scene", package.seeall)

local lua_scene = {}
local fields = {
	id = 1,
	name = 2,
	levels = 4,
	nameen = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.scene_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_scene, "configList", _configList)
	rawset(lua_scene, "configDict", _configDict)
end

setmetatable(lua_scene, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_scene.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_scene, "configList", nil)
	rawset(lua_scene, "configDict", nil)
end

return lua_scene
