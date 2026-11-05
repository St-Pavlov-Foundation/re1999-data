-- chunkname: @modules/configs/excel2json/lua_activity163_task.lua

module("modules.configs.excel2json.lua_activity163_task", package.seeall)

local lua_activity163_task = {}
local fields = {
	jumpId = 10,
	isOnline = 3,
	episodeId = 9,
	name = 5,
	listenerType = 6,
	listenerParam = 7,
	minType = 4,
	id = 1,
	maxProgress = 8,
	activityId = 2,
	bonus = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1
}
local _configList, _configDict
local configPath = "configs.activity163_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity163_task, "configList", _configList)
	rawset(lua_activity163_task, "configDict", _configDict)
end

setmetatable(lua_activity163_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity163_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity163_task, "configList", nil)
	rawset(lua_activity163_task, "configDict", nil)
end

return lua_activity163_task
