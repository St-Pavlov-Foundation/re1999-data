-- chunkname: @modules/configs/excel2json/lua_group_task.lua

module("modules.configs.excel2json.lua_group_task", package.seeall)

local lua_group_task = {}
local fields = {
	id = 1,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.group_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_group_task, "configList", _configList)
	rawset(lua_group_task, "configDict", _configDict)
end

setmetatable(lua_group_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_group_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_group_task, "configList", nil)
	rawset(lua_group_task, "configDict", nil)
end

return lua_group_task
