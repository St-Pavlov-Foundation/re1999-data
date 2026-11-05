-- chunkname: @modules/configs/excel2json/lua_task_weekwalk_ver2.lua

module("modules.configs.excel2json.lua_task_weekwalk_ver2", package.seeall)

local lua_task_weekwalk_ver2 = {}
local fields = {
	listenerType = 8,
	name = 6,
	isOnline = 3,
	bonusMail = 13,
	maxFinishCount = 11,
	layerId = 2,
	periods = 14,
	desc = 7,
	listenerParam = 9,
	minType = 5,
	minTypeId = 4,
	id = 1,
	maxProgress = 10,
	bonus = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 2,
	minType = 1,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.task_weekwalk_ver2_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_task_weekwalk_ver2, "configList", _configList)
	rawset(lua_task_weekwalk_ver2, "configDict", _configDict)
end

setmetatable(lua_task_weekwalk_ver2, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_task_weekwalk_ver2.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_task_weekwalk_ver2, "configList", nil)
	rawset(lua_task_weekwalk_ver2, "configDict", nil)
end

return lua_task_weekwalk_ver2
