﻿-- chunkname: @modules/proto/CurrencyModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.CurrencyModule_pb", package.seeall)

local CurrencyModule_pb = {}

CurrencyModule_pb.GETBUYPOWERINFOREQUEST_MSG = protobuf.Descriptor()
CurrencyModule_pb.BUYPOWERREPLY_MSG = protobuf.Descriptor()
CurrencyModule_pb.BUYPOWERREPLYCANBUYCOUNTFIELD = protobuf.FieldDescriptor()
CurrencyModule_pb.EXCHANGEDIAMONDREPLY_MSG = protobuf.Descriptor()
CurrencyModule_pb.EXCHANGEDIAMONDREPLYEXCHANGEDIAMONDFIELD = protobuf.FieldDescriptor()
CurrencyModule_pb.EXCHANGEDIAMONDREPLYOPTYPEFIELD = protobuf.FieldDescriptor()
CurrencyModule_pb.CURRENCY_MSG = protobuf.Descriptor()
CurrencyModule_pb.CURRENCYCURRENCYIDFIELD = protobuf.FieldDescriptor()
CurrencyModule_pb.CURRENCYQUANTITYFIELD = protobuf.FieldDescriptor()
CurrencyModule_pb.CURRENCYLASTRECOVERTIMEFIELD = protobuf.FieldDescriptor()
CurrencyModule_pb.CURRENCYEXPIREDTIMEFIELD = protobuf.FieldDescriptor()
CurrencyModule_pb.GETBUYPOWERINFOREPLY_MSG = protobuf.Descriptor()
CurrencyModule_pb.GETBUYPOWERINFOREPLYCANBUYCOUNTFIELD = protobuf.FieldDescriptor()
CurrencyModule_pb.CURRENCYCHANGEPUSH_MSG = protobuf.Descriptor()
CurrencyModule_pb.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD = protobuf.FieldDescriptor()
CurrencyModule_pb.BUYPOWERREQUEST_MSG = protobuf.Descriptor()
CurrencyModule_pb.EXCHANGEDIAMONDREQUEST_MSG = protobuf.Descriptor()
CurrencyModule_pb.EXCHANGEDIAMONDREQUESTEXCHANGEDIAMONDFIELD = protobuf.FieldDescriptor()
CurrencyModule_pb.EXCHANGEDIAMONDREQUESTOPTYPEFIELD = protobuf.FieldDescriptor()
CurrencyModule_pb.GETCURRENCYLISTREQUEST_MSG = protobuf.Descriptor()
CurrencyModule_pb.GETCURRENCYLISTREQUESTCURRENCYIDSFIELD = protobuf.FieldDescriptor()
CurrencyModule_pb.GETCURRENCYLISTREPLY_MSG = protobuf.Descriptor()
CurrencyModule_pb.GETCURRENCYLISTREPLYCURRENCYLISTFIELD = protobuf.FieldDescriptor()
CurrencyModule_pb.GETBUYPOWERINFOREQUEST_MSG.name = "GetBuyPowerInfoRequest"
CurrencyModule_pb.GETBUYPOWERINFOREQUEST_MSG.full_name = ".GetBuyPowerInfoRequest"
CurrencyModule_pb.GETBUYPOWERINFOREQUEST_MSG.nested_types = {}
CurrencyModule_pb.GETBUYPOWERINFOREQUEST_MSG.enum_types = {}
CurrencyModule_pb.GETBUYPOWERINFOREQUEST_MSG.fields = {}
CurrencyModule_pb.GETBUYPOWERINFOREQUEST_MSG.is_extendable = false
CurrencyModule_pb.GETBUYPOWERINFOREQUEST_MSG.extensions = {}
CurrencyModule_pb.BUYPOWERREPLYCANBUYCOUNTFIELD.name = "canBuyCount"
CurrencyModule_pb.BUYPOWERREPLYCANBUYCOUNTFIELD.full_name = ".BuyPowerReply.canBuyCount"
CurrencyModule_pb.BUYPOWERREPLYCANBUYCOUNTFIELD.number = 1
CurrencyModule_pb.BUYPOWERREPLYCANBUYCOUNTFIELD.index = 0
CurrencyModule_pb.BUYPOWERREPLYCANBUYCOUNTFIELD.label = 1
CurrencyModule_pb.BUYPOWERREPLYCANBUYCOUNTFIELD.has_default_value = false
CurrencyModule_pb.BUYPOWERREPLYCANBUYCOUNTFIELD.default_value = 0
CurrencyModule_pb.BUYPOWERREPLYCANBUYCOUNTFIELD.type = 5
CurrencyModule_pb.BUYPOWERREPLYCANBUYCOUNTFIELD.cpp_type = 1
CurrencyModule_pb.BUYPOWERREPLY_MSG.name = "BuyPowerReply"
CurrencyModule_pb.BUYPOWERREPLY_MSG.full_name = ".BuyPowerReply"
CurrencyModule_pb.BUYPOWERREPLY_MSG.nested_types = {}
CurrencyModule_pb.BUYPOWERREPLY_MSG.enum_types = {}
CurrencyModule_pb.BUYPOWERREPLY_MSG.fields = {
	CurrencyModule_pb.BUYPOWERREPLYCANBUYCOUNTFIELD
}
CurrencyModule_pb.BUYPOWERREPLY_MSG.is_extendable = false
CurrencyModule_pb.BUYPOWERREPLY_MSG.extensions = {}
CurrencyModule_pb.EXCHANGEDIAMONDREPLYEXCHANGEDIAMONDFIELD.name = "exchangeDiamond"
CurrencyModule_pb.EXCHANGEDIAMONDREPLYEXCHANGEDIAMONDFIELD.full_name = ".ExchangeDiamondReply.exchangeDiamond"
CurrencyModule_pb.EXCHANGEDIAMONDREPLYEXCHANGEDIAMONDFIELD.number = 1
CurrencyModule_pb.EXCHANGEDIAMONDREPLYEXCHANGEDIAMONDFIELD.index = 0
CurrencyModule_pb.EXCHANGEDIAMONDREPLYEXCHANGEDIAMONDFIELD.label = 1
CurrencyModule_pb.EXCHANGEDIAMONDREPLYEXCHANGEDIAMONDFIELD.has_default_value = false
CurrencyModule_pb.EXCHANGEDIAMONDREPLYEXCHANGEDIAMONDFIELD.default_value = 0
CurrencyModule_pb.EXCHANGEDIAMONDREPLYEXCHANGEDIAMONDFIELD.type = 5
CurrencyModule_pb.EXCHANGEDIAMONDREPLYEXCHANGEDIAMONDFIELD.cpp_type = 1
CurrencyModule_pb.EXCHANGEDIAMONDREPLYOPTYPEFIELD.name = "opType"
CurrencyModule_pb.EXCHANGEDIAMONDREPLYOPTYPEFIELD.full_name = ".ExchangeDiamondReply.opType"
CurrencyModule_pb.EXCHANGEDIAMONDREPLYOPTYPEFIELD.number = 2
CurrencyModule_pb.EXCHANGEDIAMONDREPLYOPTYPEFIELD.index = 1
CurrencyModule_pb.EXCHANGEDIAMONDREPLYOPTYPEFIELD.label = 1
CurrencyModule_pb.EXCHANGEDIAMONDREPLYOPTYPEFIELD.has_default_value = false
CurrencyModule_pb.EXCHANGEDIAMONDREPLYOPTYPEFIELD.default_value = 0
CurrencyModule_pb.EXCHANGEDIAMONDREPLYOPTYPEFIELD.type = 5
CurrencyModule_pb.EXCHANGEDIAMONDREPLYOPTYPEFIELD.cpp_type = 1
CurrencyModule_pb.EXCHANGEDIAMONDREPLY_MSG.name = "ExchangeDiamondReply"
CurrencyModule_pb.EXCHANGEDIAMONDREPLY_MSG.full_name = ".ExchangeDiamondReply"
CurrencyModule_pb.EXCHANGEDIAMONDREPLY_MSG.nested_types = {}
CurrencyModule_pb.EXCHANGEDIAMONDREPLY_MSG.enum_types = {}
CurrencyModule_pb.EXCHANGEDIAMONDREPLY_MSG.fields = {
	CurrencyModule_pb.EXCHANGEDIAMONDREPLYEXCHANGEDIAMONDFIELD,
	CurrencyModule_pb.EXCHANGEDIAMONDREPLYOPTYPEFIELD
}
CurrencyModule_pb.EXCHANGEDIAMONDREPLY_MSG.is_extendable = false
CurrencyModule_pb.EXCHANGEDIAMONDREPLY_MSG.extensions = {}
CurrencyModule_pb.CURRENCYCURRENCYIDFIELD.name = "currencyId"
CurrencyModule_pb.CURRENCYCURRENCYIDFIELD.full_name = ".Currency.currencyId"
CurrencyModule_pb.CURRENCYCURRENCYIDFIELD.number = 1
CurrencyModule_pb.CURRENCYCURRENCYIDFIELD.index = 0
CurrencyModule_pb.CURRENCYCURRENCYIDFIELD.label = 1
CurrencyModule_pb.CURRENCYCURRENCYIDFIELD.has_default_value = false
CurrencyModule_pb.CURRENCYCURRENCYIDFIELD.default_value = 0
CurrencyModule_pb.CURRENCYCURRENCYIDFIELD.type = 13
CurrencyModule_pb.CURRENCYCURRENCYIDFIELD.cpp_type = 3
CurrencyModule_pb.CURRENCYQUANTITYFIELD.name = "quantity"
CurrencyModule_pb.CURRENCYQUANTITYFIELD.full_name = ".Currency.quantity"
CurrencyModule_pb.CURRENCYQUANTITYFIELD.number = 2
CurrencyModule_pb.CURRENCYQUANTITYFIELD.index = 1
CurrencyModule_pb.CURRENCYQUANTITYFIELD.label = 1
CurrencyModule_pb.CURRENCYQUANTITYFIELD.has_default_value = false
CurrencyModule_pb.CURRENCYQUANTITYFIELD.default_value = 0
CurrencyModule_pb.CURRENCYQUANTITYFIELD.type = 5
CurrencyModule_pb.CURRENCYQUANTITYFIELD.cpp_type = 1
CurrencyModule_pb.CURRENCYLASTRECOVERTIMEFIELD.name = "lastRecoverTime"
CurrencyModule_pb.CURRENCYLASTRECOVERTIMEFIELD.full_name = ".Currency.lastRecoverTime"
CurrencyModule_pb.CURRENCYLASTRECOVERTIMEFIELD.number = 3
CurrencyModule_pb.CURRENCYLASTRECOVERTIMEFIELD.index = 2
CurrencyModule_pb.CURRENCYLASTRECOVERTIMEFIELD.label = 1
CurrencyModule_pb.CURRENCYLASTRECOVERTIMEFIELD.has_default_value = false
CurrencyModule_pb.CURRENCYLASTRECOVERTIMEFIELD.default_value = 0
CurrencyModule_pb.CURRENCYLASTRECOVERTIMEFIELD.type = 4
CurrencyModule_pb.CURRENCYLASTRECOVERTIMEFIELD.cpp_type = 4
CurrencyModule_pb.CURRENCYEXPIREDTIMEFIELD.name = "expiredTime"
CurrencyModule_pb.CURRENCYEXPIREDTIMEFIELD.full_name = ".Currency.expiredTime"
CurrencyModule_pb.CURRENCYEXPIREDTIMEFIELD.number = 4
CurrencyModule_pb.CURRENCYEXPIREDTIMEFIELD.index = 3
CurrencyModule_pb.CURRENCYEXPIREDTIMEFIELD.label = 1
CurrencyModule_pb.CURRENCYEXPIREDTIMEFIELD.has_default_value = false
CurrencyModule_pb.CURRENCYEXPIREDTIMEFIELD.default_value = 0
CurrencyModule_pb.CURRENCYEXPIREDTIMEFIELD.type = 4
CurrencyModule_pb.CURRENCYEXPIREDTIMEFIELD.cpp_type = 4
CurrencyModule_pb.CURRENCY_MSG.name = "Currency"
CurrencyModule_pb.CURRENCY_MSG.full_name = ".Currency"
CurrencyModule_pb.CURRENCY_MSG.nested_types = {}
CurrencyModule_pb.CURRENCY_MSG.enum_types = {}
CurrencyModule_pb.CURRENCY_MSG.fields = {
	CurrencyModule_pb.CURRENCYCURRENCYIDFIELD,
	CurrencyModule_pb.CURRENCYQUANTITYFIELD,
	CurrencyModule_pb.CURRENCYLASTRECOVERTIMEFIELD,
	CurrencyModule_pb.CURRENCYEXPIREDTIMEFIELD
}
CurrencyModule_pb.CURRENCY_MSG.is_extendable = false
CurrencyModule_pb.CURRENCY_MSG.extensions = {}
CurrencyModule_pb.GETBUYPOWERINFOREPLYCANBUYCOUNTFIELD.name = "canBuyCount"
CurrencyModule_pb.GETBUYPOWERINFOREPLYCANBUYCOUNTFIELD.full_name = ".GetBuyPowerInfoReply.canBuyCount"
CurrencyModule_pb.GETBUYPOWERINFOREPLYCANBUYCOUNTFIELD.number = 1
CurrencyModule_pb.GETBUYPOWERINFOREPLYCANBUYCOUNTFIELD.index = 0
CurrencyModule_pb.GETBUYPOWERINFOREPLYCANBUYCOUNTFIELD.label = 1
CurrencyModule_pb.GETBUYPOWERINFOREPLYCANBUYCOUNTFIELD.has_default_value = false
CurrencyModule_pb.GETBUYPOWERINFOREPLYCANBUYCOUNTFIELD.default_value = 0
CurrencyModule_pb.GETBUYPOWERINFOREPLYCANBUYCOUNTFIELD.type = 5
CurrencyModule_pb.GETBUYPOWERINFOREPLYCANBUYCOUNTFIELD.cpp_type = 1
CurrencyModule_pb.GETBUYPOWERINFOREPLY_MSG.name = "GetBuyPowerInfoReply"
CurrencyModule_pb.GETBUYPOWERINFOREPLY_MSG.full_name = ".GetBuyPowerInfoReply"
CurrencyModule_pb.GETBUYPOWERINFOREPLY_MSG.nested_types = {}
CurrencyModule_pb.GETBUYPOWERINFOREPLY_MSG.enum_types = {}
CurrencyModule_pb.GETBUYPOWERINFOREPLY_MSG.fields = {
	CurrencyModule_pb.GETBUYPOWERINFOREPLYCANBUYCOUNTFIELD
}
CurrencyModule_pb.GETBUYPOWERINFOREPLY_MSG.is_extendable = false
CurrencyModule_pb.GETBUYPOWERINFOREPLY_MSG.extensions = {}
CurrencyModule_pb.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD.name = "changeCurrency"
CurrencyModule_pb.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD.full_name = ".CurrencyChangePush.changeCurrency"
CurrencyModule_pb.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD.number = 1
CurrencyModule_pb.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD.index = 0
CurrencyModule_pb.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD.label = 3
CurrencyModule_pb.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD.has_default_value = false
CurrencyModule_pb.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD.default_value = {}
CurrencyModule_pb.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD.message_type = CurrencyModule_pb.CURRENCY_MSG
CurrencyModule_pb.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD.type = 11
CurrencyModule_pb.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD.cpp_type = 10
CurrencyModule_pb.CURRENCYCHANGEPUSH_MSG.name = "CurrencyChangePush"
CurrencyModule_pb.CURRENCYCHANGEPUSH_MSG.full_name = ".CurrencyChangePush"
CurrencyModule_pb.CURRENCYCHANGEPUSH_MSG.nested_types = {}
CurrencyModule_pb.CURRENCYCHANGEPUSH_MSG.enum_types = {}
CurrencyModule_pb.CURRENCYCHANGEPUSH_MSG.fields = {
	CurrencyModule_pb.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD
}
CurrencyModule_pb.CURRENCYCHANGEPUSH_MSG.is_extendable = false
CurrencyModule_pb.CURRENCYCHANGEPUSH_MSG.extensions = {}
CurrencyModule_pb.BUYPOWERREQUEST_MSG.name = "BuyPowerRequest"
CurrencyModule_pb.BUYPOWERREQUEST_MSG.full_name = ".BuyPowerRequest"
CurrencyModule_pb.BUYPOWERREQUEST_MSG.nested_types = {}
CurrencyModule_pb.BUYPOWERREQUEST_MSG.enum_types = {}
CurrencyModule_pb.BUYPOWERREQUEST_MSG.fields = {}
CurrencyModule_pb.BUYPOWERREQUEST_MSG.is_extendable = false
CurrencyModule_pb.BUYPOWERREQUEST_MSG.extensions = {}
CurrencyModule_pb.EXCHANGEDIAMONDREQUESTEXCHANGEDIAMONDFIELD.name = "exchangeDiamond"
CurrencyModule_pb.EXCHANGEDIAMONDREQUESTEXCHANGEDIAMONDFIELD.full_name = ".ExchangeDiamondRequest.exchangeDiamond"
CurrencyModule_pb.EXCHANGEDIAMONDREQUESTEXCHANGEDIAMONDFIELD.number = 1
CurrencyModule_pb.EXCHANGEDIAMONDREQUESTEXCHANGEDIAMONDFIELD.index = 0
CurrencyModule_pb.EXCHANGEDIAMONDREQUESTEXCHANGEDIAMONDFIELD.label = 1
CurrencyModule_pb.EXCHANGEDIAMONDREQUESTEXCHANGEDIAMONDFIELD.has_default_value = false
CurrencyModule_pb.EXCHANGEDIAMONDREQUESTEXCHANGEDIAMONDFIELD.default_value = 0
CurrencyModule_pb.EXCHANGEDIAMONDREQUESTEXCHANGEDIAMONDFIELD.type = 5
CurrencyModule_pb.EXCHANGEDIAMONDREQUESTEXCHANGEDIAMONDFIELD.cpp_type = 1
CurrencyModule_pb.EXCHANGEDIAMONDREQUESTOPTYPEFIELD.name = "opType"
CurrencyModule_pb.EXCHANGEDIAMONDREQUESTOPTYPEFIELD.full_name = ".ExchangeDiamondRequest.opType"
CurrencyModule_pb.EXCHANGEDIAMONDREQUESTOPTYPEFIELD.number = 2
CurrencyModule_pb.EXCHANGEDIAMONDREQUESTOPTYPEFIELD.index = 1
CurrencyModule_pb.EXCHANGEDIAMONDREQUESTOPTYPEFIELD.label = 1
CurrencyModule_pb.EXCHANGEDIAMONDREQUESTOPTYPEFIELD.has_default_value = false
CurrencyModule_pb.EXCHANGEDIAMONDREQUESTOPTYPEFIELD.default_value = 0
CurrencyModule_pb.EXCHANGEDIAMONDREQUESTOPTYPEFIELD.type = 5
CurrencyModule_pb.EXCHANGEDIAMONDREQUESTOPTYPEFIELD.cpp_type = 1
CurrencyModule_pb.EXCHANGEDIAMONDREQUEST_MSG.name = "ExchangeDiamondRequest"
CurrencyModule_pb.EXCHANGEDIAMONDREQUEST_MSG.full_name = ".ExchangeDiamondRequest"
CurrencyModule_pb.EXCHANGEDIAMONDREQUEST_MSG.nested_types = {}
CurrencyModule_pb.EXCHANGEDIAMONDREQUEST_MSG.enum_types = {}
CurrencyModule_pb.EXCHANGEDIAMONDREQUEST_MSG.fields = {
	CurrencyModule_pb.EXCHANGEDIAMONDREQUESTEXCHANGEDIAMONDFIELD,
	CurrencyModule_pb.EXCHANGEDIAMONDREQUESTOPTYPEFIELD
}
CurrencyModule_pb.EXCHANGEDIAMONDREQUEST_MSG.is_extendable = false
CurrencyModule_pb.EXCHANGEDIAMONDREQUEST_MSG.extensions = {}
CurrencyModule_pb.GETCURRENCYLISTREQUESTCURRENCYIDSFIELD.name = "currencyIds"
CurrencyModule_pb.GETCURRENCYLISTREQUESTCURRENCYIDSFIELD.full_name = ".GetCurrencyListRequest.currencyIds"
CurrencyModule_pb.GETCURRENCYLISTREQUESTCURRENCYIDSFIELD.number = 1
CurrencyModule_pb.GETCURRENCYLISTREQUESTCURRENCYIDSFIELD.index = 0
CurrencyModule_pb.GETCURRENCYLISTREQUESTCURRENCYIDSFIELD.label = 3
CurrencyModule_pb.GETCURRENCYLISTREQUESTCURRENCYIDSFIELD.has_default_value = false
CurrencyModule_pb.GETCURRENCYLISTREQUESTCURRENCYIDSFIELD.default_value = {}
CurrencyModule_pb.GETCURRENCYLISTREQUESTCURRENCYIDSFIELD.type = 5
CurrencyModule_pb.GETCURRENCYLISTREQUESTCURRENCYIDSFIELD.cpp_type = 1
CurrencyModule_pb.GETCURRENCYLISTREQUEST_MSG.name = "GetCurrencyListRequest"
CurrencyModule_pb.GETCURRENCYLISTREQUEST_MSG.full_name = ".GetCurrencyListRequest"
CurrencyModule_pb.GETCURRENCYLISTREQUEST_MSG.nested_types = {}
CurrencyModule_pb.GETCURRENCYLISTREQUEST_MSG.enum_types = {}
CurrencyModule_pb.GETCURRENCYLISTREQUEST_MSG.fields = {
	CurrencyModule_pb.GETCURRENCYLISTREQUESTCURRENCYIDSFIELD
}
CurrencyModule_pb.GETCURRENCYLISTREQUEST_MSG.is_extendable = false
CurrencyModule_pb.GETCURRENCYLISTREQUEST_MSG.extensions = {}
CurrencyModule_pb.GETCURRENCYLISTREPLYCURRENCYLISTFIELD.name = "currencyList"
CurrencyModule_pb.GETCURRENCYLISTREPLYCURRENCYLISTFIELD.full_name = ".GetCurrencyListReply.currencyList"
CurrencyModule_pb.GETCURRENCYLISTREPLYCURRENCYLISTFIELD.number = 1
CurrencyModule_pb.GETCURRENCYLISTREPLYCURRENCYLISTFIELD.index = 0
CurrencyModule_pb.GETCURRENCYLISTREPLYCURRENCYLISTFIELD.label = 3
CurrencyModule_pb.GETCURRENCYLISTREPLYCURRENCYLISTFIELD.has_default_value = false
CurrencyModule_pb.GETCURRENCYLISTREPLYCURRENCYLISTFIELD.default_value = {}
CurrencyModule_pb.GETCURRENCYLISTREPLYCURRENCYLISTFIELD.message_type = CurrencyModule_pb.CURRENCY_MSG
CurrencyModule_pb.GETCURRENCYLISTREPLYCURRENCYLISTFIELD.type = 11
CurrencyModule_pb.GETCURRENCYLISTREPLYCURRENCYLISTFIELD.cpp_type = 10
CurrencyModule_pb.GETCURRENCYLISTREPLY_MSG.name = "GetCurrencyListReply"
CurrencyModule_pb.GETCURRENCYLISTREPLY_MSG.full_name = ".GetCurrencyListReply"
CurrencyModule_pb.GETCURRENCYLISTREPLY_MSG.nested_types = {}
CurrencyModule_pb.GETCURRENCYLISTREPLY_MSG.enum_types = {}
CurrencyModule_pb.GETCURRENCYLISTREPLY_MSG.fields = {
	CurrencyModule_pb.GETCURRENCYLISTREPLYCURRENCYLISTFIELD
}
CurrencyModule_pb.GETCURRENCYLISTREPLY_MSG.is_extendable = false
CurrencyModule_pb.GETCURRENCYLISTREPLY_MSG.extensions = {}
CurrencyModule_pb.BuyPowerReply = protobuf.Message(CurrencyModule_pb.BUYPOWERREPLY_MSG)
CurrencyModule_pb.BuyPowerRequest = protobuf.Message(CurrencyModule_pb.BUYPOWERREQUEST_MSG)
CurrencyModule_pb.Currency = protobuf.Message(CurrencyModule_pb.CURRENCY_MSG)
CurrencyModule_pb.CurrencyChangePush = protobuf.Message(CurrencyModule_pb.CURRENCYCHANGEPUSH_MSG)
CurrencyModule_pb.ExchangeDiamondReply = protobuf.Message(CurrencyModule_pb.EXCHANGEDIAMONDREPLY_MSG)
CurrencyModule_pb.ExchangeDiamondRequest = protobuf.Message(CurrencyModule_pb.EXCHANGEDIAMONDREQUEST_MSG)
CurrencyModule_pb.GetBuyPowerInfoReply = protobuf.Message(CurrencyModule_pb.GETBUYPOWERINFOREPLY_MSG)
CurrencyModule_pb.GetBuyPowerInfoRequest = protobuf.Message(CurrencyModule_pb.GETBUYPOWERINFOREQUEST_MSG)
CurrencyModule_pb.GetCurrencyListReply = protobuf.Message(CurrencyModule_pb.GETCURRENCYLISTREPLY_MSG)
CurrencyModule_pb.GetCurrencyListRequest = protobuf.Message(CurrencyModule_pb.GETCURRENCYLISTREQUEST_MSG)

return CurrencyModule_pb
