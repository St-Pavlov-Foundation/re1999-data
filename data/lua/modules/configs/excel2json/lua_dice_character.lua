module("modules.configs.excel2json.lua_dice_character", package.seeall)

slot1 = {
	relicIds = 7,
	name = 2,
	dicelist = 5,
	skilllist = 6,
	power = 10,
	resetTimes = 8,
	powerSkill = 11,
	desc = 3,
	hp = 9,
	id = 1,
	icon = 4
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
