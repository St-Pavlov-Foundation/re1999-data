-- chunkname: @modules/configs/excel2json/lua_activity144_record_event.lua

module("modules.configs.excel2json.lua_activity144_record_event", package.seeall)

local lua_activity144_record_event = {}
local fields = {
	eventIds = 5,
	name = 3,
	unLockDesc = 4,
	recordId = 2,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"recordId"
}
local mlStringKey = {
	unLockDesc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity144_record_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity144_record_event, "configList", _configList)
	rawset(lua_activity144_record_event, "configDict", _configDict)
end

setmetatable(lua_activity144_record_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity144_record_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity144_record_event, "configList", nil)
	rawset(lua_activity144_record_event, "configDict", nil)
end

return lua_activity144_record_event
