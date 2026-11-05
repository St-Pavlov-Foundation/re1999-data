-- chunkname: @modules/configs/excel2json/lua_activity209_task.lua

module("modules.configs.excel2json.lua_activity209_task", package.seeall)

local lua_activity209_task = {}
local fields = {
	jumpId = 12,
	name = 5,
	isOnline = 3,
	episodeId = 11,
	prepose = 7,
	listenerType = 8,
	desc = 6,
	listenerParam = 9,
	minType = 4,
	id = 1,
	maxProgress = 10,
	activityId = 2,
	bonus = 13
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
local configPath = "configs.activity209_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity209_task, "configList", _configList)
	rawset(lua_activity209_task, "configDict", _configDict)
end

setmetatable(lua_activity209_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity209_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity209_task, "configList", nil)
	rawset(lua_activity209_task, "configDict", nil)
end

return lua_activity209_task
