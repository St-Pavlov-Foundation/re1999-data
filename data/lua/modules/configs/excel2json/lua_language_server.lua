module("modules.configs.excel2json.lua_language_server", package.seeall)

slot1 = {
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
slot2 = {
	"key"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
