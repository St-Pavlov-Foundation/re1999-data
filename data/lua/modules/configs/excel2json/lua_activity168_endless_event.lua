-- chunkname: @modules/configs/excel2json/lua_activity168_endless_event.lua

module("modules.configs.excel2json.lua_activity168_endless_event", package.seeall)

local lua_activity168_endless_event = {}
local fields = {
	id = 2,
	scene = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity168_endless_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity168_endless_event, "configList", _configList)
	rawset(lua_activity168_endless_event, "configDict", _configDict)
end

setmetatable(lua_activity168_endless_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity168_endless_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity168_endless_event, "configList", nil)
	rawset(lua_activity168_endless_event, "configDict", nil)
end

return lua_activity168_endless_event
