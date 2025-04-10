module("modules.configs.excel2json.lua_tower_task", package.seeall)

slot1 = {
	jumpId = 13,
	name = 6,
	openLimit = 9,
	bonusMail = 8,
	listenerType = 10,
	maxProgress = 12,
	isOnline = 4,
	desc = 7,
	listenerParam = 11,
	minType = 5,
	isKeyReward = 15,
	id = 1,
	taskGroupId = 2,
	activityId = 3,
	bonus = 14
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
