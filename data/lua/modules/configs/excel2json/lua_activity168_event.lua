-- chunkname: @modules/configs/excel2json/lua_activity168_event.lua

module("modules.configs.excel2json.lua_activity168_event", package.seeall)

local lua_activity168_event = {}
local fields = {
	optionIds = 4,
	eventId = 2,
	activityId = 1,
	name = 3
}
local primaryKey = {
	"activityId",
	"eventId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity168_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity168_event, "configList", _configList)
	rawset(lua_activity168_event, "configDict", _configDict)
end

setmetatable(lua_activity168_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity168_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity168_event, "configList", nil)
	rawset(lua_activity168_event, "configDict", nil)
end

return lua_activity168_event
