module("modules.configs.excel2json.lua_survival_equip_found", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	id = 1,
	name = 4,
	value = 7,
	desc = 2,
	icon4 = 8,
	icon3 = 6,
	icon2 = 5,
	icon = 3,
	level = 9
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	name = 2,
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
