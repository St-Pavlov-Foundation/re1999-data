-- chunkname: @modules/configs/excel2json/lua_activity246_task.lua

module("modules.configs.excel2json.lua_activity246_task", package.seeall)

local lua_activity246_task = {}
local fields = {
	activityId = 2,
	name = 7,
	openLimit = 10,
	bonusMail = 9,
	desc = 8,
	listenerParam = 12,
	clientlistenerParam = 14,
	tag = 15,
	maxProgress = 13,
	openLimitActId = 16,
	jumpId = 18,
	isOnline = 3,
	canFinishDays = 5,
	prepose = 20,
	loopType = 4,
	listenerType = 11,
	minType = 6,
	id = 1,
	sorting = 17,
	bonus = 19
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tag = 4,
	minType = 1,
	name = 2,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.activity246_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity246_task, "configList", _configList)
	rawset(lua_activity246_task, "configDict", _configDict)
end

setmetatable(lua_activity246_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity246_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity246_task, "configList", nil)
	rawset(lua_activity246_task, "configDict", nil)
end

return lua_activity246_task
