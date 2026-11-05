-- chunkname: @modules/configs/excel2json/lua_rogue_collecion_unlock_task.lua

module("modules.configs.excel2json.lua_rogue_collecion_unlock_task", package.seeall)

local lua_rogue_collecion_unlock_task = {}
local fields = {
	param = 2,
	id = 1,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.rogue_collecion_unlock_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_collecion_unlock_task, "configList", _configList)
	rawset(lua_rogue_collecion_unlock_task, "configDict", _configDict)
end

setmetatable(lua_rogue_collecion_unlock_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_collecion_unlock_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_collecion_unlock_task, "configList", nil)
	rawset(lua_rogue_collecion_unlock_task, "configDict", nil)
end

return lua_rogue_collecion_unlock_task
