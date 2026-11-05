-- chunkname: @modules/configs/excel2json/lua_tower_compose_task.lua

module("modules.configs.excel2json.lua_tower_compose_task", package.seeall)

local lua_tower_compose_task = {}
local fields = {
	bonus = 16,
	name = 7,
	listenerType = 12,
	bonusMail = 9,
	params = 18,
	pointBonus = 17,
	desc = 8,
	listenerParam = 13,
	endTime = 11,
	maxProgress = 14,
	jumpId = 15,
	isOnline = 5,
	taskType = 3,
	minType = 6,
	minTypeId = 4,
	id = 1,
	taskGroupId = 2,
	startTime = 10
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
local configPath = "configs.tower_compose_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_compose_task, "configList", _configList)
	rawset(lua_tower_compose_task, "configDict", _configDict)
end

setmetatable(lua_tower_compose_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_compose_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_compose_task, "configList", nil)
	rawset(lua_tower_compose_task, "configDict", nil)
end

return lua_tower_compose_task
