﻿module("modules.logic.pay.define.PayEnum", package.seeall)

local var_0_0 = _M

var_0_0.PayResultCode = {
	PayCancel = 901,
	PayOrderCancel = 904,
	PayError = 903,
	PayInfoFail = 902,
	PayFinish = 200,
	PayChannelFail = 905
}
var_0_0.CurrencyCode = {
	DKK = "DKK",
	CNY = "CNY",
	GBP = "GBP",
	RUB = "RUB",
	HKD = "HKD",
	ILS = "ILS",
	AUD = "AUD",
	SEK = "SEK",
	BGN = "BGN",
	HUF = "HUF",
	TZS = "TZS",
	COP = "COP",
	NZD = "NZD",
	THB = "THB",
	TRY = "TRY",
	NOK = "NOK",
	KZT = "KZT",
	EGP = "EGP",
	BRL = "BRL",
	VND = "VND",
	MXN = "MXN",
	PKR = "PKR",
	CZK = "CZK",
	CLP = "CLP",
	KRW = "KRW",
	NGN = "NGN",
	TWD = "TWD",
	MYR = "MYR",
	JPY = "JPY",
	ZAR = "ZAR",
	CHF = "CHF",
	RON = "RON",
	SAR = "SAR",
	AED = "AED",
	QAR = "QAR",
	USD = "USD",
	INR = "INR",
	PHP = "PHP",
	SGD = "SGD",
	IDR = "IDR",
	EUR = "EUR",
	PEN = "PEN",
	CAD = "CAD",
	PLN = "PLN"
}
var_0_0.CurrencySymbol = {
	[var_0_0.CurrencyCode.USD] = "US$",
	[var_0_0.CurrencyCode.KRW] = "₩",
	[var_0_0.CurrencyCode.JPY] = "¥",
	[var_0_0.CurrencyCode.EUR] = "€",
	[var_0_0.CurrencyCode.CNY] = "¥"
}
var_0_0.NoDecimalsCurrency = {
	[var_0_0.CurrencyCode.JPY] = true,
	[var_0_0.CurrencyCode.HKD] = true,
	[var_0_0.CurrencyCode.TWD] = true,
	[var_0_0.CurrencyCode.KRW] = true,
	[var_0_0.CurrencyCode.CNY] = true
}

return var_0_0
