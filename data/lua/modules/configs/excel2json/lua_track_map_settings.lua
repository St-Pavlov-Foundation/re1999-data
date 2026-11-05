-- chunkname: @modules/configs/excel2json/lua_track_map_settings.lua

module("modules.configs.excel2json.lua_track_map_settings", package.seeall)

local lua_track_map_settings = {}
local fields = {
	laneLength = 7,
	name = 2,
	slotDistance = 4,
	isCircle = 9,
	startPoint = 8,
	laneCount = 5,
	scene = 3,
	id = 1,
	laneWidth = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.track_map_settings_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_track_map_settings, "configList", _configList)
	rawset(lua_track_map_settings, "configDict", _configDict)
end

setmetatable(lua_track_map_settings, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_track_map_settings.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_track_map_settings, "configList", nil)
	rawset(lua_track_map_settings, "configDict", nil)
end

return lua_track_map_settings
