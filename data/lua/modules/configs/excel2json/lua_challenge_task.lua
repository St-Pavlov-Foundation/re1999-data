-- chunkname: @modules/configs/excel2json/lua_challenge_task.lua

module("modules.configs.excel2json.lua_challenge_task", package.seeall)

local lua_challenge_task = {}
local fields = {
	groupId = 4,
	name = 7,
	bonusMail = 9,
	type = 3,
	maxFinishCount = 14,
	desc = 8,
	listenerParam = 12,
	openLimit = 10,
	maxProgress = 13,
	activityId = 2,
	jumpId = 15,
	isOnline = 5,
	listenerType = 11,
	minType = 6,
	id = 1,
	badgeNum = 17,
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
local configPath = "configs.challenge_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_challenge_task, "configList", _configList)
	rawset(lua_challenge_task, "configDict", _configDict)
end

setmetatable(lua_challenge_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_challenge_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_challenge_task, "configList", nil)
	rawset(lua_challenge_task, "configDict", nil)
end

return lua_challenge_task
