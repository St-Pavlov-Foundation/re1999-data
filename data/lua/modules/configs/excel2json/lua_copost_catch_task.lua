﻿module("modules.configs.excel2json.lua_copost_catch_task", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	listenerParam = 3,
	desc = 5,
	bonus = 6,
	jumpId = 7,
	id = 1,
	maxProgress = 4,
	listenerType = 2
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
