-- chunkname: @modules/configs/excel2json/lua_task_hide_achievement.lua

module("modules.configs.excel2json.lua_task_hide_achievement", package.seeall)

local lua_task_hide_achievement = {}
local fields = {
	name = 4,
	isOnline = 2,
	openLimit = 9,
	bonusMail = 7,
	maxFinishCount = 13,
	listenerType = 10,
	desc = 5,
	listenerParam = 11,
	minType = 3,
	needAccept = 6,
	params = 8,
	id = 1,
	maxProgress = 12,
	bonus = 14
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
local configPath = "configs.task_hide_achievement_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_task_hide_achievement, "configList", _configList)
	rawset(lua_task_hide_achievement, "configDict", _configDict)
end

setmetatable(lua_task_hide_achievement, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_task_hide_achievement.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_task_hide_achievement, "configList", nil)
	rawset(lua_task_hide_achievement, "configDict", nil)
end

return lua_task_hide_achievement
