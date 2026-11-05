-- chunkname: @modules/configs/excel2json/lua_activity144_event.lua

module("modules.configs.excel2json.lua_activity144_event", package.seeall)

local lua_activity144_event = {}
local fields = {
	eventId = 2,
	name = 6,
	eventType = 7,
	optionIds = 3,
	picture = 4,
	activityId = 1,
	desc = 5
}
local primaryKey = {
	"activityId",
	"eventId"
}
local mlStringKey = {
	name = 2,
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity144_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity144_event, "configList", _configList)
	rawset(lua_activity144_event, "configDict", _configDict)
end

setmetatable(lua_activity144_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity144_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity144_event, "configList", nil)
	rawset(lua_activity144_event, "configDict", nil)
end

return lua_activity144_event
