-- chunkname: @modules/configs/excel2json/lua_copost_catch_task.lua

module("modules.configs.excel2json.lua_copost_catch_task", package.seeall)

local lua_copost_catch_task = {}
local fields = {
	jumpId = 10,
	isOnline = 4,
	listenerType = 5,
	desc = 8,
	finishNum = 3,
	taskType = 2,
	listenerParam = 6,
	id = 1,
	maxProgress = 7,
	bonus = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.copost_catch_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_copost_catch_task, "configList", _configList)
	rawset(lua_copost_catch_task, "configDict", _configDict)
end

setmetatable(lua_copost_catch_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_copost_catch_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_copost_catch_task, "configList", nil)
	rawset(lua_copost_catch_task, "configDict", nil)
end

return lua_copost_catch_task
