﻿-- chunkname: @modules/logic/pay/model/PayModel_NativesImpl.lua

module("modules.logic.pay.model.PayModel_NativesImpl", package.seeall)

local PayModel_NativesImpl = LuaUtil.class("PayModel_NativesImpl", PayModelBase)

function PayModel_NativesImpl:ctor()
	assert(false, "PayModel_NativesImpl is an abstract class, please use PayModel instead.")
end

function PayModel_NativesImpl:getProductPrice(lua_store_charge_goods_id)
	local symbol = self:getProductOriginPriceSymbol(lua_store_charge_goods_id)
	local price = self:getProductOriginPriceNum(lua_store_charge_goods_id)

	return string.format("%s%s", symbol, price)
end

function PayModel_NativesImpl:getProductOriginPriceNum(lua_store_charge_goods_id)
	local price = 0
	local chargeConfig = StoreConfig.instance:getChargeGoodsConfig(lua_store_charge_goods_id)

	if chargeConfig then
		price = chargeConfig.price
	end

	local code = self:getProductOriginCurrency(lua_store_charge_goods_id)
	local isNoDecimalsCurrency = self:isNoDecimalsCurrency(code)
	local priceStr

	if isNoDecimalsCurrency then
		priceStr = math.floor(price)
	else
		priceStr = tostring(price)
	end

	return price, priceStr, isNoDecimalsCurrency
end

function PayModel_NativesImpl:getProductOriginCurrency(lua_store_charge_goods_id)
	return PayEnum.CurrencyCode.CNY
end

function PayModel_NativesImpl:getProductOriginPriceSymbol(lua_store_charge_goods_id)
	return "¥"
end

return PayModel_NativesImpl
