module("modules.configs.excel2json.lua_activity144_option_result", package.seeall)

slot1 = {
	activityId = 1,
	name = 3,
	desc = 6,
	picture = 5,
	optionId = 2,
	bonus = 4
}
slot2 = {
	"activityId",
	"optionId"
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
