-- chunkname: @modules/configs/excel2json/lua_task_activity_show.lua

module("modules.configs.excel2json.lua_task_activity_show", package.seeall)

local lua_task_activity_show = {}
local fields = {
	activity = 10,
	name = 4,
	isOnline = 2,
	bonusMail = 14,
	maxFinishCount = 9,
	jumpId = 19,
	desc = 5,
	listenerParam = 7,
	needAccept = 17,
	params = 15,
	openLimit = 13,
	maxProgress = 8,
	activityId = 20,
	sortId = 11,
	priority = 16,
	prepose = 12,
	listenerType = 6,
	minType = 3,
	id = 1,
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
local configPath = "configs.task_activity_show_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_task_activity_show, "configList", _configList)
	rawset(lua_task_activity_show, "configDict", _configDict)
end

setmetatable(lua_task_activity_show, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_task_activity_show.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_task_activity_show, "configList", nil)
	rawset(lua_task_activity_show, "configDict", nil)
end

return lua_task_activity_show
