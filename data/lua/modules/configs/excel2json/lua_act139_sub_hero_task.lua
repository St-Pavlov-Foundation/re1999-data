-- chunkname: @modules/configs/excel2json/lua_act139_sub_hero_task.lua

module("modules.configs.excel2json.lua_act139_sub_hero_task", package.seeall)

local lua_act139_sub_hero_task = {}
local fields = {
	reward = 8,
	descSuffix = 7,
	desc = 6,
	storyId = 3,
	title = 4,
	image = 5,
	unlockParam = 11,
	taskId = 2,
	lockDesc = 12,
	unlockType = 10,
	id = 1,
	elementIds = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	descSuffix = 3,
	title = 1,
	lockDesc = 4,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.act139_sub_hero_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_act139_sub_hero_task, "configList", _configList)
	rawset(lua_act139_sub_hero_task, "configDict", _configDict)
end

setmetatable(lua_act139_sub_hero_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_act139_sub_hero_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_act139_sub_hero_task, "configList", nil)
	rawset(lua_act139_sub_hero_task, "configDict", nil)
end

return lua_act139_sub_hero_task
