module("modules.configs.excel2json.lua_activity168_const", package.seeall)

slot1 = {
	activityId = 1,
	value1 = 3,
	mlValue = 5,
	id = 2,
	value2 = 4
}
slot2 = {
	"activityId",
	"id"
}
slot3 = {
	mlValue = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
