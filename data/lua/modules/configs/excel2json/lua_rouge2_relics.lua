-- chunkname: @modules/configs/excel2json/lua_rouge2_relics.lua

module("modules.configs.excel2json.lua_rouge2_relics", package.seeall)

local lua_rouge2_relics = {}
local fields = {
	tag = 9,
	effect14 = 50,
	condition8 = 37,
	effect8 = 38,
	descUpdate = 17,
	condition15 = 51,
	outUnlock = 5,
	unlock = 13,
	descSimply = 15,
	narrativeDesc = 20,
	career = 11,
	icon = 12,
	isHide = 7,
	effect4 = 30,
	effect2 = 26,
	condition7 = 35,
	effect5 = 32,
	overlay = 22,
	effect22 = 66,
	condition25 = 71,
	effect25 = 72,
	invisible = 21,
	condition22 = 65,
	unlockConditionDesc = 18,
	id = 1,
	condition10 = 41,
	condition16 = 53,
	isOff = 3,
	condition5 = 31,
	effect7 = 36,
	updateId = 16,
	condition17 = 55,
	condition9 = 39,
	sortId = 4,
	effect23 = 68,
	outUnlockDesc = 6,
	condition6 = 33,
	effect21 = 64,
	unlockEffectDesc = 19,
	condition12 = 45,
	effect20 = 62,
	effect13 = 48,
	condition23 = 67,
	name = 2,
	condition24 = 69,
	effect11 = 44,
	effect12 = 46,
	condition19 = 59,
	condition3 = 27,
	effect10 = 42,
	condition2 = 25,
	effect6 = 34,
	condition21 = 63,
	rare = 8,
	effect17 = 56,
	effect9 = 40,
	condition1 = 23,
	effect16 = 54,
	effect1 = 24,
	condition13 = 47,
	effect3 = 28,
	condition14 = 49,
	desc = 14,
	condition18 = 57,
	attributeTag = 10,
	effect19 = 60,
	effect24 = 70,
	effect18 = 58,
	condition11 = 43,
	condition4 = 29,
	condition20 = 61,
	effect15 = 52
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
