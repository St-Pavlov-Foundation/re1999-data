module("modules.configs.excel2json.lua_dice_card", package.seeall)

slot1 = {
	effect1 = 6,
	bufflist = 16,
	name = 2,
	type = 5,
	effect3 = 12,
	aim1 = 8,
	aim3 = 14,
	desc = 3,
	allRoundLimitCount = 18,
	params2 = 10,
	roundLimitCount = 17,
	effect2 = 9,
	patternlist = 15,
	quality = 4,
	spiritskilltype = 19,
	aim2 = 11,
	powerExtendRule = 20,
	params3 = 13,
	id = 1,
	params1 = 7
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
