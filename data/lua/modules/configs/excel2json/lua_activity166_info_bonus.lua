module("modules.configs.excel2json.lua_activity166_info_bonus", package.seeall)

slot1 = {
	analyCount = 2,
	activityId = 1,
	bonus = 3
}
slot2 = {
	"activityId",
	"analyCount"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
