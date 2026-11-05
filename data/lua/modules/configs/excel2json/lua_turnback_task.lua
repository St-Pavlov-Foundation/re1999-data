-- chunkname: @modules/configs/excel2json/lua_turnback_task.lua

module("modules.configs.excel2json.lua_turnback_task", package.seeall)

local lua_turnback_task = {}
local fields = {
	sortId = 11,
	name = 6,
	unlockDay = 17,
	type = 18,
	isOnlineTimeTask = 19,
	acceptNeedOnlineSeconds = 20,
	showDay = 21,
	desc = 7,
	listenerParam = 9,
	randomPriority = 23,
	params = 14,
	openLimit = 13,
	maxProgress = 10,
	jumpId = 15,
	isOnline = 3,
	turnbackTaskType = 22,
	jumpUi = 24,
	prepose = 12,
	loopType = 4,
	listenerType = 8,
	minType = 5,
	id = 1,
	turnbackId = 2,
	bonus = 16
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
local configPath = "configs.turnback_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_turnback_task, "configList", _configList)
	rawset(lua_turnback_task, "configDict", _configDict)
end

setmetatable(lua_turnback_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_turnback_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_turnback_task, "configList", nil)
	rawset(lua_turnback_task, "configDict", nil)
end

return lua_turnback_task
