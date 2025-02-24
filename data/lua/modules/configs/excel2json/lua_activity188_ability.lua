module("modules.configs.excel2json.lua_activity188_ability", package.seeall)

slot1 = {
	effectTime = 3,
	skillId = 4,
	abilityId = 2,
	activityId = 1,
	desc = 5
}
slot2 = {
	"activityId",
	"abilityId"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
