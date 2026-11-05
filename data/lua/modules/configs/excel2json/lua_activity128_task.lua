-- chunkname: @modules/configs/excel2json/lua_activity128_task.lua

module("modules.configs.excel2json.lua_activity128_task", package.seeall)

local lua_activity128_task = {}
local fields = {
	achievementRes = 4,
	name = 8,
	stage = 3,
	bonusMail = 11,
	maxFinishCount = 17,
	activity = 18,
	desc = 9,
	listenerParam = 15,
	needAccept = 10,
	params = 12,
	openLimit = 13,
	maxProgress = 16,
	activityId = 2,
	jumpId = 19,
	isOnline = 5,
	totalTaskType = 6,
	listenerType = 14,
	minType = 7,
	id = 1,
	bonus = 20
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
local configPath = "configs.activity128_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity128_task, "configList", _configList)
	rawset(lua_activity128_task, "configDict", _configDict)
end

setmetatable(lua_activity128_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity128_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity128_task, "configList", nil)
	rawset(lua_activity128_task, "configDict", nil)
end

return lua_activity128_task
