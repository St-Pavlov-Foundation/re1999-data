-- chunkname: @modules/configs/excel2json/lua_copost_time_point_event.lua

module("modules.configs.excel2json.lua_copost_time_point_event", package.seeall)

local lua_copost_time_point_event = {}
local fields = {
	id = 1,
	fightId = 2,
	allTextId = 7,
	chaEventId = 5,
	frontEventId = 3,
	eventId = 4,
	chaId = 8,
	coordinatesId = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.copost_time_point_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_copost_time_point_event, "configList", _configList)
	rawset(lua_copost_time_point_event, "configDict", _configDict)
end

setmetatable(lua_copost_time_point_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_copost_time_point_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_copost_time_point_event, "configList", nil)
	rawset(lua_copost_time_point_event, "configDict", nil)
end

return lua_copost_time_point_event
