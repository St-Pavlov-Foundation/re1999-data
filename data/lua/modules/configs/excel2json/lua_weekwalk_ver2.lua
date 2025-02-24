module("modules.configs.excel2json.lua_weekwalk_ver2", package.seeall)

slot1 = {
	chooseSkillNum = 10,
	resIdRear = 9,
	preId = 4,
	fightIdFront = 6,
	sceneId = 5,
	issueId = 3,
	resIdFront = 7,
	id = 1,
	fightIdRear = 8,
	layer = 2
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
