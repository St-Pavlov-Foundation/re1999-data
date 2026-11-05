-- chunkname: @modules/configs/excel2json/lua_activity133_task.lua

module("modules.configs.excel2json.lua_activity133_task", package.seeall)

local lua_activity133_task = {}
local fields = {
	sortId = 11,
	name = 6,
	isOnline = 3,
	listenerType = 8,
	prepose = 12,
	openLimit = 13,
	loopType = 4,
	desc = 7,
	listenerParam = 9,
	minType = 5,
	jumpId = 15,
	params = 14,
	id = 1,
	maxProgress = 10,
	activityId = 2,
	bonus = 16
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
local configPath = "configs.activity133_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity133_task, "configList", _configList)
	rawset(lua_activity133_task, "configDict", _configDict)
end

setmetatable(lua_activity133_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity133_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity133_task, "configList", nil)
	rawset(lua_activity133_task, "configDict", nil)
end

return lua_activity133_task
