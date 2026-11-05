-- chunkname: @modules/configs/excel2json/lua_fight_task.lua

module("modules.configs.excel2json.lua_fight_task", package.seeall)

local lua_fight_task = {}
local fields = {
	taskParam1 = 3,
	taskParam2 = 5,
	sysParam4 = 10,
	taskParam3 = 7,
	condition = 2,
	taskParam4 = 9,
	sysParam2 = 6,
	sysParam1 = 4,
	id = 1,
	sysParam3 = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_task, "configList", _configList)
	rawset(lua_fight_task, "configDict", _configDict)
end

setmetatable(lua_fight_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_task, "configList", nil)
	rawset(lua_fight_task, "configDict", nil)
end

return lua_fight_task
