-- chunkname: @modules/configs/excel2json/lua_task_activity_bonus.lua

module("modules.configs.excel2json.lua_task_activity_bonus", package.seeall)

local lua_task_activity_bonus = {}
local fields = {
	hideInVerifing = 6,
	bonus = 5,
	desc = 3,
	type = 1,
	id = 2,
	needActivity = 4
}
local primaryKey = {
	"type",
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.task_activity_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_task_activity_bonus, "configList", _configList)
	rawset(lua_task_activity_bonus, "configDict", _configDict)
end

setmetatable(lua_task_activity_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_task_activity_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_task_activity_bonus, "configList", nil)
	rawset(lua_task_activity_bonus, "configDict", nil)
end

return lua_task_activity_bonus
