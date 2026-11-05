-- chunkname: @modules/configs/excel2json/lua_odyssey_task.lua

module("modules.configs.excel2json.lua_odyssey_task", package.seeall)

local lua_odyssey_task = {}
local fields = {
	jumpId = 13,
	name = 6,
	openLimit = 9,
	bonusMail = 8,
	listenerType = 10,
	maxProgress = 12,
	isOnline = 4,
	desc = 7,
	listenerParam = 11,
	minType = 5,
	isKeyReward = 15,
	id = 1,
	taskGroupId = 3,
	activityId = 2,
	bonus = 14
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
local configPath = "configs.odyssey_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_odyssey_task, "configList", _configList)
	rawset(lua_odyssey_task, "configDict", _configDict)
end

setmetatable(lua_odyssey_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_odyssey_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_odyssey_task, "configList", nil)
	rawset(lua_odyssey_task, "configDict", nil)
end

return lua_odyssey_task
