-- chunkname: @modules/configs/excel2json/lua_activity173_task.lua

module("modules.configs.excel2json.lua_activity173_task", package.seeall)

local lua_activity173_task = {}
local fields = {
	sortId = 9,
	name = 4,
	bonusMail = 12,
	desc = 5,
	listenerParam = 7,
	params = 13,
	openLimit = 11,
	maxProgress = 8,
	activityId = 16,
	showBonus = 18,
	jumpId = 15,
	isOnline = 2,
	prepose = 10,
	source = 17,
	listenerType = 6,
	minType = 3,
	id = 1,
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
local configPath = "configs.activity173_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity173_task, "configList", _configList)
	rawset(lua_activity173_task, "configDict", _configDict)
end

setmetatable(lua_activity173_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity173_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity173_task, "configList", nil)
	rawset(lua_activity173_task, "configDict", nil)
end

return lua_activity173_task
