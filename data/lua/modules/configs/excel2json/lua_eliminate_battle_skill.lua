module("modules.configs.excel2json.lua_eliminate_battle_skill", package.seeall)

slot1 = {
	triggerPoint = 6,
	effect = 8,
	cd = 5,
	type = 3,
	id = 1,
	icon = 4,
	condition = 7,
	desc = 2
}
slot2 = {
	"id"
}
slot3 = {
	type = 2,
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
