-- chunkname: @modules/configs/excel2json/lua_store_charge_goods.lua

module("modules.configs.excel2json.lua_store_charge_goods", package.seeall)

local lua_store_charge_goods = {}
local fields = {
	notShowInRecommend = 27,
	name = 5,
	newStartTime = 25,
	type = 3,
	extraDiamond = 21,
	newEndTime = 26,
	isShowTurnback = 34,
	onlineTime = 15,
	quickUseItemList = 29,
	item = 22,
	offTag = 13,
	firstDiamond = 20,
	bigImg = 8,
	diamond = 19,
	product = 9,
	id = 1,
	overviewJumpId = 33,
	nameEn = 6,
	taskid = 31,
	detailDesc = 28,
	belongStoreId = 2,
	desc = 7,
	originalCost = 18,
	slogan = 12,
	showLogoTag = 32,
	underlay = 10,
	price = 17,
	order = 4,
	showLinkageTag = 30,
	isOnline = 14,
	offlineTime = 16,
	limit = 23,
	showBg = 11,
	preGoodsId = 24
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
