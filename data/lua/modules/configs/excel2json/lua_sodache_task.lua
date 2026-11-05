-- chunkname: @modules/configs/excel2json/lua_sodache_task.lua

module("modules.configs.excel2json.lua_sodache_task", package.seeall)

local lua_sodache_task = {}
local fields = {
	failCondition = 14,
	abandon = 15,
	insideShow = 4,
	desc1 = 7,
	rewardShow = 16,
	remove = 19,
	name = 6,
	desc = 8,
	listenerParam = 10,
	type = 2,
	needAccept = 12,
	group = 3,
	maxProgress = 11,
	reward = 17,
	prepose = 13,
	listenerType = 9,
	track = 18,
	id = 1,
	step = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 3,
	name = 1,
	desc1 = 2
}
local _configList, _configDict
local configPath = "configs.sodache_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sodache_task, "configList", _configList)
	rawset(lua_sodache_task, "configDict", _configDict)
end

setmetatable(lua_sodache_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sodache_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sodache_task, "configList", nil)
	rawset(lua_sodache_task, "configDict", nil)
end

return lua_sodache_task
