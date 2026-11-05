-- chunkname: @modules/configs/excel2json/lua_activity210_task.lua

module("modules.configs.excel2json.lua_activity210_task", package.seeall)

local lua_activity210_task = {}
local fields = {
	jumpId = 11,
	isOnline = 3,
	name = 5,
	episodeId = 10,
	listenerType = 7,
	desc = 6,
	listenerParam = 8,
	minType = 4,
	id = 1,
	maxProgress = 9,
	activityId = 2,
	bonus = 12
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
local configPath = "configs.activity210_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity210_task, "configList", _configList)
	rawset(lua_activity210_task, "configDict", _configDict)
end

setmetatable(lua_activity210_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity210_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity210_task, "configList", nil)
	rawset(lua_activity210_task, "configDict", nil)
end

return lua_activity210_task
