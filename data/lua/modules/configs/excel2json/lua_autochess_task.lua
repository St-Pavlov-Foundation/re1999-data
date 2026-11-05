-- chunkname: @modules/configs/excel2json/lua_autochess_task.lua

module("modules.configs.excel2json.lua_autochess_task", package.seeall)

local lua_autochess_task = {}
local fields = {
	jumpId = 12,
	name = 5,
	isOnline = 3,
	bonusMail = 7,
	listenerType = 9,
	id = 1,
	desc = 6,
	listenerParam = 10,
	minType = 4,
	openLimit = 8,
	maxProgress = 11,
	activityId = 2,
	bonus = 13
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
local configPath = "configs.autochess_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_autochess_task, "configList", _configList)
	rawset(lua_autochess_task, "configDict", _configDict)
end

setmetatable(lua_autochess_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_autochess_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_autochess_task, "configList", nil)
	rawset(lua_autochess_task, "configDict", nil)
end

return lua_autochess_task
