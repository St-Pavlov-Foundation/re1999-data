-- chunkname: @modules/configs/excel2json/lua_activity145_task_bonus.lua

module("modules.configs.excel2json.lua_activity145_task_bonus", package.seeall)

local lua_activity145_task_bonus = {}
local fields = {
	bonus = 5,
	needProgress = 4,
	id = 2,
	activityId = 1,
	desc = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity145_task_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity145_task_bonus, "configList", _configList)
	rawset(lua_activity145_task_bonus, "configDict", _configDict)
end

setmetatable(lua_activity145_task_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity145_task_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity145_task_bonus, "configList", nil)
	rawset(lua_activity145_task_bonus, "configDict", nil)
end

return lua_activity145_task_bonus
