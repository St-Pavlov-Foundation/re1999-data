-- chunkname: @modules/configs/excel2json/lua_activity216_only_one_tasks.lua

module("modules.configs.excel2json.lua_activity216_only_one_tasks", package.seeall)

local lua_activity216_only_one_tasks = {}
local fields = {
	tips = 5,
	taskIds = 3,
	id = 1,
	activityId = 2,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity216_only_one_tasks_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity216_only_one_tasks, "configList", _configList)
	rawset(lua_activity216_only_one_tasks, "configDict", _configDict)
end

setmetatable(lua_activity216_only_one_tasks, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity216_only_one_tasks.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity216_only_one_tasks, "configList", nil)
	rawset(lua_activity216_only_one_tasks, "configDict", nil)
end

return lua_activity216_only_one_tasks
