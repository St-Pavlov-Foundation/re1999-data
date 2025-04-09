module("modules.configs.excel2json.lua_activity191_collection", package.seeall)

slot1 = {
	label = 6,
	tag = 5,
	replaceDesc = 8,
	weight = 10,
	title = 4,
	rare = 3,
	desc = 7,
	id = 1,
	icon = 9,
	activityId = 2
}
slot2 = {
	"id"
}
slot3 = {
	label = 2,
	title = 1,
	replaceDesc = 4,
	desc = 3
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
