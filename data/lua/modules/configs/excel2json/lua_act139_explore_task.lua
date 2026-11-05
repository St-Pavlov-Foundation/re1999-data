-- chunkname: @modules/configs/excel2json/lua_act139_explore_task.lua

module("modules.configs.excel2json.lua_act139_explore_task", package.seeall)

local lua_act139_explore_task = {}
local fields = {
	storyId = 4,
	unlockParam = 12,
	unlockDesc = 13,
	type = 3,
	unlockToastDesc = 14,
	title = 5,
	pos = 9,
	desc = 7,
	unlockLineNumbers = 15,
	unlockType = 11,
	areaPos = 8,
	titleEn = 6,
	id = 1,
	activityId = 2,
	elementIds = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	unlockDesc = 3,
	title = 1,
	unlockToastDesc = 4,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.act139_explore_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_act139_explore_task, "configList", _configList)
	rawset(lua_act139_explore_task, "configDict", _configDict)
end

setmetatable(lua_act139_explore_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_act139_explore_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_act139_explore_task, "configList", nil)
	rawset(lua_act139_explore_task, "configDict", nil)
end

return lua_act139_explore_task
