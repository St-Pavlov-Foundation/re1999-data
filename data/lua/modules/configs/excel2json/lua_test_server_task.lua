-- chunkname: @modules/configs/excel2json/lua_test_server_task.lua

module("modules.configs.excel2json.lua_test_server_task", package.seeall)

local lua_test_server_task = {}
local fields = {
	sortId = 10,
	name = 5,
	endTime = 17,
	bonusMail = 13,
	bonus = 18,
	desc = 6,
	listenerParam = 8,
	params = 14,
	openLimit = 12,
	maxProgress = 9,
	activityId = 19,
	jumpId = 15,
	isOnline = 2,
	prepose = 11,
	loopType = 3,
	listenerType = 7,
	minType = 4,
	id = 1,
	startTime = 16
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
local configPath = "configs.test_server_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_test_server_task, "configList", _configList)
	rawset(lua_test_server_task, "configDict", _configDict)
end

setmetatable(lua_test_server_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_test_server_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_test_server_task, "configList", nil)
	rawset(lua_test_server_task, "configDict", nil)
end

return lua_test_server_task
