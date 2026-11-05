-- chunkname: @modules/configs/excel2json/lua_activity130_task.lua

module("modules.configs.excel2json.lua_activity130_task", package.seeall)

local lua_activity130_task = {}
local fields = {
	jumpId = 10,
	name = 5,
	episodeId = 9,
	isOnline = 3,
	loopType = 4,
	listenerType = 6,
	listenerParam = 7,
	id = 1,
	maxProgress = 8,
	activityId = 2,
	bonus = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	loopType = 1,
	name = 2
}
local _configList, _configDict
local configPath = "configs.activity130_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity130_task, "configList", _configList)
	rawset(lua_activity130_task, "configDict", _configDict)
end

setmetatable(lua_activity130_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity130_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity130_task, "configList", nil)
	rawset(lua_activity130_task, "configDict", nil)
end

return lua_activity130_task
