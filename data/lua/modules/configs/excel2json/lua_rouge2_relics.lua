-- chunkname: @modules/configs/excel2json/lua_rouge2_relics.lua

module("modules.configs.excel2json.lua_rouge2_relics", package.seeall)

local lua_rouge2_relics = {}
local fields = {
	tag = 9,
	effect14 = 51,
	condition8 = 38,
	effect8 = 39,
	effect4 = 31,
	condition2 = 26,
	descSimply = 15,
	unlock = 13,
	outUnlock = 5,
	career = 11,
	narrativeDesc = 21,
	isHide = 7,
	condition15 = 52,
	name = 2,
	effect2 = 27,
	condition7 = 36,
	descUpdate = 18,
	overlay = 23,
	effect22 = 67,
	condition25 = 72,
	effect25 = 73,
	invisible = 22,
	condition22 = 66,
	unlockConditionDesc = 19,
	id = 1,
	condition10 = 42,
	condition16 = 54,
	isOff = 3,
	condition5 = 32,
	effect7 = 37,
	updateId = 17,
	condition17 = 56,
	condition9 = 40,
	sortId = 4,
	effect23 = 69,
	outUnlockDesc = 6,
	condition6 = 34,
	effect21 = 65,
	unlockEffectDesc = 20,
	condition12 = 46,
	effect20 = 63,
	effect13 = 49,
	condition23 = 68,
	effect5 = 33,
	condition24 = 70,
	effect11 = 45,
	effect12 = 47,
	condition19 = 60,
	condition3 = 28,
	effect10 = 43,
	attrUpdate = 16,
	icon = 12,
	effect6 = 35,
	condition21 = 64,
	rare = 8,
	effect17 = 57,
	effect9 = 41,
	condition1 = 24,
	effect16 = 55,
	effect1 = 25,
	condition13 = 48,
	effect3 = 29,
	condition14 = 50,
	desc = 14,
	condition18 = 58,
	attributeTag = 10,
	effect19 = 61,
	effect24 = 71,
	effect18 = 59,
	condition11 = 44,
	condition4 = 30,
	condition20 = 62,
	effect15 = 53
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	unlockEffectDesc = 7,
	descSimply = 4,
	unlockConditionDesc = 6,
	outUnlockDesc = 2,
	narrativeDesc = 8,
	descUpdate = 5,
	name = 1,
	desc = 3
}

function lua_rouge2_relics.onLoad(json)
	lua_rouge2_relics.configList, lua_rouge2_relics.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_relics
