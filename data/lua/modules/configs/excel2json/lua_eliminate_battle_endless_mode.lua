module("modules.configs.excel2json.lua_eliminate_battle_endless_mode", package.seeall)

slot1 = {
	powerUp3 = 8,
	skill2 = 5,
	powerUp1 = 4,
	skill4 = 9,
	powerUp4 = 10,
	skill5 = 11,
	skill3 = 7,
	powerUp2 = 6,
	skill1 = 3,
	id = 1,
	powerUp5 = 12,
	hpUp = 2
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
