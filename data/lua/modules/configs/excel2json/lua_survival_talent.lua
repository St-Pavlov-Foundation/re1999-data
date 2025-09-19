module("modules.configs.excel2json.lua_survival_talent", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	versions = 3,
	name = 5,
	groupId = 2,
	seasons = 4,
	id = 1,
	desc1 = 6,
	desc2 = 7
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc2 = 3,
	name = 1,
	desc1 = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
