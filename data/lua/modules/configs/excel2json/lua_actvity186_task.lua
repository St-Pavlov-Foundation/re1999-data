-- chunkname: @modules/configs/excel2json/lua_actvity186_task.lua

module("modules.configs.excel2json.lua_actvity186_task", package.seeall)

local lua_actvity186_task = {}
local fields = {
	missionorder = 17,
	name = 7,
	showDay = 18,
	bonusMail = 9,
	desc = 8,
	listenerParam = 11,
	openLimit = 14,
	maxProgress = 12,
	activityId = 2,
	jumpId = 15,
	isOnline = 3,
	prepose = 13,
	loopType = 4,
	listenerType = 10,
	minType = 6,
	id = 1,
	acceptStage = 5,
	bonus = 16
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
local configPath = "configs.actvity186_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_actvity186_task, "configList", _configList)
	rawset(lua_actvity186_task, "configDict", _configDict)
end

setmetatable(lua_actvity186_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_actvity186_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_actvity186_task, "configList", nil)
	rawset(lua_actvity186_task, "configDict", nil)
end

return lua_actvity186_task
