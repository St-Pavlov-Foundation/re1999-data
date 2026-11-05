-- chunkname: @modules/configs/excel2json/lua_task_explore.lua

module("modules.configs.excel2json.lua_task_explore", package.seeall)

local lua_task_explore = {}
local fields = {
	listenerType = 5,
	isOnline = 2,
	name = 3,
	display = 9,
	desc = 4,
	listenerParam = 6,
	id = 1,
	maxProgress = 7,
	bonus = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.task_explore_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_task_explore, "configList", _configList)
	rawset(lua_task_explore, "configDict", _configDict)
end

setmetatable(lua_task_explore, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_task_explore.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_task_explore, "configList", nil)
	rawset(lua_task_explore, "configDict", nil)
end

return lua_task_explore
