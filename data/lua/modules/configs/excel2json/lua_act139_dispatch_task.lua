-- chunkname: @modules/configs/excel2json/lua_act139_dispatch_task.lua

module("modules.configs.excel2json.lua_act139_dispatch_task", package.seeall)

local lua_act139_dispatch_task = {}
local fields = {
	id = 1,
	desc = 9,
	time = 5,
	image = 10,
	title = 8,
	extraParam = 7,
	elementId = 11,
	shortType = 6,
	minCount = 3,
	maxCount = 4,
	activityId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.act139_dispatch_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_act139_dispatch_task, "configList", _configList)
	rawset(lua_act139_dispatch_task, "configDict", _configDict)
end

setmetatable(lua_act139_dispatch_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_act139_dispatch_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_act139_dispatch_task, "configList", nil)
	rawset(lua_act139_dispatch_task, "configDict", nil)
end

return lua_act139_dispatch_task
