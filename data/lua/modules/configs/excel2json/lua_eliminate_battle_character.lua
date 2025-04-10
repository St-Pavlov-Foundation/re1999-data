module("modules.configs.excel2json.lua_eliminate_battle_character", package.seeall)

slot1 = {
	skill = 5,
	name = 2,
	hp = 4,
	specialAttr1 = 6,
	id = 1,
	icon = 3
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
