module("modules.configs.excel2json.lua_eliminate_battle_skill", package.seeall)

slot1 = {
	triggerPoint = 7,
	name = 2,
	cd = 6,
	type = 4,
	effect = 9,
	condition = 8,
	desc = 3,
	id = 1,
	icon = 5
}
slot2 = {
	"id"
}
slot3 = {
	type = 3,
	name = 1,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
