-- chunkname: @modules/configs/excel2json/lua_summon_pool.lua

module("modules.configs.excel2json.lua_summon_pool", package.seeall)

local lua_summon_pool = {}
local fields = {
	awardTime = 29,
	priority = 2,
	discountTime10 = 23,
	type = 8,
	characterDetail = 32,
	advertising = 14,
	cost1 = 19,
	customClz = 18,
	upWeight = 27,
	subType = 4,
	priorCost1 = 21,
	nameUnderlayColor = 40,
	guaranteeSRParam = 28,
	progressRewards = 33,
	jumpGroupId = 35,
	mailIds = 36,
	infallibleItemMaxUseCount = 38,
	param2 = 6,
	desc = 13,
	maskColor = 41,
	ticketId = 10,
	banner = 15,
	priorCost10 = 22,
	ornamentName = 42,
	prefabPath = 17,
	totalPosibility = 44,
	progressRewardPrefab = 45,
	bannerLineName = 43,
	id = 1,
	poolDetail = 31,
	totalFreeCount = 3,
	nameEn = 12,
	infallibleMailIds = 39,
	spinePrefab = 46,
	infallibleItemId = 37,
	free10MaxUseCount = 7,
	nameCn = 11,
	changeWeight = 30,
	doubleSsrUpRates = 26,
	param = 9,
	historyShowType = 34,
	cost10 = 20,
	dailyFreeSummon10Count = 5,
	discountCost10 = 24,
	bannerFlag = 16,
	initWeight = 25
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	nameCn = 1,
	desc = 2
}

function lua_summon_pool.onLoad(json)
	lua_summon_pool.configList, lua_summon_pool.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_summon_pool
