-- chunkname: @modules/configs/excel2json/lua_odyssey_map_task.lua

module("modules.configs.excel2json.lua_odyssey_map_task", package.seeall)

local lua_odyssey_map_task = {}
local fields = {
	elementList = 2,
	taskDesc = 4,
	taskTitle = 3,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	taskTitle = 1,
	taskDesc = 2
}
local _configList, _configDict
local configPath = "configs.odyssey_map_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_odyssey_map_task, "configList", _configList)
	rawset(lua_odyssey_map_task, "configDict", _configDict)
end

setmetatable(lua_odyssey_map_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_odyssey_map_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_odyssey_map_task, "configList", nil)
	rawset(lua_odyssey_map_task, "configDict", nil)
end

return lua_odyssey_map_task
