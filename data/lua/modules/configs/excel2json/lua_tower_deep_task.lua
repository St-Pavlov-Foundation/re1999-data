-- chunkname: @modules/configs/excel2json/lua_tower_deep_task.lua

module("modules.configs.excel2json.lua_tower_deep_task", package.seeall)

local lua_tower_deep_task = {}
local fields = {
	jumpId = 11,
	isOnline = 2,
	id = 1,
	bonusMail = 6,
	name = 4,
	listenerType = 8,
	desc = 5,
	listenerParam = 9,
	minType = 3,
	openLimit = 7,
	maxProgress = 10,
	bonus = 12
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
local configPath = "configs.tower_deep_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_deep_task, "configList", _configList)
	rawset(lua_tower_deep_task, "configDict", _configDict)
end

setmetatable(lua_tower_deep_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_deep_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_deep_task, "configList", nil)
	rawset(lua_tower_deep_task, "configDict", nil)
end

return lua_tower_deep_task
