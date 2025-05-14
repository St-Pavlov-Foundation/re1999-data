module("modules.configs.excel2json.lua_language", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	contenttw = 3,
	key = 1,
	contenten = 5,
	contentko = 6,
	contentjp = 4,
	contentzh = 2
}
local var_0_2 = {
	"key"
}
local var_0_3 = {}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
