module("modules.configs.excel2json.lua_activity191_bot", package.seeall)

slot1 = {
	prepareRole1 = 7,
	prepareRole4 = 10,
	collection1 = 11,
	prepareRole3 = 9,
	collection3 = 13,
	role3 = 5,
	enhance = 15,
	collection4 = 14,
	role1 = 3,
	collection2 = 12,
	role4 = 6,
	rank = 16,
	id = 1,
	prepareRole2 = 8,
	activityId = 2,
	role2 = 4
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
