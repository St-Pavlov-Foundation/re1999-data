-- chunkname: @modules/configs/excel2json/lua_activity191_event.lua

module("modules.configs.excel2json.lua_activity191_event", package.seeall)

local lua_activity191_event = {}
local fields = {
	skinId = 10,
	outDesc = 6,
	type = 3,
	title = 5,
	offset = 11,
	desc = 7,
	rewardView = 9,
	task = 8,
	id = 1,
	stage = 4,
	activityId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	outDesc = 2,
	title = 1,
	task = 4,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.activity191_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity191_event, "configList", _configList)
	rawset(lua_activity191_event, "configDict", _configDict)
end

setmetatable(lua_activity191_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity191_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity191_event, "configList", nil)
	rawset(lua_activity191_event, "configDict", nil)
end

return lua_activity191_event
