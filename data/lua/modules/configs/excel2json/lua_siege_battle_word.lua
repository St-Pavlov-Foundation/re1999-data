module("modules.configs.excel2json.lua_siege_battle_word", package.seeall)

slot1 = {
	id = 1,
	sign = 3,
	desc = 2
}
slot2 = {
	"id"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
