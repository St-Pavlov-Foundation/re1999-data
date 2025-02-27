module("modules.configs.excel2json.lua_dice_buff", package.seeall)

slot1 = {
	triggerPoint = 8,
	effect = 7,
	name = 2,
	tag = 3,
	param = 9,
	damp = 10,
	roundLimitCount = 11,
	desc = 4,
	visible = 6,
	id = 1,
	icon = 5,
	allRoundLimitCount = 12
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
