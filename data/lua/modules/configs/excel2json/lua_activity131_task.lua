-- chunkname: @modules/configs/excel2json/lua_activity131_task.lua

module("modules.configs.excel2json.lua_activity131_task", package.seeall)

local lua_activity131_task = {}
local fields = {
	jumpId = 9,
	name = 5,
	isOnline = 3,
	loopType = 4,
	listenerType = 6,
	listenerParam = 7,
	id = 1,
	maxProgress = 8,
	activityId = 2,
	bonus = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	loopType = 1,
	name = 2
}
local _configList, _configDict
local configPath = "configs.activity131_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity131_task, "configList", _configList)
	rawset(lua_activity131_task, "configDict", _configDict)
end

setmetatable(lua_activity131_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity131_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity131_task, "configList", nil)
	rawset(lua_activity131_task, "configDict", nil)
end

return lua_activity131_task
