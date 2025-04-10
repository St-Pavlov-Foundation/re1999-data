module("modules.configs.excel2json.lua_activity191_stage", package.seeall)

slot1 = {
	score = 7,
	name = 6,
	rule = 5,
	nextId = 3,
	id = 2,
	initStage = 4,
	activityId = 1,
	coin = 8
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
