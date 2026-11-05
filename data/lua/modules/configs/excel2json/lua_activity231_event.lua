-- chunkname: @modules/configs/excel2json/lua_activity231_event.lua

module("modules.configs.excel2json.lua_activity231_event", package.seeall)

local lua_activity231_event = {}
local fields = {
	effect = 7,
	name = 4,
	button = 6,
	weight = 8,
	id = 2,
	unlockCondition = 3,
	activityId = 1,
	desc = 5
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1,
	button = 3,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.activity231_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity231_event, "configList", _configList)
	rawset(lua_activity231_event, "configDict", _configDict)
end

setmetatable(lua_activity231_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity231_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity231_event, "configList", nil)
	rawset(lua_activity231_event, "configDict", nil)
end

return lua_activity231_event
