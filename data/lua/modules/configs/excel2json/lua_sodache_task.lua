-- chunkname: @modules/configs/excel2json/lua_sodache_task.lua

module("modules.configs.excel2json.lua_sodache_task", package.seeall)

local lua_sodache_task = {}
local fields = {
	failCondition = 13,
	abandon = 14,
	group = 3,
	type = 2,
	rewardShow = 15,
	remove = 18,
	name = 5,
	desc = 7,
	listenerParam = 9,
	desc1 = 6,
	needAccept = 11,
	maxProgress = 10,
	reward = 16,
	prepose = 12,
	listenerType = 8,
	track = 17,
	id = 1,
	step = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 3,
	name = 1,
	desc1 = 2
}

function lua_sodache_task.onLoad(json)
	lua_sodache_task.configList, lua_sodache_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_task
