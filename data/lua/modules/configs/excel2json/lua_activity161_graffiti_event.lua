-- chunkname: @modules/configs/excel2json/lua_activity161_graffiti_event.lua

module("modules.configs.excel2json.lua_activity161_graffiti_event", package.seeall)

local lua_activity161_graffiti_event = {}
local fields = {
	elementId = 2,
	cd = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"elementId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity161_graffiti_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity161_graffiti_event, "configList", _configList)
	rawset(lua_activity161_graffiti_event, "configDict", _configDict)
end

setmetatable(lua_activity161_graffiti_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity161_graffiti_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity161_graffiti_event, "configList", nil)
	rawset(lua_activity161_graffiti_event, "configDict", nil)
end

return lua_activity161_graffiti_event
