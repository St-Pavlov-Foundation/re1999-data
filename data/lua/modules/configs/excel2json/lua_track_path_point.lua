-- chunkname: @modules/configs/excel2json/lua_track_path_point.lua

module("modules.configs.excel2json.lua_track_path_point", package.seeall)

local lua_track_path_point = {}
local fields = {
	posY = 5,
	posZ = 6,
	distance = 3,
	traceId = 1,
	pointId = 2,
	posX = 4
}
local primaryKey = {
	"traceId",
	"pointId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.track_path_point_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_track_path_point, "configList", _configList)
	rawset(lua_track_path_point, "configDict", _configDict)
end

setmetatable(lua_track_path_point, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_track_path_point.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_track_path_point, "configList", nil)
	rawset(lua_track_path_point, "configDict", nil)
end

return lua_track_path_point
