-- chunkname: @modules/configs/excel2json/lua_activity125_task.lua

module("modules.configs.excel2json.lua_activity125_task", package.seeall)

local lua_activity125_task = {}
local fields = {
	jumpId = 15,
	name = 5,
	isOnline = 3,
	bonusMail = 7,
	listenerType = 9,
	tag = 12,
	maxProgress = 14,
	desc = 6,
	listenerParam = 10,
	minType = 4,
	id = 1,
	clientlistenerParam = 11,
	openLimit = 8,
	sorting = 13,
	activityId = 2,
	bonus = 16
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
local configPath = "configs.activity125_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity125_task, "configList", _configList)
	rawset(lua_activity125_task, "configDict", _configDict)
end

setmetatable(lua_activity125_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity125_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity125_task, "configList", nil)
	rawset(lua_activity125_task, "configDict", nil)
end

return lua_activity125_task
