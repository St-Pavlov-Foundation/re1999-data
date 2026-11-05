-- chunkname: @modules/configs/excel2json/lua_activity189_task.lua

module("modules.configs.excel2json.lua_activity189_task", package.seeall)

local lua_activity189_task = {}
local fields = {
	openLimitActId = 14,
	name = 6,
	openLimit = 9,
	bonusMail = 8,
	desc = 7,
	listenerParam = 11,
	clientlistenerParam = 12,
	tag = 13,
	maxProgress = 16,
	activityId = 2,
	jumpId = 17,
	isOnline = 3,
	loopType = 4,
	listenerType = 10,
	minType = 5,
	id = 1,
	sorting = 15,
	bonus = 18
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
local configPath = "configs.activity189_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity189_task, "configList", _configList)
	rawset(lua_activity189_task, "configDict", _configDict)
end

setmetatable(lua_activity189_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity189_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity189_task, "configList", nil)
	rawset(lua_activity189_task, "configDict", nil)
end

return lua_activity189_task
