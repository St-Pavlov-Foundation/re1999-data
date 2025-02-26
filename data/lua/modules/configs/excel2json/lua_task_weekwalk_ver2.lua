module("modules.configs.excel2json.lua_task_weekwalk_ver2", package.seeall)

slot1 = {
	listenerType = 8,
	name = 6,
	isOnline = 3,
	bonusMail = 13,
	maxFinishCount = 11,
	layerId = 2,
	periods = 14,
	desc = 7,
	listenerParam = 9,
	minType = 5,
	minTypeId = 4,
	id = 1,
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
