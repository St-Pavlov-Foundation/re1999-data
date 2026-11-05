-- chunkname: @modules/configs/excel2json/lua_activity114_event.lua

module("modules.configs.excel2json.lua_activity114_event", package.seeall)

local lua_activity114_event = {}
local fields = {
	checkOptionText = 6,
	isCheckEvent = 12,
	disposable = 11,
	successVerify = 13,
	battleId = 19,
	testId = 20,
	eventType = 4,
	successBattle = 17,
	activityId = 1,
	isTransition = 21,
	param = 5,
	storyId = 3,
	threshold = 10,
	checkAttribute = 8,
	condition = 18,
	nonOptionText = 7,
	failureStoryId = 16,
	id = 2,
	failureVerify = 15,
	successStoryId = 14,
	checkfeatures = 9
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	checkOptionText = 1,
	nonOptionText = 2
}
local _configList, _configDict
local configPath = "configs.activity114_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity114_event, "configList", _configList)
	rawset(lua_activity114_event, "configDict", _configDict)
end

setmetatable(lua_activity114_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity114_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity114_event, "configList", nil)
	rawset(lua_activity114_event, "configDict", nil)
end

return lua_activity114_event
