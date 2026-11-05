-- chunkname: @modules/configs/excel2json/lua_activity144_task.lua

module("modules.configs.excel2json.lua_activity144_task", package.seeall)

local lua_activity144_task = {}
local fields = {
	jumpId = 10,
	name = 6,
	isOnline = 3,
	desc = 12,
	showType = 13,
	episodeId = 14,
	loopType = 4,
	listenerType = 7,
	listenerParam = 8,
	minType = 5,
	id = 1,
	maxProgress = 9,
	activityId = 2,
	bonus = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 3,
	minType = 2,
	loopType = 1,
	desc = 4
}
local _configList, _configDict
local configPath = "configs.activity144_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity144_task, "configList", _configList)
	rawset(lua_activity144_task, "configDict", _configDict)
end

setmetatable(lua_activity144_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity144_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity144_task, "configList", nil)
	rawset(lua_activity144_task, "configDict", nil)
end

return lua_activity144_task
