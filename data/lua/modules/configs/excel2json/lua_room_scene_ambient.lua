-- chunkname: @modules/configs/excel2json/lua_room_scene_ambient.lua

module("modules.configs.excel2json.lua_room_scene_ambient", package.seeall)

local lua_room_scene_ambient = {}
local fields = {}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.room_scene_ambient_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = lua_room_scene_ambient.json_parse(config)

	rawset(lua_room_scene_ambient, "configList", _configList)
	rawset(lua_room_scene_ambient, "configDict", _configDict)
end

setmetatable(lua_room_scene_ambient, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_room_scene_ambient.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_room_scene_ambient, "configList", nil)
	rawset(lua_room_scene_ambient, "configDict", nil)
end

function lua_room_scene_ambient.json_parse(json)
	local configList = {}
	local configDict = {}

	for _, cfg in ipairs(json) do
		table.insert(configList, cfg)

		configDict[cfg.id] = cfg
	end

	return configList, configDict
end

return lua_room_scene_ambient
