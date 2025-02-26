module("modules.configs.excel2json.lua_dice_task", package.seeall)

slot1 = {
	jumpId = 11,
	isOnline = 2,
	id = 1,
	bonusMail = 6,
	name = 4,
	listenerType = 8,
	desc = 5,
	listenerParam = 9,
	minType = 3,
	openLimit = 7,
	maxProgress = 10,
	bonus = 12
}
slot2 = {
	"id"
}
slot3 = {
	name = 2,
	minType = 1,
	desc = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
