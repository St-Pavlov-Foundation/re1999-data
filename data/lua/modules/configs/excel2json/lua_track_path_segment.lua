-- chunkname: @modules/configs/excel2json/lua_track_path_segment.lua

module("modules.configs.excel2json.lua_track_path_segment", package.seeall)

local lua_track_path_segment = {}
local fields = {
	rad = 6,
	endPoint = 4,
	segmentId = 2,
	type = 5,
	traceId = 1,
	len = 7,
	startPoint = 3
}
local primaryKey = {
	"traceId",
	"segmentId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.track_path_segment_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_track_path_segment, "configList", _configList)
	rawset(lua_track_path_segment, "configDict", _configDict)
end

setmetatable(lua_track_path_segment, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_track_path_segment.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_track_path_segment, "configList", nil)
	rawset(lua_track_path_segment, "configDict", nil)
end

return lua_track_path_segment
