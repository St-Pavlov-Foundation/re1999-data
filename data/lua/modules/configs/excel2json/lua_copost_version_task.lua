-- chunkname: @modules/configs/excel2json/lua_copost_version_task.lua

module("modules.configs.excel2json.lua_copost_version_task", package.seeall)

local lua_copost_version_task = {}
local fields = {
	jumpId = 10,
	activityid = 9,
	taskType = 3,
	desc = 6,
	versionId = 7,
	listenerType = 2,
	listenerParam = 4,
	id = 1,
	maxProgress = 5,
	bonus = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.copost_version_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_copost_version_task, "configList", _configList)
	rawset(lua_copost_version_task, "configDict", _configDict)
end

setmetatable(lua_copost_version_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_copost_version_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_copost_version_task, "configList", nil)
	rawset(lua_copost_version_task, "configDict", nil)
end

return lua_copost_version_task
