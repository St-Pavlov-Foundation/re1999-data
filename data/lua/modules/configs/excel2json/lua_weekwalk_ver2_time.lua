module("modules.configs.excel2json.lua_weekwalk_ver2_time", package.seeall)

slot1 = {
	ruleFront = 5,
	ruleRear = 6,
	issueId = 2,
	ruleIcon = 4,
	optionalSkills = 3,
	timeId = 1
}
slot2 = {
	"timeId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
