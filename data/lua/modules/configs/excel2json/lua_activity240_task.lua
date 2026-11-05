-- chunkname: @modules/configs/excel2json/lua_activity240_task.lua

module("modules.configs.excel2json.lua_activity240_task", package.seeall)

local lua_activity240_task = {}
local fields = {
	sortId = 11,
	name = 6,
	isOnline = 3,
	listenerType = 8,
	prepose = 12,
	openLimit = 13,
	loopType = 4,
	desc = 7,
	listenerParam = 9,
	minType = 5,
	jumpId = 14,
	id = 1,
	maxProgress = 10,
	activityId = 2,
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
local configPath = "configs.activity240_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity240_task, "configList", _configList)
	rawset(lua_activity240_task, "configDict", _configDict)
end

setmetatable(lua_activity240_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity240_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity240_task, "configList", nil)
	rawset(lua_activity240_task, "configDict", nil)
end

return lua_activity240_task
