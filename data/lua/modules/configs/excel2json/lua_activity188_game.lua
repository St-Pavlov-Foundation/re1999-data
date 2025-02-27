module("modules.configs.excel2json.lua_activity188_game", package.seeall)

slot1 = {
	bossAbilityPool = 10,
	activityId = 1,
	count = 13,
	portrait = 19,
	abilityIds = 5,
	passRound = 18,
	bossCount = 14,
	bossAbilityIds = 6,
	bossHurt = 16,
	abilityPool = 9,
	bossHp = 12,
	rowColumn = 7,
	round = 3,
	hurt = 15,
	hp = 11,
	cardBuild = 8,
	id = 2,
	difficult = 17,
	readNum = 4
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
