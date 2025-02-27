module("modules.configs.excel2json.lua_activity188_ai", package.seeall)

slot1 = {
	pairRate = 5,
	pairRound = 4,
	reverseTime = 3,
	difficult = 2,
	activityId = 1
}
slot2 = {
	"activityId",
	"difficult"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
