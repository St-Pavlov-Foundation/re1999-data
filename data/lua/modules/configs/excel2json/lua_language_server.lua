module("modules.configs.excel2json.lua_language_server", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	contentjp = 4,
	contenten = 5,
	contentde = 7,
	key = 1,
	contenttw = 3,
	contentfr = 8,
	contentko = 6,
	contentthai = 9,
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
