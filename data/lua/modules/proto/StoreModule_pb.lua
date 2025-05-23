﻿local var_0_0 = require("protobuf.protobuf")

module("modules.proto.StoreModule_pb", package.seeall)

local var_0_1 = {
	GETSTOREINFOSREPLY_MSG = var_0_0.Descriptor(),
	GETSTOREINFOSREPLYSTOREINFOSFIELD = var_0_0.FieldDescriptor(),
	GETSTOREINFOSREQUEST_MSG = var_0_0.Descriptor(),
	GETSTOREINFOSREQUESTSTOREIDSFIELD = var_0_0.FieldDescriptor(),
	BUYGOODSREQUEST_MSG = var_0_0.Descriptor(),
	BUYGOODSREQUESTSTOREIDFIELD = var_0_0.FieldDescriptor(),
	BUYGOODSREQUESTGOODSIDFIELD = var_0_0.FieldDescriptor(),
	BUYGOODSREQUESTNUMFIELD = var_0_0.FieldDescriptor(),
	BUYGOODSREQUESTSELECTCOSTFIELD = var_0_0.FieldDescriptor(),
	BUYGOODSREPLY_MSG = var_0_0.Descriptor(),
	BUYGOODSREPLYSTOREIDFIELD = var_0_0.FieldDescriptor(),
	BUYGOODSREPLYGOODSIDFIELD = var_0_0.FieldDescriptor(),
	BUYGOODSREPLYNUMFIELD = var_0_0.FieldDescriptor(),
	BUYGOODSREPLYSELECTCOSTFIELD = var_0_0.FieldDescriptor(),
	GOODSINFO_MSG = var_0_0.Descriptor(),
	GOODSINFOGOODSIDFIELD = var_0_0.FieldDescriptor(),
	GOODSINFOBUYCOUNTFIELD = var_0_0.FieldDescriptor(),
	GOODSINFOOFFLINETIMEFIELD = var_0_0.FieldDescriptor(),
	STOREINFO_MSG = var_0_0.Descriptor(),
	STOREINFOIDFIELD = var_0_0.FieldDescriptor(),
	STOREINFONEXTREFRESHTIMEFIELD = var_0_0.FieldDescriptor(),
	STOREINFOGOODSINFOSFIELD = var_0_0.FieldDescriptor(),
	STOREINFOOFFLINETIMEFIELD = var_0_0.FieldDescriptor(),
	READSTORENEWREPLY_MSG = var_0_0.Descriptor(),
	READSTORENEWREPLYGOODSIDSFIELD = var_0_0.FieldDescriptor(),
	READSTORENEWREQUEST_MSG = var_0_0.Descriptor(),
	READSTORENEWREQUESTGOODSIDSFIELD = var_0_0.FieldDescriptor()
}

