﻿module("modules.configs.excel2json.lua_copost_catch_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	jumpId = 9,
	isOnline = 3,
	desc = 7,
	finishNum = 2,
	listenerType = 4,
	listenerParam = 5,
	id = 1,
	maxProgress = 6,
	bonus = 8
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
