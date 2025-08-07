module("modules.configs.excel2json.lua_store_charge_goods", package.seeall)

local var_0_0 = {}
local var_0_1 = {
	taskid = 28,
	name = 5,
	preGoodsId = 21,
	type = 3,
	newStartTime = 22,
	newEndTime = 23,
	belongStoreId = 2,
	desc = 7,
	onlineTime = 12,
	originalCost = 15,
	detailDesc = 25,
	quickUseItemList = 26,
	notShowInRecommend = 24,
	extraDiamond = 18,
	price = 14,
	order = 4,
	showLinkageTag = 27,
	isOnline = 11,
	item = 19,
	offTag = 10,
	showLogoTag = 29,
	offlineTime = 13,
	limit = 20,
	firstDiamond = 17,
	bigImg = 8,
	diamond = 16,
	product = 9,
	id = 1,
	overviewJumpId = 30,
	nameEn = 6
}
local var_0_2 = {
	"id"
}
local var_0_3 = {
	desc = 3,
	name = 1,
	nameEn = 2
}

function var_0_0.onLoad(arg_1_0)
	var_0_0.configList, var_0_0.configDict = JsonToLuaParser.parse(arg_1_0, var_0_1, var_0_2, var_0_3)
end

return var_0_0
