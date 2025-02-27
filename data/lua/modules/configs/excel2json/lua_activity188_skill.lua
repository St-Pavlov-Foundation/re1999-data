module("modules.configs.excel2json.lua_activity188_skill", package.seeall)

slot1 = {
	param = 4,
	effect = 3,
	skillId = 2,
	activityId = 1,
	desc = 5
}
slot2 = {
	"activityId",
	"skillId"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
