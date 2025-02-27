module("modules.configs.excel2json.lua_bp", package.seeall)

slot1 = {
	isSp = 17,
	name = 7,
	chargeId2 = 3,
	bpSkinEnNametxt = 12,
	bpviewicon = 13,
	payStatus2Bonus = 6,
	chargeId1 = 2,
	bpId = 1,
	showBonusDate = 16,
	chargeId1to2 = 4,
	bpviewpos = 14,
	showBonus = 15,
	bpSkinDesc = 10,
	bpSkinNametxt = 11,
	expLevelUp = 9,
	payStatus1Bonus = 5,
	payStatus2AddLevel = 8
}
slot2 = {
	"bpId"
}
slot3 = {
	bpSkinNametxt = 3,
	name = 1,
	bpSkinDesc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
