module("modules.configs.excel2json.lua_activity191_relation_select", package.seeall)

slot1 = {
	tag = 2,
	sortIndex = 3,
	activityId = 1
}
slot2 = {
	"activityId",
	"tag"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
