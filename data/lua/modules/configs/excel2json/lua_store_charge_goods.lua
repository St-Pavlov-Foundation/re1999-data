-- chunkname: @modules/configs/excel2json/lua_store_charge_goods.lua

module("modules.configs.excel2json.lua_store_charge_goods", package.seeall)

local lua_store_charge_goods = {}
local fields = {
	firstDiamond = 19,
	name = 5,
	newEndTime = 25,
	type = 3,
	newStartTime = 24,
	notShowInRecommend = 26,
	onlineTime = 14,
	quickUseItemList = 28,
	item = 21,
	offTag = 12,
	extraDiamond = 20,
	bigImg = 8,
	diamond = 18,
	product = 9,
	id = 1,
	overviewJumpId = 32,
	nameEn = 6,
	taskid = 30,
	detailDesc = 27,
	belongStoreId = 2,
	desc = 7,
	originalCost = 17,
	slogan = 11,
	showLogoTag = 31,
	underlay = 10,
	price = 16,
	order = 4,
	showLinkageTag = 29,
	isOnline = 13,
	offlineTime = 15,
	limit = 22,
	isShowTurnback = 33,
	preGoodsId = 23
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
