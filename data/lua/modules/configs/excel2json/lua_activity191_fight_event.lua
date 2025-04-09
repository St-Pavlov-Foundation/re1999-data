module("modules.configs.excel2json.lua_activity191_fight_event", package.seeall)

slot1 = {
	fightLevel = 11,
	skinId = 5,
	bloodAward = 9,
	type = 2,
	autoRewardView = 8,
	title = 3,
	offset = 6,
	episodeId = 4,
	rewardView = 7,
	autoAward = 10,
	id = 1
}
slot2 = {
	"id"
}
slot3 = {
	title = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
