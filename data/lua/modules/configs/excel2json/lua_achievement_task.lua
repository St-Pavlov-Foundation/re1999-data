-- chunkname: @modules/configs/excel2json/lua_achievement_task.lua

module("modules.configs.excel2json.lua_achievement_task", package.seeall)

local lua_achievement_task = {}
local fields = {
	sortId = 8,
	listenerType = 5,
	achievementId = 2,
	extraDesc = 4,
	icon = 10,
	image = 11,
	desc = 3,
	listenerParam = 6,
	id = 1,
	maxProgress = 7,
	level = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	extraDesc = 2,
	desc = 1
}
local _configList, _configDict
local configPath = "configs.achievement_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_achievement_task, "configList", _configList)
	rawset(lua_achievement_task, "configDict", _configDict)
end

setmetatable(lua_achievement_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_achievement_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_achievement_task, "configList", nil)
	rawset(lua_achievement_task, "configDict", nil)
end

return lua_achievement_task
