module("modules.configs.excel2json.lua_eliminate_battle_buff", package.seeall)

slot1 = {
	triggerPoint = 2,
	effect = 3,
	name = 6,
	icon = 8,
	id = 1,
	cover = 4,
	limit = 5,
	desc = 7
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
