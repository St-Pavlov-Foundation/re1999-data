module("modules.configs.excel2json.lua_language", package.seeall)

slot1 = {
	contenttw = 3,
	key = 1,
	contenten = 5,
	contentko = 6,
	contentjp = 4,
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
