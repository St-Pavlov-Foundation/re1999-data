﻿module("modules.configs.excel2json.lua_handbook_skin_low", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	backImg = 8,
	name = 2,
	des = 6,
	show = 5,
	spineParams = 9,
	tarotCardPath = 10,
	skinContain = 7,
	highId = 4,
	id = 1,
	nameEn = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	des = 2,
	name = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
