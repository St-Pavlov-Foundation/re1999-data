﻿module("modules.configs.excel2json.lua_activity121_story", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	noteIds = 6,
	name = 3,
	clueIds = 5,
	bonus = 7,
	id = 2,
	icon = 8,
	activityId = 1,
	episodeId = 4
}
local var_0_2 = {
	"activityId",
	"id"
}
local var_0_3 = {
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
