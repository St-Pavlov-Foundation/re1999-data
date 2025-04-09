module("modules.configs.excel2json.lua_activity191_role", package.seeall)

slot1 = {
	roleId = 10,
	name = 11,
	type = 3,
	skinId = 5,
	uniqueSkill = 18,
	gender = 12,
	career = 13,
	activeSkill2 = 17,
	star = 7,
	activeSkill1 = 16,
	dmgType = 14,
	quality = 6,
	tag = 9,
	uniqueSkill_point = 19,
	activityId = 2,
	powerMax = 20,
	passiveSkill = 15,
	exLevel = 8,
	template = 4,
	id = 1,
	weight = 21
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
