module("modules.configs.excel2json.lua_eliminate_battle_enemybehavior", package.seeall)

slot1 = {
	prob3 = 9,
	list3 = 8,
	prob2 = 7,
	prob1 = 5,
	list1 = 4,
	round = 3,
	behavior = 2,
	list2 = 6,
	id = 1
}
slot2 = {
	"id",
	"behavior"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
