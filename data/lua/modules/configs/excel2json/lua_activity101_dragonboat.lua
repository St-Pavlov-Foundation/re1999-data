module("modules.configs.excel2json.lua_activity101_dragonboat", package.seeall)

slot1 = {
	desc = 4,
	name = 3,
	dayicon = 5,
	activityId = 1,
	day = 2
}
slot2 = {
	"activityId",
	"day"
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
