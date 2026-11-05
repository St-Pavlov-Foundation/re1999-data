-- chunkname: @modules/configs/excel2json/lua_atomic_polygon_task.lua

module("modules.configs.excel2json.lua_atomic_polygon_task", package.seeall)

local lua_atomic_polygon_task = {}
local fields = {
	score = 2,
	id = 1,
	special = 4,
	reward = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.atomic_polygon_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_atomic_polygon_task, "configList", _configList)
	rawset(lua_atomic_polygon_task, "configDict", _configDict)
end

setmetatable(lua_atomic_polygon_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_atomic_polygon_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_atomic_polygon_task, "configList", nil)
	rawset(lua_atomic_polygon_task, "configDict", nil)
end

return lua_atomic_polygon_task
