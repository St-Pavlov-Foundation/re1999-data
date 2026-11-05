-- chunkname: @modules/configs/excel2json/lua_task_weekwalk.lua

module("modules.configs.excel2json.lua_task_weekwalk", package.seeall)

local lua_task_weekwalk = {}
local fields = {
	sortId = 10,
	listenerType = 6,
	periods = 13,
	bonusMail = 12,
	maxFinishCount = 9,
	layerId = 5,
	desc = 4,
	listenerParam = 7,
	minType = 3,
	minTypeId = 2,
	id = 1,
	maxProgress = 8,
	bonus = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	minType = 1
}
local _configList, _configDict
local configPath = "configs.task_weekwalk_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_task_weekwalk, "configList", _configList)
	rawset(lua_task_weekwalk, "configDict", _configDict)
end

setmetatable(lua_task_weekwalk, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_task_weekwalk.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_task_weekwalk, "configList", nil)
	rawset(lua_task_weekwalk, "configDict", nil)
end

return lua_task_weekwalk
