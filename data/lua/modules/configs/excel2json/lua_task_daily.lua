module("modules.configs.excel2json.lua_task_daily", package.seeall)

slot1 = {
	activity = 10,
	name = 4,
	isOnline = 2,
	bonusMail = 14,
	maxFinishCount = 9,
	jumpId = 19,
	desc = 5,
	listenerParam = 7,
	needAccept = 17,
	params = 15,
	openLimit = 13,
	maxProgress = 8,
	activityId = 20,
	sortId = 11,
	priority = 16,
	prepose = 12,
	listenerType = 6,
	minType = 3,
	id = 1,
	bonus = 18
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
