-- chunkname: @modules/configs/excel2json/lua_activity194_event.lua

module("modules.configs.excel2json.lua_activity194_event", package.seeall)

local lua_activity194_event = {}
local fields = {
	desc = 7,
	name = 5,
	picture = 4,
	eventGroup = 2,
	eventType = 9,
	eventId = 1,
	trigger = 3,
	number = 6,
	optionIds = 8,
	position = 10
}
local primaryKey = {
	"eventId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity194_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity194_event, "configList", _configList)
	rawset(lua_activity194_event, "configDict", _configDict)
end

setmetatable(lua_activity194_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity194_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity194_event, "configList", nil)
	rawset(lua_activity194_event, "configDict", nil)
end

return lua_activity194_event
