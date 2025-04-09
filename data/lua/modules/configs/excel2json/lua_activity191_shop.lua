module("modules.configs.excel2json.lua_activity191_shop", package.seeall)

slot1 = {
	position = 6,
	name = 7,
	desc = 8,
	type = 3,
	id = 2,
	stage = 5,
	activityId = 1,
	level = 4
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