var_0_1.GETSTOREINFOSREPLYSTOREINFOSFIELD.name = "storeInfos"
var_0_1.GETSTOREINFOSREPLYSTOREINFOSFIELD.full_name = ".GetStoreInfosReply.storeInfos"
var_0_1.GETSTOREINFOSREPLYSTOREINFOSFIELD.number = 1
var_0_1.GETSTOREINFOSREPLYSTOREINFOSFIELD.index = 0
var_0_1.GETSTOREINFOSREPLYSTOREINFOSFIELD.label = 3
var_0_1.GETSTOREINFOSREPLYSTOREINFOSFIELD.has_default_value = false
var_0_1.GETSTOREINFOSREPLYSTOREINFOSFIELD.default_value = {}
var_0_1.GETSTOREINFOSREPLYSTOREINFOSFIELD.message_type = var_0_1.STOREINFO_MSG
var_0_1.GETSTOREINFOSREPLYSTOREINFOSFIELD.type = 11
var_0_1.GETSTOREINFOSREPLYSTOREINFOSFIELD.cpp_type = 10
var_0_1.GETSTOREINFOSREPLY_MSG.name = "GetStoreInfosReply"
var_0_1.GETSTOREINFOSREPLY_MSG.full_name = ".GetStoreInfosReply"
var_0_1.GETSTOREINFOSREPLY_MSG.nested_types = {}
var_0_1.GETSTOREINFOSREPLY_MSG.enum_types = {}
var_0_1.GETSTOREINFOSREPLY_MSG.fields = {
	var_0_1.GETSTOREINFOSREPLYSTOREINFOSFIELD
}
var_0_1.GETSTOREINFOSREPLY_MSG.is_extendable = false
var_0_1.GETSTOREINFOSREPLY_MSG.extensions = {}
var_0_1.GETSTOREINFOSREQUESTSTOREIDSFIELD.name = "storeIds"
var_0_1.GETSTOREINFOSREQUESTSTOREIDSFIELD.full_name = ".GetStoreInfosRequest.storeIds"
var_0_1.GETSTOREINFOSREQUESTSTOREIDSFIELD.number = 1
var_0_1.GETSTOREINFOSREQUESTSTOREIDSFIELD.index = 0
var_0_1.GETSTOREINFOSREQUESTSTOREIDSFIELD.label = 3
var_0_1.GETSTOREINFOSREQUESTSTOREIDSFIELD.has_default_value = false
var_0_1.GETSTOREINFOSREQUESTSTOREIDSFIELD.default_value = {}
var_0_1.GETSTOREINFOSREQUESTSTOREIDSFIELD.type = 5
var_0_1.GETSTOREINFOSREQUESTSTOREIDSFIELD.cpp_type = 1
var_0_1.GETSTOREINFOSREQUEST_MSG.name = "GetStoreInfosRequest"
var_0_1.GETSTOREINFOSREQUEST_MSG.full_name = ".GetStoreInfosRequest"
var_0_1.GETSTOREINFOSREQUEST_MSG.nested_types = {}
var_0_1.GETSTOREINFOSREQUEST_MSG.enum_types = {}
var_0_1.GETSTOREINFOSREQUEST_MSG.fields = {
	var_0_1.GETSTOREINFOSREQUESTSTOREIDSFIELD
}
var_0_1.GETSTOREINFOSREQUEST_MSG.is_extendable = false
var_0_1.GETSTOREINFOSREQUEST_MSG.extensions = {}
var_0_1.BUYGOODSREQUESTSTOREIDFIELD.name = "storeId"
var_0_1.BUYGOODSREQUESTSTOREIDFIELD.full_name = ".BuyGoodsRequest.storeId"
var_0_1.BUYGOODSREQUESTSTOREIDFIELD.number = 1
var_0_1.BUYGOODSREQUESTSTOREIDFIELD.index = 0
var_0_1.BUYGOODSREQUESTSTOREIDFIELD.label = 2
var_0_1.BUYGOODSREQUESTSTOREIDFIELD.has_default_value = false
var_0_1.BUYGOODSREQUESTSTOREIDFIELD.default_value = 0
var_0_1.BUYGOODSREQUESTSTOREIDFIELD.type = 5
var_0_1.BUYGOODSREQUESTSTOREIDFIELD.cpp_type = 1
var_0_1.BUYGOODSREQUESTGOODSIDFIELD.name = "goodsId"
var_0_1.BUYGOODSREQUESTGOODSIDFIELD.full_name = ".BuyGoodsRequest.goodsId"
var_0_1.BUYGOODSREQUESTGOODSIDFIELD.number = 2
var_0_1.BUYGOODSREQUESTGOODSIDFIELD.index = 1
var_0_1.BUYGOODSREQUESTGOODSIDFIELD.label = 2
var_0_1.BUYGOODSREQUESTGOODSIDFIELD.has_default_value = false
var_0_1.BUYGOODSREQUESTGOODSIDFIELD.default_value = 0
var_0_1.BUYGOODSREQUESTGOODSIDFIELD.type = 5
var_0_1.BUYGOODSREQUESTGOODSIDFIELD.cpp_type = 1
var_0_1.BUYGOODSREQUESTNUMFIELD.name = "num"
var_0_1.BUYGOODSREQUESTNUMFIELD.full_name = ".BuyGoodsRequest.num"
var_0_1.BUYGOODSREQUESTNUMFIELD.number = 3
var_0_1.BUYGOODSREQUESTNUMFIELD.index = 2
var_0_1.BUYGOODSREQUESTNUMFIELD.label = 2
var_0_1.BUYGOODSREQUESTNUMFIELD.has_default_value = false
var_0_1.BUYGOODSREQUESTNUMFIELD.default_value = 0
var_0_1.BUYGOODSREQUESTNUMFIELD.type = 5
var_0_1.BUYGOODSREQUESTNUMFIELD.cpp_type = 1
var_0_1.BUYGOODSREQUESTSELECTCOSTFIELD.name = "selectCost"
var_0_1.BUYGOODSREQUESTSELECTCOSTFIELD.full_name = ".BuyGoodsRequest.selectCost"
var_0_1.BUYGOODSREQUESTSELECTCOSTFIELD.number = 4
var_0_1.BUYGOODSREQUESTSELECTCOSTFIELD.index = 3
var_0_1.BUYGOODSREQUESTSELECTCOSTFIELD.label = 1
var_0_1.BUYGOODSREQUESTSELECTCOSTFIELD.has_default_value = false
var_0_1.BUYGOODSREQUESTSELECTCOSTFIELD.default_value = 0
var_0_1.BUYGOODSREQUESTSELECTCOSTFIELD.type = 5
var_0_1.BUYGOODSREQUESTSELECTCOSTFIELD.cpp_type = 1
var_0_1.BUYGOODSREQUEST_MSG.name = "BuyGoodsRequest"
var_0_1.BUYGOODSREQUEST_MSG.full_name = ".BuyGoodsRequest"
var_0_1.BUYGOODSREQUEST_MSG.nested_types = {}
var_0_1.BUYGOODSREQUEST_MSG.enum_types = {}
var_0_1.BUYGOODSREQUEST_MSG.fields = {
	var_0_1.BUYGOODSREQUESTSTOREIDFIELD,
	var_0_1.BUYGOODSREQUESTGOODSIDFIELD,
	var_0_1.BUYGOODSREQUESTNUMFIELD,
	var_0_1.BUYGOODSREQUESTSELECTCOSTFIELD
}
var_0_1.BUYGOODSREQUEST_MSG.is_extendable = false
var_0_1.BUYGOODSREQUEST_MSG.extensions = {}
var_0_1.BUYGOODSREPLYSTOREIDFIELD.name = "storeId"
var_0_1.BUYGOODSREPLYSTOREIDFIELD.full_name = ".BuyGoodsReply.storeId"
var_0_1.BUYGOODSREPLYSTOREIDFIELD.number = 1
var_0_1.BUYGOODSREPLYSTOREIDFIELD.index = 0
var_0_1.BUYGOODSREPLYSTOREIDFIELD.label = 2
var_0_1.BUYGOODSREPLYSTOREIDFIELD.has_default_value = false
var_0_1.BUYGOODSREPLYSTOREIDFIELD.default_value = 0
var_0_1.BUYGOODSREPLYSTOREIDFIELD.type = 5
var_0_1.BUYGOODSREPLYSTOREIDFIELD.cpp_type = 1
var_0_1.BUYGOODSREPLYGOODSIDFIELD.name = "goodsId"
var_0_1.BUYGOODSREPLYGOODSIDFIELD.full_name = ".BuyGoodsReply.goodsId"
var_0_1.BUYGOODSREPLYGOODSIDFIELD.number = 2
var_0_1.BUYGOODSREPLYGOODSIDFIELD.index = 1
var_0_1.BUYGOODSREPLYGOODSIDFIELD.label = 2
var_0_1.BUYGOODSREPLYGOODSIDFIELD.has_default_value = false
var_0_1.BUYGOODSREPLYGOODSIDFIELD.default_value = 0
var_0_1.BUYGOODSREPLYGOODSIDFIELD.type = 5
var_0_1.BUYGOODSREPLYGOODSIDFIELD.cpp_type = 1
var_0_1.BUYGOODSREPLYNUMFIELD.name = "num"
var_0_1.BUYGOODSREPLYNUMFIELD.full_name = ".BuyGoodsReply.num"
var_0_1.BUYGOODSREPLYNUMFIELD.number = 3
var_0_1.BUYGOODSREPLYNUMFIELD.index = 2
var_0_1.BUYGOODSREPLYNUMFIELD.label = 2
var_0_1.BUYGOODSREPLYNUMFIELD.has_default_value = false
var_0_1.BUYGOODSREPLYNUMFIELD.default_value = 0
var_0_1.BUYGOODSREPLYNUMFIELD.type = 5
var_0_1.BUYGOODSREPLYNUMFIELD.cpp_type = 1
var_0_1.BUYGOODSREPLYSELECTCOSTFIELD.name = "selectCost"
var_0_1.BUYGOODSREPLYSELECTCOSTFIELD.full_name = ".BuyGoodsReply.selectCost"
var_0_1.BUYGOODSREPLYSELECTCOSTFIELD.number = 4
var_0_1.BUYGOODSREPLYSELECTCOSTFIELD.index = 3
var_0_1.BUYGOODSREPLYSELECTCOSTFIELD.label = 1
var_0_1.BUYGOODSREPLYSELECTCOSTFIELD.has_default_value = false
var_0_1.BUYGOODSREPLYSELECTCOSTFIELD.default_value = 0
var_0_1.BUYGOODSREPLYSELECTCOSTFIELD.type = 5
var_0_1.BUYGOODSREPLYSELECTCOSTFIELD.cpp_type = 1
var_0_1.BUYGOODSREPLY_MSG.name = "BuyGoodsReply"
var_0_1.BUYGOODSREPLY_MSG.full_name = ".BuyGoodsReply"
var_0_1.BUYGOODSREPLY_MSG.nested_types = {}
var_0_1.BUYGOODSREPLY_MSG.enum_types = {}
var_0_1.BUYGOODSREPLY_MSG.fields = {
	var_0_1.BUYGOODSREPLYSTOREIDFIELD,
	var_0_1.BUYGOODSREPLYGOODSIDFIELD,
	var_0_1.BUYGOODSREPLYNUMFIELD,
	var_0_1.BUYGOODSREPLYSELECTCOSTFIELD
}
var_0_1.BUYGOODSREPLY_MSG.is_extendable = false
var_0_1.BUYGOODSREPLY_MSG.extensions = {}
var_0_1.GOODSINFOGOODSIDFIELD.name = "goodsId"
var_0_1.GOODSINFOGOODSIDFIELD.full_name = ".GoodsInfo.goodsId"
var_0_1.GOODSINFOGOODSIDFIELD.number = 1
var_0_1.GOODSINFOGOODSIDFIELD.index = 0
var_0_1.GOODSINFOGOODSIDFIELD.label = 2
var_0_1.GOODSINFOGOODSIDFIELD.has_default_value = false
var_0_1.GOODSINFOGOODSIDFIELD.default_value = 0
var_0_1.GOODSINFOGOODSIDFIELD.type = 5
var_0_1.GOODSINFOGOODSIDFIELD.cpp_type = 1
var_0_1.GOODSINFOBUYCOUNTFIELD.name = "buyCount"
var_0_1.GOODSINFOBUYCOUNTFIELD.full_name = ".GoodsInfo.buyCount"
var_0_1.GOODSINFOBUYCOUNTFIELD.number = 2
var_0_1.GOODSINFOBUYCOUNTFIELD.index = 1
var_0_1.GOODSINFOBUYCOUNTFIELD.label = 2
var_0_1.GOODSINFOBUYCOUNTFIELD.has_default_value = false
var_0_1.GOODSINFOBUYCOUNTFIELD.default_value = 0
var_0_1.GOODSINFOBUYCOUNTFIELD.type = 5
var_0_1.GOODSINFOBUYCOUNTFIELD.cpp_type = 1
var_0_1.GOODSINFOOFFLINETIMEFIELD.name = "offlineTime"
var_0_1.GOODSINFOOFFLINETIMEFIELD.full_name = ".GoodsInfo.offlineTime"
var_0_1.GOODSINFOOFFLINETIMEFIELD.number = 3
var_0_1.GOODSINFOOFFLINETIMEFIELD.index = 2
var_0_1.GOODSINFOOFFLINETIMEFIELD.label = 1
var_0_1.GOODSINFOOFFLINETIMEFIELD.has_default_value = false
var_0_1.GOODSINFOOFFLINETIMEFIELD.default_value = 0
var_0_1.GOODSINFOOFFLINETIMEFIELD.type = 3
var_0_1.GOODSINFOOFFLINETIMEFIELD.cpp_type = 2
var_0_1.GOODSINFO_MSG.name = "GoodsInfo"
var_0_1.GOODSINFO_MSG.full_name = ".GoodsInfo"
var_0_1.GOODSINFO_MSG.nested_types = {}
var_0_1.GOODSINFO_MSG.enum_types = {}
var_0_1.GOODSINFO_MSG.fields = {
	var_0_1.GOODSINFOGOODSIDFIELD,
	var_0_1.GOODSINFOBUYCOUNTFIELD,
	var_0_1.GOODSINFOOFFLINETIMEFIELD
}
var_0_1.GOODSINFO_MSG.is_extendable = false
var_0_1.GOODSINFO_MSG.extensions = {}
var_0_1.STOREINFOIDFIELD.name = "id"
var_0_1.STOREINFOIDFIELD.full_name = ".StoreInfo.id"
var_0_1.STOREINFOIDFIELD.number = 1
var_0_1.STOREINFOIDFIELD.index = 0
var_0_1.STOREINFOIDFIELD.label = 2
var_0_1.STOREINFOIDFIELD.has_default_value = false
var_0_1.STOREINFOIDFIELD.default_value = 0
var_0_1.STOREINFOIDFIELD.type = 5
var_0_1.STOREINFOIDFIELD.cpp_type = 1
var_0_1.STOREINFONEXTREFRESHTIMEFIELD.name = "nextRefreshTime"
var_0_1.STOREINFONEXTREFRESHTIMEFIELD.full_name = ".StoreInfo.nextRefreshTime"
var_0_1.STOREINFONEXTREFRESHTIMEFIELD.number = 2
var_0_1.STOREINFONEXTREFRESHTIMEFIELD.index = 1
var_0_1.STOREINFONEXTREFRESHTIMEFIELD.label = 2
var_0_1.STOREINFONEXTREFRESHTIMEFIELD.has_default_value = false
var_0_1.STOREINFONEXTREFRESHTIMEFIELD.default_value = 0
var_0_1.STOREINFONEXTREFRESHTIMEFIELD.type = 3
var_0_1.STOREINFONEXTREFRESHTIMEFIELD.cpp_type = 2
var_0_1.STOREINFOGOODSINFOSFIELD.name = "goodsInfos"
var_0_1.STOREINFOGOODSINFOSFIELD.full_name = ".StoreInfo.goodsInfos"
var_0_1.STOREINFOGOODSINFOSFIELD.number = 3
var_0_1.STOREINFOGOODSINFOSFIELD.index = 2
var_0_1.STOREINFOGOODSINFOSFIELD.label = 3
var_0_1.STOREINFOGOODSINFOSFIELD.has_default_value = false
var_0_1.STOREINFOGOODSINFOSFIELD.default_value = {}
var_0_1.STOREINFOGOODSINFOSFIELD.message_type = var_0_1.GOODSINFO_MSG
var_0_1.STOREINFOGOODSINFOSFIELD.type = 11
var_0_1.STOREINFOGOODSINFOSFIELD.cpp_type = 10
var_0_1.STOREINFOOFFLINETIMEFIELD.name = "offlineTime"
var_0_1.STOREINFOOFFLINETIMEFIELD.full_name = ".StoreInfo.offlineTime"
var_0_1.STOREINFOOFFLINETIMEFIELD.number = 4
var_0_1.STOREINFOOFFLINETIMEFIELD.index = 3
var_0_1.STOREINFOOFFLINETIMEFIELD.label = 1
var_0_1.STOREINFOOFFLINETIMEFIELD.has_default_value = false
var_0_1.STOREINFOOFFLINETIMEFIELD.default_value = 0
var_0_1.STOREINFOOFFLINETIMEFIELD.type = 3
var_0_1.STOREINFOOFFLINETIMEFIELD.cpp_type = 2
var_0_1.STOREINFO_MSG.name = "StoreInfo"
var_0_1.STOREINFO_MSG.full_name = ".StoreInfo"
var_0_1.STOREINFO_MSG.nested_types = {}
var_0_1.STOREINFO_MSG.enum_types = {}
var_0_1.STOREINFO_MSG.fields = {
	var_0_1.STOREINFOIDFIELD,
	var_0_1.STOREINFONEXTREFRESHTIMEFIELD,
	var_0_1.STOREINFOGOODSINFOSFIELD,
	var_0_1.STOREINFOOFFLINETIMEFIELD
}
var_0_1.STOREINFO_MSG.is_extendable = false
var_0_1.STOREINFO_MSG.extensions = {}
var_0_1.READSTORENEWREPLYGOODSIDSFIELD.name = "goodsIds"
var_0_1.READSTORENEWREPLYGOODSIDSFIELD.full_name = ".ReadStoreNewReply.goodsIds"
var_0_1.READSTORENEWREPLYGOODSIDSFIELD.number = 1
var_0_1.READSTORENEWREPLYGOODSIDSFIELD.index = 0
var_0_1.READSTORENEWREPLYGOODSIDSFIELD.label = 3
var_0_1.READSTORENEWREPLYGOODSIDSFIELD.has_default_value = false
var_0_1.READSTORENEWREPLYGOODSIDSFIELD.default_value = {}
var_0_1.READSTORENEWREPLYGOODSIDSFIELD.type = 5
var_0_1.READSTORENEWREPLYGOODSIDSFIELD.cpp_type = 1
var_0_1.READSTORENEWREPLY_MSG.name = "ReadStoreNewReply"
var_0_1.READSTORENEWREPLY_MSG.full_name = ".ReadStoreNewReply"
var_0_1.READSTORENEWREPLY_MSG.nested_types = {}
var_0_1.READSTORENEWREPLY_MSG.enum_types = {}
var_0_1.READSTORENEWREPLY_MSG.fields = {
	var_0_1.READSTORENEWREPLYGOODSIDSFIELD
}
var_0_1.READSTORENEWREPLY_MSG.is_extendable = false
var_0_1.READSTORENEWREPLY_MSG.extensions = {}
var_0_1.READSTORENEWREQUESTGOODSIDSFIELD.name = "goodsIds"
var_0_1.READSTORENEWREQUESTGOODSIDSFIELD.full_name = ".ReadStoreNewRequest.goodsIds"
var_0_1.READSTORENEWREQUESTGOODSIDSFIELD.number = 1
var_0_1.READSTORENEWREQUESTGOODSIDSFIELD.index = 0
var_0_1.READSTORENEWREQUESTGOODSIDSFIELD.label = 3
var_0_1.READSTORENEWREQUESTGOODSIDSFIELD.has_default_value = false
var_0_1.READSTORENEWREQUESTGOODSIDSFIELD.default_value = {}
var_0_1.READSTORENEWREQUESTGOODSIDSFIELD.type = 5
var_0_1.READSTORENEWREQUESTGOODSIDSFIELD.cpp_type = 1
var_0_1.READSTORENEWREQUEST_MSG.name = "ReadStoreNewRequest"
var_0_1.READSTORENEWREQUEST_MSG.full_name = ".ReadStoreNewRequest"
var_0_1.READSTORENEWREQUEST_MSG.nested_types = {}
var_0_1.READSTORENEWREQUEST_MSG.enum_types = {}
var_0_1.READSTORENEWREQUEST_MSG.fields = {
	var_0_1.READSTORENEWREQUESTGOODSIDSFIELD
}
var_0_1.READSTORENEWREQUEST_MSG.is_extendable = false
var_0_1.READSTORENEWREQUEST_MSG.extensions = {}
var_0_1.BuyGoodsReply = var_0_0.Message(var_0_1.BUYGOODSREPLY_MSG)
var_0_1.BuyGoodsRequest = var_0_0.Message(var_0_1.BUYGOODSREQUEST_MSG)
var_0_1.GetStoreInfosReply = var_0_0.Message(var_0_1.GETSTOREINFOSREPLY_MSG)
var_0_1.GetStoreInfosRequest = var_0_0.Message(var_0_1.GETSTOREINFOSREQUEST_MSG)
var_0_1.GoodsInfo = var_0_0.Message(var_0_1.GOODSINFO_MSG)
var_0_1.ReadStoreNewReply = var_0_0.Message(var_0_1.READSTORENEWREPLY_MSG)
var_0_1.ReadStoreNewRequest = var_0_0.Message(var_0_1.READSTORENEWREQUEST_MSG)
var_0_1.StoreInfo = var_0_0.Message(var_0_1.STOREINFO_MSG)

return var_0_1
