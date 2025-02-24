module("modules.configs.excel2json.lua_activity188_buff", package.seeall)

slot1 = {
	desc = 6,
	name = 5,
	buffId = 2,
	icon = 7,
	maxLayer = 4,
	activityId = 1,
	laminate = 3
}
slot2 = {
	"activityId",
	"buffId"
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
