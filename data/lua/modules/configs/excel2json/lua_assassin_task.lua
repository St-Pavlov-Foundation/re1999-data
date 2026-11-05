-- chunkname: @modules/configs/excel2json/lua_assassin_task.lua

module("modules.configs.excel2json.lua_assassin_task", package.seeall)

local lua_assassin_task = {}
local fields = {
	jumpId = 13,
	name = 5,
	isOnline = 3,
	bonusMail = 7,
	maxFinishCount = 12,
	listenerType = 9,
	id = 1,
	desc = 6,
	listenerParam = 10,
	minType = 4,
	openLimit = 8,
	maxProgress = 11,
	activityId = 2,
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
local configPath = "configs.assassin_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_task, "configList", _configList)
	rawset(lua_assassin_task, "configDict", _configDict)
end

setmetatable(lua_assassin_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_task, "configList", nil)
	rawset(lua_assassin_task, "configDict", nil)
end

return lua_assassin_task
