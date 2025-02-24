module("modules.configs.excel2json.lua_activity188_card", package.seeall)

slot1 = {
	cardId = 2,
	name = 5,
	skillId = 4,
	type = 3,
	resource = 7,
	activityId = 1,
	desc = 6
}
slot2 = {
	"activityId",
	"cardId"
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
