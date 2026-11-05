-- chunkname: @modules/configs/excel2json/lua_act173_global_task.lua

module("modules.configs.excel2json.lua_act173_global_task", package.seeall)

local lua_act173_global_task = {}
local fields = {
	id = 2,
	endValue = 3,
	activityId = 1,
	isVisible = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.act173_global_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_act173_global_task, "configList", _configList)
	rawset(lua_act173_global_task, "configDict", _configDict)
end

setmetatable(lua_act173_global_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_act173_global_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_act173_global_task, "configList", nil)
	rawset(lua_act173_global_task, "configDict", nil)
end

return lua_act173_global_task
