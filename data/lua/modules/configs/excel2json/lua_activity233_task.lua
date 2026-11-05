-- chunkname: @modules/configs/excel2json/lua_activity233_task.lua

module("modules.configs.excel2json.lua_activity233_task", package.seeall)

local lua_activity233_task = {}
local fields = {
	bonusScore = 17,
	name = 7,
	jumpId = 18,
	bonusMail = 15,
	endTime = 20,
	desc = 8,
	listenerParam = 10,
	bpId = 4,
	params = 16,
	openLimit = 14,
	maxProgress = 11,
	activityId = 2,
	sortId = 12,
	isOnline = 3,
	prepose = 13,
	loopType = 5,
	listenerType = 9,
	minType = 6,
	id = 1,
	startTime = 19
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
local configPath = "configs.activity233_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity233_task, "configList", _configList)
	rawset(lua_activity233_task, "configDict", _configDict)
end

setmetatable(lua_activity233_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity233_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity233_task, "configList", nil)
	rawset(lua_activity233_task, "configDict", nil)
end

return lua_activity233_task
