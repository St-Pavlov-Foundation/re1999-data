module("modules.configs.excel2json.lua_dice_level", package.seeall)

slot1 = {
	chapter = 3,
	enemyType = 6,
	isSkip = 10,
	type = 5,
	rewardSelectType = 8,
	mode = 7,
	room = 4,
	dialog = 9,
	id = 1,
	chapterName = 2
}
slot2 = {
	"id"
}
slot3 = {
	chapterName = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
