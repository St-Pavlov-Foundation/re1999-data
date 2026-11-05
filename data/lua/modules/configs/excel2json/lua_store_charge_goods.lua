-- chunkname: @modules/configs/excel2json/lua_store_charge_goods.lua

module("modules.configs.excel2json.lua_store_charge_goods", package.seeall)

local lua_store_charge_goods = {}
local fields = {
	newEndTime = 26,
	name = 5,
	preGoodsId = 24,
	type = 3,
	extraDiamond = 21,
	newStartTime = 25,
	showLogoTag = 33,
	isShowTurnback = 35,
	onlineTime = 15,
	quickUseItemList = 29,
	item = 22,
	offTag = 13,
	firstDiamond = 20,
	bigImg = 8,
	diamond = 19,
	product = 9,
	id = 1,
	overviewJumpId = 34,
	nameEn = 6,
	taskid = 31,
	detailDesc = 28,
	belongStoreId = 2,
	desc = 7,
	originalCost = 18,
	slogan = 12,
	notShowInRecommend = 27,
	underlay = 10,
	price = 17,
	order = 4,
	showLinkageTag = 30,
	isOnline = 14,
	offlineTime = 16,
	limit = 23,
	showBg = 11,
	newShowLinkTag = 32
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 3,
	name = 1,
	slogan = 4,
	nameEn = 2
}
local _configList, _configDict
local configPath = "configs.store_charge_goods_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_store_charge_goods, "configList", _configList)
	rawset(lua_store_charge_goods, "configDict", _configDict)
end

setmetatable(lua_store_charge_goods, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_store_charge_goods.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_store_charge_goods, "configList", nil)
	rawset(lua_store_charge_goods, "configDict", nil)
end

return lua_store_charge_goods
