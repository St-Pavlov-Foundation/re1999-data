module("modules.configs.excel2json.lua_fight_replace_skill_behavior_effect", package.seeall)

slot1 = {
	audioId = 5,
	effect = 3,
	id = 1,
	skillBehaviorId = 2,
	effectHangPoint = 4
}
slot2 = {
	"id",
	"skillBehaviorId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
