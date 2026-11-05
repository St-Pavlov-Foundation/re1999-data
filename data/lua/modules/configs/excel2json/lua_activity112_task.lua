-- chunkname: @modules/configs/excel2json/lua_activity112_task.lua

module("modules.configs.excel2json.lua_activity112_task", package.seeall)

local lua_activity112_task = {}
local fields = {
	jumpId = 11,
	isOnline = 3,
	listenerType = 6,
	bonus = 10,
	desc = 5,
	taskId = 2,
	listenerParam = 7,
	minTypeId = 4,
	maxProgress = 8,
	activityId = 1,
	sort = 9
}
local primaryKey = {
	"activityId",
	"taskId"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity112_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity112_task, "configList", _configList)
	rawset(lua_activity112_task, "configDict", _configDict)
end

setmetatable(lua_activity112_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity112_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity112_task, "configList", nil)
	rawset(lua_activity112_task, "configDict", nil)
end

return lua_activity112_task
