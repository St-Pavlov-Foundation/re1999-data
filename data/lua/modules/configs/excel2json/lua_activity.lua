module("modules.configs.excel2json.lua_activity", package.seeall)

slot1 = {
	tabBgPath = 25,
	name = 3,
	logoType = 8,
	banner = 13,
	achievementGroupPath = 23,
	tryoutEpisode = 33,
	tabButton = 26,
	openId = 17,
	achievementGroup = 19,
	hintPriority = 30,
	permanentParentAcitivityId = 22,
	showCenter = 15,
	redDotId = 18,
	extraDisplayIcon = 32,
	isRetroAcitivity = 21,
	actTip = 6,
	id = 1,
	nameEn = 4,
	logoName = 9,
	actDesc = 5,
	achievementJumpId = 28,
	desc = 14,
	confirmCondition = 11,
	tabBgmId = 27,
	extraDisplayId = 31,
	param = 16,
	defaultPriority = 29,
	storyId = 20,
	typeId = 7,
	activityBonus = 24,
	tabName = 2,
	tryoutcharacter = 34,
	joinCondition = 10,
	displayPriority = 12
}
slot2 = {
	"id"
}
slot3 = {
	logoName = 4,
	name = 1,
	actDesc = 2,
	actTip = 3,
	desc = 5
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
