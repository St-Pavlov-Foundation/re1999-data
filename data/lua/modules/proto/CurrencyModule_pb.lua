slot1 = require("protobuf.protobuf")

module("modules.proto.CurrencyModule_pb", package.seeall)

slot2 = {
	GETBUYPOWERINFOREQUEST_MSG = slot1.Descriptor(),
	BUYPOWERREPLY_MSG = slot1.Descriptor(),
	BUYPOWERREPLYCANBUYCOUNTFIELD = slot1.FieldDescriptor(),
	EXCHANGEDIAMONDREPLY_MSG = slot1.Descriptor(),
	EXCHANGEDIAMONDREPLYEXCHANGEDIAMONDFIELD = slot1.FieldDescriptor(),
	EXCHANGEDIAMONDREPLYOPTYPEFIELD = slot1.FieldDescriptor(),
	CURRENCY_MSG = slot1.Descriptor(),
	CURRENCYCURRENCYIDFIELD = slot1.FieldDescriptor(),
	CURRENCYQUANTITYFIELD = slot1.FieldDescriptor(),
	CURRENCYLASTRECOVERTIMEFIELD = slot1.FieldDescriptor(),
	CURRENCYEXPIREDTIMEFIELD = slot1.FieldDescriptor(),
	GETBUYPOWERINFOREPLY_MSG = slot1.Descriptor(),
	GETBUYPOWERINFOREPLYCANBUYCOUNTFIELD = slot1.FieldDescriptor(),
	CURRENCYCHANGEPUSH_MSG = slot1.Descriptor(),
	CURRENCYCHANGEPUSHCHANGECURRENCYFIELD = slot1.FieldDescriptor(),
	BUYPOWERREQUEST_MSG = slot1.Descriptor(),
	EXCHANGEDIAMONDREQUEST_MSG = slot1.Descriptor(),
	EXCHANGEDIAMONDREQUESTEXCHANGEDIAMONDFIELD = slot1.FieldDescriptor(),
	EXCHANGEDIAMONDREQUESTOPTYPEFIELD = slot1.FieldDescriptor(),
	GETCURRENCYLISTREQUEST_MSG = slot1.Descriptor(),
	GETCURRENCYLISTREQUESTCURRENCYIDSFIELD = slot1.FieldDescriptor(),
	GETCURRENCYLISTREPLY_MSG = slot1.Descriptor(),
	GETCURRENCYLISTREPLYCURRENCYLISTFIELD = slot1.FieldDescriptor()
}
slot2.GETBUYPOWERINFOREQUEST_MSG.name = "GetBuyPowerInfoRequest"
slot2.GETBUYPOWERINFOREQUEST_MSG.full_name = ".GetBuyPowerInfoRequest"
slot2.GETBUYPOWERINFOREQUEST_MSG.nested_types = {}
slot2.GETBUYPOWERINFOREQUEST_MSG.enum_types = {}
slot2.GETBUYPOWERINFOREQUEST_MSG.fields = {}
slot2.GETBUYPOWERINFOREQUEST_MSG.is_extendable = false
slot2.GETBUYPOWERINFOREQUEST_MSG.extensions = {}
slot2.BUYPOWERREPLYCANBUYCOUNTFIELD.name = "canBuyCount"
slot2.BUYPOWERREPLYCANBUYCOUNTFIELD.full_name = ".BuyPowerReply.canBuyCount"
slot2.BUYPOWERREPLYCANBUYCOUNTFIELD.number = 1
slot2.BUYPOWERREPLYCANBUYCOUNTFIELD.index = 0
slot2.BUYPOWERREPLYCANBUYCOUNTFIELD.label = 1
slot2.BUYPOWERREPLYCANBUYCOUNTFIELD.has_default_value = false
slot2.BUYPOWERREPLYCANBUYCOUNTFIELD.default_value = 0
slot2.BUYPOWERREPLYCANBUYCOUNTFIELD.type = 5
slot2.BUYPOWERREPLYCANBUYCOUNTFIELD.cpp_type = 1
slot2.BUYPOWERREPLY_MSG.name = "BuyPowerReply"
slot2.BUYPOWERREPLY_MSG.full_name = ".BuyPowerReply"
slot2.BUYPOWERREPLY_MSG.nested_types = {}
slot2.BUYPOWERREPLY_MSG.enum_types = {}
slot2.BUYPOWERREPLY_MSG.fields = {
	slot2.BUYPOWERREPLYCANBUYCOUNTFIELD
}
slot2.BUYPOWERREPLY_MSG.is_extendable = false
slot2.BUYPOWERREPLY_MSG.extensions = {}
slot2.EXCHANGEDIAMONDREPLYEXCHANGEDIAMONDFIELD.name = "exchangeDiamond"
slot2.EXCHANGEDIAMONDREPLYEXCHANGEDIAMONDFIELD.full_name = ".ExchangeDiamondReply.exchangeDiamond"
slot2.EXCHANGEDIAMONDREPLYEXCHANGEDIAMONDFIELD.number = 1
slot2.EXCHANGEDIAMONDREPLYEXCHANGEDIAMONDFIELD.index = 0
slot2.EXCHANGEDIAMONDREPLYEXCHANGEDIAMONDFIELD.label = 1
slot2.EXCHANGEDIAMONDREPLYEXCHANGEDIAMONDFIELD.has_default_value = false
slot2.EXCHANGEDIAMONDREPLYEXCHANGEDIAMONDFIELD.default_value = 0
slot2.EXCHANGEDIAMONDREPLYEXCHANGEDIAMONDFIELD.type = 5
slot2.EXCHANGEDIAMONDREPLYEXCHANGEDIAMONDFIELD.cpp_type = 1
slot2.EXCHANGEDIAMONDREPLYOPTYPEFIELD.name = "opType"
slot2.EXCHANGEDIAMONDREPLYOPTYPEFIELD.full_name = ".ExchangeDiamondReply.opType"
slot2.EXCHANGEDIAMONDREPLYOPTYPEFIELD.number = 2
slot2.EXCHANGEDIAMONDREPLYOPTYPEFIELD.index = 1
slot2.EXCHANGEDIAMONDREPLYOPTYPEFIELD.label = 1
slot2.EXCHANGEDIAMONDREPLYOPTYPEFIELD.has_default_value = false
slot2.EXCHANGEDIAMONDREPLYOPTYPEFIELD.default_value = 0
slot2.EXCHANGEDIAMONDREPLYOPTYPEFIELD.type = 5
slot2.EXCHANGEDIAMONDREPLYOPTYPEFIELD.cpp_type = 1
slot2.EXCHANGEDIAMONDREPLY_MSG.name = "ExchangeDiamondReply"
slot2.EXCHANGEDIAMONDREPLY_MSG.full_name = ".ExchangeDiamondReply"
slot2.EXCHANGEDIAMONDREPLY_MSG.nested_types = {}
slot2.EXCHANGEDIAMONDREPLY_MSG.enum_types = {}
slot2.EXCHANGEDIAMONDREPLY_MSG.fields = {
	slot2.EXCHANGEDIAMONDREPLYEXCHANGEDIAMONDFIELD,
	slot2.EXCHANGEDIAMONDREPLYOPTYPEFIELD
}
slot2.EXCHANGEDIAMONDREPLY_MSG.is_extendable = false
slot2.EXCHANGEDIAMONDREPLY_MSG.extensions = {}
slot2.CURRENCYCURRENCYIDFIELD.name = "currencyId"
slot2.CURRENCYCURRENCYIDFIELD.full_name = ".Currency.currencyId"
slot2.CURRENCYCURRENCYIDFIELD.number = 1
slot2.CURRENCYCURRENCYIDFIELD.index = 0
slot2.CURRENCYCURRENCYIDFIELD.label = 1
slot2.CURRENCYCURRENCYIDFIELD.has_default_value = false
slot2.CURRENCYCURRENCYIDFIELD.default_value = 0
slot2.CURRENCYCURRENCYIDFIELD.type = 13
slot2.CURRENCYCURRENCYIDFIELD.cpp_type = 3
slot2.CURRENCYQUANTITYFIELD.name = "quantity"
slot2.CURRENCYQUANTITYFIELD.full_name = ".Currency.quantity"
slot2.CURRENCYQUANTITYFIELD.number = 2
slot2.CURRENCYQUANTITYFIELD.index = 1
slot2.CURRENCYQUANTITYFIELD.label = 1
slot2.CURRENCYQUANTITYFIELD.has_default_value = false
slot2.CURRENCYQUANTITYFIELD.default_value = 0
slot2.CURRENCYQUANTITYFIELD.type = 5
slot2.CURRENCYQUANTITYFIELD.cpp_type = 1
slot2.CURRENCYLASTRECOVERTIMEFIELD.name = "lastRecoverTime"
slot2.CURRENCYLASTRECOVERTIMEFIELD.full_name = ".Currency.lastRecoverTime"
slot2.CURRENCYLASTRECOVERTIMEFIELD.number = 3
slot2.CURRENCYLASTRECOVERTIMEFIELD.index = 2
slot2.CURRENCYLASTRECOVERTIMEFIELD.label = 1
slot2.CURRENCYLASTRECOVERTIMEFIELD.has_default_value = false
slot2.CURRENCYLASTRECOVERTIMEFIELD.default_value = 0
slot2.CURRENCYLASTRECOVERTIMEFIELD.type = 4
slot2.CURRENCYLASTRECOVERTIMEFIELD.cpp_type = 4
slot2.CURRENCYEXPIREDTIMEFIELD.name = "expiredTime"
slot2.CURRENCYEXPIREDTIMEFIELD.full_name = ".Currency.expiredTime"
slot2.CURRENCYEXPIREDTIMEFIELD.number = 4
slot2.CURRENCYEXPIREDTIMEFIELD.index = 3
slot2.CURRENCYEXPIREDTIMEFIELD.label = 1
slot2.CURRENCYEXPIREDTIMEFIELD.has_default_value = false
slot2.CURRENCYEXPIREDTIMEFIELD.default_value = 0
slot2.CURRENCYEXPIREDTIMEFIELD.type = 4
slot2.CURRENCYEXPIREDTIMEFIELD.cpp_type = 4
slot2.CURRENCY_MSG.name = "Currency"
slot2.CURRENCY_MSG.full_name = ".Currency"
slot2.CURRENCY_MSG.nested_types = {}
slot2.CURRENCY_MSG.enum_types = {}
slot2.CURRENCY_MSG.fields = {
	slot2.CURRENCYCURRENCYIDFIELD,
	slot2.CURRENCYQUANTITYFIELD,
	slot2.CURRENCYLASTRECOVERTIMEFIELD,
	slot2.CURRENCYEXPIREDTIMEFIELD
}
slot2.CURRENCY_MSG.is_extendable = false
slot2.CURRENCY_MSG.extensions = {}
slot2.GETBUYPOWERINFOREPLYCANBUYCOUNTFIELD.name = "canBuyCount"
slot2.GETBUYPOWERINFOREPLYCANBUYCOUNTFIELD.full_name = ".GetBuyPowerInfoReply.canBuyCount"
slot2.GETBUYPOWERINFOREPLYCANBUYCOUNTFIELD.number = 1
slot2.GETBUYPOWERINFOREPLYCANBUYCOUNTFIELD.index = 0
slot2.GETBUYPOWERINFOREPLYCANBUYCOUNTFIELD.label = 1
slot2.GETBUYPOWERINFOREPLYCANBUYCOUNTFIELD.has_default_value = false
slot2.GETBUYPOWERINFOREPLYCANBUYCOUNTFIELD.default_value = 0
slot2.GETBUYPOWERINFOREPLYCANBUYCOUNTFIELD.type = 5
slot2.GETBUYPOWERINFOREPLYCANBUYCOUNTFIELD.cpp_type = 1
slot2.GETBUYPOWERINFOREPLY_MSG.name = "GetBuyPowerInfoReply"
slot2.GETBUYPOWERINFOREPLY_MSG.full_name = ".GetBuyPowerInfoReply"
slot2.GETBUYPOWERINFOREPLY_MSG.nested_types = {}
slot2.GETBUYPOWERINFOREPLY_MSG.enum_types = {}
slot2.GETBUYPOWERINFOREPLY_MSG.fields = {
	slot2.GETBUYPOWERINFOREPLYCANBUYCOUNTFIELD
}
slot2.GETBUYPOWERINFOREPLY_MSG.is_extendable = false
slot2.GETBUYPOWERINFOREPLY_MSG.extensions = {}
slot2.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD.name = "changeCurrency"
slot2.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD.full_name = ".CurrencyChangePush.changeCurrency"
slot2.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD.number = 1
slot2.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD.index = 0
slot2.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD.label = 3
slot2.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD.has_default_value = false
slot2.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD.default_value = {}
slot2.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD.message_type = slot2.CURRENCY_MSG
slot2.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD.type = 11
slot2.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD.cpp_type = 10
slot2.CURRENCYCHANGEPUSH_MSG.name = "CurrencyChangePush"
slot2.CURRENCYCHANGEPUSH_MSG.full_name = ".CurrencyChangePush"
slot2.CURRENCYCHANGEPUSH_MSG.nested_types = {}
slot2.CURRENCYCHANGEPUSH_MSG.enum_types = {}
slot2.CURRENCYCHANGEPUSH_MSG.fields = {
	slot2.CURRENCYCHANGEPUSHCHANGECURRENCYFIELD
}
slot2.CURRENCYCHANGEPUSH_MSG.is_extendable = false
slot2.CURRENCYCHANGEPUSH_MSG.extensions = {}
slot2.BUYPOWERREQUEST_MSG.name = "BuyPowerRequest"
slot2.BUYPOWERREQUEST_MSG.full_name = ".BuyPowerRequest"
slot2.BUYPOWERREQUEST_MSG.nested_types = {}
slot2.BUYPOWERREQUEST_MSG.enum_types = {}
slot2.BUYPOWERREQUEST_MSG.fields = {}
slot2.BUYPOWERREQUEST_MSG.is_extendable = false
slot2.BUYPOWERREQUEST_MSG.extensions = {}
slot2.EXCHANGEDIAMONDREQUESTEXCHANGEDIAMONDFIELD.name = "exchangeDiamond"
slot2.EXCHANGEDIAMONDREQUESTEXCHANGEDIAMONDFIELD.full_name = ".ExchangeDiamondRequest.exchangeDiamond"
slot2.EXCHANGEDIAMONDREQUESTEXCHANGEDIAMONDFIELD.number = 1
slot2.EXCHANGEDIAMONDREQUESTEXCHANGEDIAMONDFIELD.index = 0
slot2.EXCHANGEDIAMONDREQUESTEXCHANGEDIAMONDFIELD.label = 1
slot2.EXCHANGEDIAMONDREQUESTEXCHANGEDIAMONDFIELD.has_default_value = false
slot2.EXCHANGEDIAMONDREQUESTEXCHANGEDIAMONDFIELD.default_value = 0
slot2.EXCHANGEDIAMONDREQUESTEXCHANGEDIAMONDFIELD.type = 5
slot2.EXCHANGEDIAMONDREQUESTEXCHANGEDIAMONDFIELD.cpp_type = 1
slot2.EXCHANGEDIAMONDREQUESTOPTYPEFIELD.name = "opType"
slot2.EXCHANGEDIAMONDREQUESTOPTYPEFIELD.full_name = ".ExchangeDiamondRequest.opType"
slot2.EXCHANGEDIAMONDREQUESTOPTYPEFIELD.number = 2
slot2.EXCHANGEDIAMONDREQUESTOPTYPEFIELD.index = 1
slot2.EXCHANGEDIAMONDREQUESTOPTYPEFIELD.label = 1
slot2.EXCHANGEDIAMONDREQUESTOPTYPEFIELD.has_default_value = false
slot2.EXCHANGEDIAMONDREQUESTOPTYPEFIELD.default_value = 0
slot2.EXCHANGEDIAMONDREQUESTOPTYPEFIELD.type = 5
slot2.EXCHANGEDIAMONDREQUESTOPTYPEFIELD.cpp_type = 1
slot2.EXCHANGEDIAMONDREQUEST_MSG.name = "ExchangeDiamondRequest"
slot2.EXCHANGEDIAMONDREQUEST_MSG.full_name = ".ExchangeDiamondRequest"
slot2.EXCHANGEDIAMONDREQUEST_MSG.nested_types = {}
slot2.EXCHANGEDIAMONDREQUEST_MSG.enum_types = {}
slot2.EXCHANGEDIAMONDREQUEST_MSG.fields = {
	slot2.EXCHANGEDIAMONDREQUESTEXCHANGEDIAMONDFIELD,
	slot2.EXCHANGEDIAMONDREQUESTOPTYPEFIELD
}
slot2.EXCHANGEDIAMONDREQUEST_MSG.is_extendable = false
slot2.EXCHANGEDIAMONDREQUEST_MSG.extensions = {}
slot2.GETCURRENCYLISTREQUESTCURRENCYIDSFIELD.name = "currencyIds"
slot2.GETCURRENCYLISTREQUESTCURRENCYIDSFIELD.full_name = ".GetCurrencyListRequest.currencyIds"
slot2.GETCURRENCYLISTREQUESTCURRENCYIDSFIELD.number = 1
slot2.GETCURRENCYLISTREQUESTCURRENCYIDSFIELD.index = 0
slot2.GETCURRENCYLISTREQUESTCURRENCYIDSFIELD.label = 3
slot2.GETCURRENCYLISTREQUESTCURRENCYIDSFIELD.has_default_value = false
slot2.GETCURRENCYLISTREQUESTCURRENCYIDSFIELD.default_value = {}
slot2.GETCURRENCYLISTREQUESTCURRENCYIDSFIELD.type = 5
slot2.GETCURRENCYLISTREQUESTCURRENCYIDSFIELD.cpp_type = 1
slot2.GETCURRENCYLISTREQUEST_MSG.name = "GetCurrencyListRequest"
slot2.GETCURRENCYLISTREQUEST_MSG.full_name = ".GetCurrencyListRequest"
slot2.GETCURRENCYLISTREQUEST_MSG.nested_types = {}
slot2.GETCURRENCYLISTREQUEST_MSG.enum_types = {}
slot2.GETCURRENCYLISTREQUEST_MSG.fields = {
	slot2.GETCURRENCYLISTREQUESTCURRENCYIDSFIELD
}
slot2.GETCURRENCYLISTREQUEST_MSG.is_extendable = false
slot2.GETCURRENCYLISTREQUEST_MSG.extensions = {}
slot2.GETCURRENCYLISTREPLYCURRENCYLISTFIELD.name = "currencyList"
slot2.GETCURRENCYLISTREPLYCURRENCYLISTFIELD.full_name = ".GetCurrencyListReply.currencyList"
slot2.GETCURRENCYLISTREPLYCURRENCYLISTFIELD.number = 1
slot2.GETCURRENCYLISTREPLYCURRENCYLISTFIELD.index = 0
slot2.GETCURRENCYLISTREPLYCURRENCYLISTFIELD.label = 3
slot2.GETCURRENCYLISTREPLYCURRENCYLISTFIELD.has_default_value = false
slot2.GETCURRENCYLISTREPLYCURRENCYLISTFIELD.default_value = {}
slot2.GETCURRENCYLISTREPLYCURRENCYLISTFIELD.message_type = slot2.CURRENCY_MSG
slot2.GETCURRENCYLISTREPLYCURRENCYLISTFIELD.type = 11
slot2.GETCURRENCYLISTREPLYCURRENCYLISTFIELD.cpp_type = 10
slot2.GETCURRENCYLISTREPLY_MSG.name = "GetCurrencyListReply"
slot2.GETCURRENCYLISTREPLY_MSG.full_name = ".GetCurrencyListReply"
slot2.GETCURRENCYLISTREPLY_MSG.nested_types = {}
slot2.GETCURRENCYLISTREPLY_MSG.enum_types = {}
slot2.GETCURRENCYLISTREPLY_MSG.fields = {
	slot2.GETCURRENCYLISTREPLYCURRENCYLISTFIELD
}
slot2.GETCURRENCYLISTREPLY_MSG.is_extendable = false
slot2.GETCURRENCYLISTREPLY_MSG.extensions = {}
slot2.BuyPowerReply = slot1.Message(slot2.BUYPOWERREPLY_MSG)
slot2.BuyPowerRequest = slot1.Message(slot2.BUYPOWERREQUEST_MSG)
slot2.Currency = slot1.Message(slot2.CURRENCY_MSG)
slot2.CurrencyChangePush = slot1.Message(slot2.CURRENCYCHANGEPUSH_MSG)
slot2.ExchangeDiamondReply = slot1.Message(slot2.EXCHANGEDIAMONDREPLY_MSG)
slot2.ExchangeDiamondRequest = slot1.Message(slot2.EXCHANGEDIAMONDREQUEST_MSG)
slot2.GetBuyPowerInfoReply = slot1.Message(slot2.GETBUYPOWERINFOREPLY_MSG)
slot2.GetBuyPowerInfoRequest = slot1.Message(slot2.GETBUYPOWERINFOREQUEST_MSG)
slot2.GetCurrencyListReply = slot1.Message(slot2.GETCURRENCYLISTREPLY_MSG)
slot2.GetCurrencyListRequest = slot1.Message(slot2.GETCURRENCYLISTREQUEST_MSG)

return slot2
