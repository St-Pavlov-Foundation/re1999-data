module("modules.configs.excel2json.lua_activity190_episode", package.seeall)

slot1 = {
	eliminateLevelId = 9,
	name = 5,
	preEpisodeBranchId = 4,
	type = 10,
	storyBefore = 6,
	storyClear = 8,
	maxRound = 12,
	episodeId = 2,
	masterId = 13,
	preEpisodeId = 3,
	enemyId = 11,
	activityId = 1,
	gameId = 7
}
slot2 = {
	"activityId",
	"episodeId"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
