-- chunkname: @modules/configs/excel2json/lua_store_charge_goods.lua

module("modules.configs.excel2json.lua_store_charge_goods", package.seeall)

local lua_store_charge_goods = {}
local fields = {
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
	isShowTurnback = 31,
	id = 1,
	overviewJumpId = 30,
	nameEn = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 3,
	name = 1,
	nameEn = 2
}

function lua_store_charge_goods.onLoad(json)
	lua_store_charge_goods.configList, lua_store_charge_goods.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_store_charge_goods
