-- chunkname: @modules/configs/excel2json/lua_bp_task.lua

module("modules.configs.excel2json.lua_bp_task", package.seeall)

local lua_bp_task = {}
local fields = {
	listenerType = 8,
	name = 6,
	bonusScoreTimes = 22,
	bonusMail = 14,
	endTime = 19,
	turnbackTask = 20,
	jumpId = 17,
	desc = 7,
	listenerParam = 9,
	bpId = 3,
	params = 15,
	openLimit = 13,
	maxProgress = 10,
	sortId = 11,
	isOnline = 2,
	prepose = 12,
	loopType = 4,
	bonusScore = 16,
	minType = 5,
	id = 1,
	newbieTask = 21,
	startTime = 18
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
local configPath = "configs.bp_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_bp_task, "configList", _configList)
	rawset(lua_bp_task, "configDict", _configDict)
end

setmetatable(lua_bp_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_bp_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_bp_task, "configList", nil)
	rawset(lua_bp_task, "configDict", nil)
end

return lua_bp_task
