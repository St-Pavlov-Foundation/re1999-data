-- chunkname: @modules/configs/excel2json/lua_weekwalk_ver2_scene.lua

module("modules.configs.excel2json.lua_weekwalk_ver2_scene", package.seeall)

local lua_weekwalk_ver2_scene = {}
local fields = {
	map = 2,
	name = 6,
	buffId = 4,
	mapId = 3,
	name_en = 9,
	battleName = 8,
	typeName = 5,
	id = 1,
	icon = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	typeName = 1,
	name_en = 4,
	battleName = 3
}
local _configList, _configDict
local configPath = "configs.weekwalk_ver2_scene_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_weekwalk_ver2_scene, "configList", _configList)
	rawset(lua_weekwalk_ver2_scene, "configDict", _configDict)
end

setmetatable(lua_weekwalk_ver2_scene, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_weekwalk_ver2_scene.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_weekwalk_ver2_scene, "configList", nil)
	rawset(lua_weekwalk_ver2_scene, "configDict", nil)
end

return lua_weekwalk_ver2_scene
