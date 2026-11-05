-- chunkname: @modules/configs/excel2json/lua_activity119_task.lua

module("modules.configs.excel2json.lua_activity119_task", package.seeall)

local lua_activity119_task = {}
local fields = {
	desc = 8,
	isOnline = 6,
	bonusMail = 9,
	tabId = 4,
	openLimit = 10,
	listenerType = 11,
	bonus = 14,
	day = 3,
	listenerParam = 12,
	minType = 7,
	id = 1,
	maxProgress = 13,
	activityId = 2,
	sort = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	minType = 1
}
local _configList, _configDict
local configPath = "configs.activity119_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity119_task, "configList", _configList)
	rawset(lua_activity119_task, "configDict", _configDict)
end

setmetatable(lua_activity119_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity119_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity119_task, "configList", nil)
	rawset(lua_activity119_task, "configDict", nil)
end

return lua_activity119_task
