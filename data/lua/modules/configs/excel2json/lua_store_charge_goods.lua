module("modules.configs.excel2json.lua_store_charge_goods", package.seeall)

slot1 = {
	extraDiamond = 18,
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
	price = 14,
	order = 4,
	isOnline = 11,
	item = 19,
	offTag = 10,
	offlineTime = 13,
	limit = 20,
	firstDiamond = 17,
	bigImg = 8,
	diamond = 16,
	product = 9,
	id = 1,
	nameEn = 6
}
slot2 = {
	"id"
}
slot3 = {
	desc = 3,
	name = 1,
	nameEn = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
