module("modules.configs.excel2json.lua_activity192_episode", package.seeall)

slot1 = {
	storyBefore = 7,
	name = 6,
	preEpisodeBranchId = 4,
	isExtra = 9,
	storyClear = 8,
	episodeId = 2,
	preEpisodeId = 3,
	activityId = 1,
	gameId = 5
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
