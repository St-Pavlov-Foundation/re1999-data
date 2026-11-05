-- chunkname: @modules/configs/excel2json/lua_role_activity_task.lua

module("modules.configs.excel2json.lua_role_activity_task", package.seeall)

local lua_role_activity_task = {}
local fields = {
	taskDesc = 5,
	name = 4,
	jumpid = 10,
	listenerType = 6,
	listenerParam = 7,
	minType = 3,
	id = 2,
	maxProgress = 8,
	activityId = 1,
	bonus = 9
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	taskDesc = 3
}
local _configList, _configDict
local configPath = "configs.role_activity_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_role_activity_task, "configList", _configList)
	rawset(lua_role_activity_task, "configDict", _configDict)
end

setmetatable(lua_role_activity_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_role_activity_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_role_activity_task, "configList", nil)
	rawset(lua_role_activity_task, "configDict", nil)
end

return lua_role_activity_task
