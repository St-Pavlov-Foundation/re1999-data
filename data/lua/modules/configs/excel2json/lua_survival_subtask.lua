module("modules.configs.excel2json.lua_survival_subtask", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	versions = 6,
	failCondition = 14,
	prepose = 13,
	maintaskChange = 7,
	group = 2,
	progressCondition = 10,
	type = 4,
	desc = 8,
	autoDrop = 15,
	desc2 = 9,
	needAccept = 12,
	seasons = 5,
	id = 1,
	maxProgress = 11,
	dropShow = 16,
	step = 3
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc2 = 2,
	desc = 1
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
