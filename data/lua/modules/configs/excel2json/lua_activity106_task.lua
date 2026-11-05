-- chunkname: @modules/configs/excel2json/lua_activity106_task.lua

module("modules.configs.excel2json.lua_activity106_task", package.seeall)

local lua_activity106_task = {}
local fields = {
	orderid = 17,
	name = 5,
	bonusMail = 8,
	maxFinishCount = 14,
	desc = 6,
	listenerParam = 12,
	needAccept = 7,
	params = 9,
	openLimit = 10,
	maxProgress = 13,
	activityId = 2,
	openDay = 16,
	isOnline = 3,
	listenerType = 11,
	minType = 4,
	id = 1,
	bonus = 15
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.activity106_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity106_task, "configList", _configList)
	rawset(lua_activity106_task, "configDict", _configDict)
end

setmetatable(lua_activity106_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity106_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity106_task, "configList", nil)
	rawset(lua_activity106_task, "configDict", nil)
end

return lua_activity106_task
