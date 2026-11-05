-- chunkname: @modules/configs/excel2json/lua_activity114_task.lua

module("modules.configs.excel2json.lua_activity114_task", package.seeall)

local lua_activity114_task = {}
local fields = {
	listenerParam = 6,
	listenerType = 5,
	desc = 4,
	minTypeId = 3,
	bonus = 8,
	maxProgress = 7,
	activityId = 1,
	taskId = 2
}
local primaryKey = {
	"activityId",
	"taskId"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity114_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity114_task, "configList", _configList)
	rawset(lua_activity114_task, "configDict", _configDict)
end

setmetatable(lua_activity114_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity114_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity114_task, "configList", nil)
	rawset(lua_activity114_task, "configDict", nil)
end

return lua_activity114_task
