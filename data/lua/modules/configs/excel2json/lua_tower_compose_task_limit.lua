-- chunkname: @modules/configs/excel2json/lua_tower_compose_task_limit.lua

module("modules.configs.excel2json.lua_tower_compose_task_limit", package.seeall)

local lua_tower_compose_task_limit = {}
local fields = {
	startTime = 3,
	taskGroupId = 1,
	endTime = 4,
	queryVersion = 2
}
local primaryKey = {
	"taskGroupId",
	"queryVersion"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.tower_compose_task_limit_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_compose_task_limit, "configList", _configList)
	rawset(lua_tower_compose_task_limit, "configDict", _configDict)
end

setmetatable(lua_tower_compose_task_limit, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_compose_task_limit.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_compose_task_limit, "configList", nil)
	rawset(lua_tower_compose_task_limit, "configDict", nil)
end

return lua_tower_compose_task_limit
