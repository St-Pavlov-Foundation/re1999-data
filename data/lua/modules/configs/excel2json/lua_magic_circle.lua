module("modules.configs.excel2json.lua_magic_circle", package.seeall)

slot1 = {
	consumeNum = 7,
	enterTime = 16,
	selfSkills = 10,
	closeTime = 20,
	enemySkills = 11,
	enterAudio = 17,
	endSkills = 14,
	desc = 3,
	name = 2,
	consumeType = 6,
	selfAttrs = 8,
	closeAudio = 22,
	enemyBuff = 13,
	enemyAttrs = 9,
	selfBuff = 12,
	closeEffect = 19,
	enterEffect = 15,
	posArr = 23,
	round = 5,
	loopEffect = 18,
	id = 1,
	uiType = 4,
	closeAniName = 21
}
slot2 = {
	"id"
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
