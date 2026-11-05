-- chunkname: @modules/configs/excel2json/lua_activity_nuodika_180_event.lua

module("modules.configs.excel2json.lua_activity_nuodika_180_event", package.seeall)

local lua_activity_nuodika_180_event = {}
local fields = {
	initVisible = 4,
	eventId = 1,
	eventParam = 3,
	eventType = 2
}
local primaryKey = {
	"eventId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity_nuodika_180_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity_nuodika_180_event, "configList", _configList)
	rawset(lua_activity_nuodika_180_event, "configDict", _configDict)
end

setmetatable(lua_activity_nuodika_180_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity_nuodika_180_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity_nuodika_180_event, "configList", nil)
	rawset(lua_activity_nuodika_180_event, "configDict", nil)
end

return lua_activity_nuodika_180_event
