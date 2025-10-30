﻿-- chunkname: @modules/configs/excel2json/lua_actvity186_task.lua

module("modules.configs.excel2json.lua_actvity186_task", package.seeall)

local lua_actvity186_task = {}
local fields = {
	missionorder = 17,
	name = 7,
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

function lua_actvity186_task.onLoad(json)
	lua_actvity186_task.configList, lua_actvity186_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_actvity186_task
