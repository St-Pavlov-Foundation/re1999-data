﻿local var_0_0 = require
local var_0_1 = var_0_0("protobuf.protobuf")

module("modules.proto.Activity187Module_pb", package.seeall)

local var_0_2 = {
	MATERIALMODULE_PB = var_0_0("modules.proto.MaterialModule_pb"),
	ACT187ACCEPTREWARDREQUEST_MSG = var_0_1.Descriptor(),
	ACT187ACCEPTREWARDREQUESTACTIVITYIDFIELD = var_0_1.FieldDescriptor(),
	ACT187ACCEPTREWARDREPLY_MSG = var_0_1.Descriptor(),
	ACT187ACCEPTREWARDREPLYACTIVITYIDFIELD = var_0_1.FieldDescriptor(),
	ACT187ACCEPTREWARDREPLYFIXBONUSLISTFIELD = var_0_1.FieldDescriptor(),
	ACT187ACCEPTREWARDREPLYACCEPTREWARDGAMECOUNTFIELD = var_0_1.FieldDescriptor(),
	GET187INFOREPLY_MSG = var_0_1.Descriptor(),
	GET187INFOREPLYACTIVITYIDFIELD = var_0_1.FieldDescriptor(),
	GET187INFOREPLYLOGINCOUNTFIELD = var_0_1.FieldDescriptor(),
	GET187INFOREPLYHAVEGAMECOUNTFIELD = var_0_1.FieldDescriptor(),
	GET187INFOREPLYFINISHGAMECOUNTFIELD = var_0_1.FieldDescriptor(),
	GET187INFOREPLYACCEPTREWARDGAMECOUNTFIELD = var_0_1.FieldDescriptor(),
	GET187INFOREPLYRANDOMBONUSINFOSFIELD = var_0_1.FieldDescriptor(),
	GET187INFOREQUEST_MSG = var_0_1.Descriptor(),
	GET187INFOREQUESTACTIVITYIDFIELD = var_0_1.FieldDescriptor(),
	ACT187FINISHGAMEREPLY_MSG = var_0_1.Descriptor(),
	ACT187FINISHGAMEREPLYACTIVITYIDFIELD = var_0_1.FieldDescriptor(),
	ACT187FINISHGAMEREPLYHAVEGAMECOUNTFIELD = var_0_1.FieldDescriptor(),
	ACT187FINISHGAMEREPLYFINISHGAMECOUNTFIELD = var_0_1.FieldDescriptor(),
	ACT187FINISHGAMEREPLYRANDOMBONUSLISTFIELD = var_0_1.FieldDescriptor(),
	ACT187FINISHGAMEREQUEST_MSG = var_0_1.Descriptor(),
	ACT187FINISHGAMEREQUESTACTIVITYIDFIELD = var_0_1.FieldDescriptor(),
	RANDOMBONUSINFO_MSG = var_0_1.Descriptor(),
	RANDOMBONUSINFORANDOMBONUSLISTFIELD = var_0_1.FieldDescriptor()
}

var_0_2.ACT187ACCEPTREWARDREQUESTACTIVITYIDFIELD.name = "activityId"
var_0_2.ACT187ACCEPTREWARDREQUESTACTIVITYIDFIELD.full_name = ".Act187AcceptRewardRequest.activityId"
var_0_2.ACT187ACCEPTREWARDREQUESTACTIVITYIDFIELD.number = 1
var_0_2.ACT187ACCEPTREWARDREQUESTACTIVITYIDFIELD.index = 0
var_0_2.ACT187ACCEPTREWARDREQUESTACTIVITYIDFIELD.label = 1
var_0_2.ACT187ACCEPTREWARDREQUESTACTIVITYIDFIELD.has_default_value = false
var_0_2.ACT187ACCEPTREWARDREQUESTACTIVITYIDFIELD.default_value = 0
var_0_2.ACT187ACCEPTREWARDREQUESTACTIVITYIDFIELD.type = 5
var_0_2.ACT187ACCEPTREWARDREQUESTACTIVITYIDFIELD.cpp_type = 1
var_0_2.ACT187ACCEPTREWARDREQUEST_MSG.name = "Act187AcceptRewardRequest"
var_0_2.ACT187ACCEPTREWARDREQUEST_MSG.full_name = ".Act187AcceptRewardRequest"
var_0_2.ACT187ACCEPTREWARDREQUEST_MSG.nested_types = {}
var_0_2.ACT187ACCEPTREWARDREQUEST_MSG.enum_types = {}
var_0_2.ACT187ACCEPTREWARDREQUEST_MSG.fields = {
	var_0_2.ACT187ACCEPTREWARDREQUESTACTIVITYIDFIELD
}
var_0_2.ACT187ACCEPTREWARDREQUEST_MSG.is_extendable = false
var_0_2.ACT187ACCEPTREWARDREQUEST_MSG.extensions = {}
var_0_2.ACT187ACCEPTREWARDREPLYACTIVITYIDFIELD.name = "activityId"
var_0_2.ACT187ACCEPTREWARDREPLYACTIVITYIDFIELD.full_name = ".Act187AcceptRewardReply.activityId"
var_0_2.ACT187ACCEPTREWARDREPLYACTIVITYIDFIELD.number = 1
var_0_2.ACT187ACCEPTREWARDREPLYACTIVITYIDFIELD.index = 0
var_0_2.ACT187ACCEPTREWARDREPLYACTIVITYIDFIELD.label = 1
var_0_2.ACT187ACCEPTREWARDREPLYACTIVITYIDFIELD.has_default_value = false
var_0_2.ACT187ACCEPTREWARDREPLYACTIVITYIDFIELD.default_value = 0
var_0_2.ACT187ACCEPTREWARDREPLYACTIVITYIDFIELD.type = 5
var_0_2.ACT187ACCEPTREWARDREPLYACTIVITYIDFIELD.cpp_type = 1
var_0_2.ACT187ACCEPTREWARDREPLYFIXBONUSLISTFIELD.name = "fixBonusList"
var_0_2.ACT187ACCEPTREWARDREPLYFIXBONUSLISTFIELD.full_name = ".Act187AcceptRewardReply.fixBonusList"
var_0_2.ACT187ACCEPTREWARDREPLYFIXBONUSLISTFIELD.number = 2
var_0_2.ACT187ACCEPTREWARDREPLYFIXBONUSLISTFIELD.index = 1
var_0_2.ACT187ACCEPTREWARDREPLYFIXBONUSLISTFIELD.label = 3
var_0_2.ACT187ACCEPTREWARDREPLYFIXBONUSLISTFIELD.has_default_value = false
var_0_2.ACT187ACCEPTREWARDREPLYFIXBONUSLISTFIELD.default_value = {}
var_0_2.ACT187ACCEPTREWARDREPLYFIXBONUSLISTFIELD.message_type = var_0_2.MATERIALMODULE_PB.MATERIALDATA_MSG
var_0_2.ACT187ACCEPTREWARDREPLYFIXBONUSLISTFIELD.type = 11
var_0_2.ACT187ACCEPTREWARDREPLYFIXBONUSLISTFIELD.cpp_type = 10
var_0_2.ACT187ACCEPTREWARDREPLYACCEPTREWARDGAMECOUNTFIELD.name = "acceptRewardGameCount"
var_0_2.ACT187ACCEPTREWARDREPLYACCEPTREWARDGAMECOUNTFIELD.full_name = ".Act187AcceptRewardReply.acceptRewardGameCount"
var_0_2.ACT187ACCEPTREWARDREPLYACCEPTREWARDGAMECOUNTFIELD.number = 3
var_0_2.ACT187ACCEPTREWARDREPLYACCEPTREWARDGAMECOUNTFIELD.index = 2
var_0_2.ACT187ACCEPTREWARDREPLYACCEPTREWARDGAMECOUNTFIELD.label = 1
var_0_2.ACT187ACCEPTREWARDREPLYACCEPTREWARDGAMECOUNTFIELD.has_default_value = false
var_0_2.ACT187ACCEPTREWARDREPLYACCEPTREWARDGAMECOUNTFIELD.default_value = 0
var_0_2.ACT187ACCEPTREWARDREPLYACCEPTREWARDGAMECOUNTFIELD.type = 13
var_0_2.ACT187ACCEPTREWARDREPLYACCEPTREWARDGAMECOUNTFIELD.cpp_type = 3
var_0_2.ACT187ACCEPTREWARDREPLY_MSG.name = "Act187AcceptRewardReply"
var_0_2.ACT187ACCEPTREWARDREPLY_MSG.full_name = ".Act187AcceptRewardReply"
var_0_2.ACT187ACCEPTREWARDREPLY_MSG.nested_types = {}
var_0_2.ACT187ACCEPTREWARDREPLY_MSG.enum_types = {}
var_0_2.ACT187ACCEPTREWARDREPLY_MSG.fields = {
	var_0_2.ACT187ACCEPTREWARDREPLYACTIVITYIDFIELD,
	var_0_2.ACT187ACCEPTREWARDREPLYFIXBONUSLISTFIELD,
	var_0_2.ACT187ACCEPTREWARDREPLYACCEPTREWARDGAMECOUNTFIELD
}
var_0_2.ACT187ACCEPTREWARDREPLY_MSG.is_extendable = false
var_0_2.ACT187ACCEPTREWARDREPLY_MSG.extensions = {}
var_0_2.GET187INFOREPLYACTIVITYIDFIELD.name = "activityId"
var_0_2.GET187INFOREPLYACTIVITYIDFIELD.full_name = ".Get187InfoReply.activityId"
var_0_2.GET187INFOREPLYACTIVITYIDFIELD.number = 1
var_0_2.GET187INFOREPLYACTIVITYIDFIELD.index = 0
var_0_2.GET187INFOREPLYACTIVITYIDFIELD.label = 1
var_0_2.GET187INFOREPLYACTIVITYIDFIELD.has_default_value = false
var_0_2.GET187INFOREPLYACTIVITYIDFIELD.default_value = 0
var_0_2.GET187INFOREPLYACTIVITYIDFIELD.type = 5
var_0_2.GET187INFOREPLYACTIVITYIDFIELD.cpp_type = 1
var_0_2.GET187INFOREPLYLOGINCOUNTFIELD.name = "loginCount"
var_0_2.GET187INFOREPLYLOGINCOUNTFIELD.full_name = ".Get187InfoReply.loginCount"
var_0_2.GET187INFOREPLYLOGINCOUNTFIELD.number = 2
var_0_2.GET187INFOREPLYLOGINCOUNTFIELD.index = 1
var_0_2.GET187INFOREPLYLOGINCOUNTFIELD.label = 1
var_0_2.GET187INFOREPLYLOGINCOUNTFIELD.has_default_value = false
var_0_2.GET187INFOREPLYLOGINCOUNTFIELD.default_value = 0
var_0_2.GET187INFOREPLYLOGINCOUNTFIELD.type = 13
var_0_2.GET187INFOREPLYLOGINCOUNTFIELD.cpp_type = 3
var_0_2.GET187INFOREPLYHAVEGAMECOUNTFIELD.name = "haveGameCount"
var_0_2.GET187INFOREPLYHAVEGAMECOUNTFIELD.full_name = ".Get187InfoReply.haveGameCount"
var_0_2.GET187INFOREPLYHAVEGAMECOUNTFIELD.number = 3
var_0_2.GET187INFOREPLYHAVEGAMECOUNTFIELD.index = 2
var_0_2.GET187INFOREPLYHAVEGAMECOUNTFIELD.label = 1
var_0_2.GET187INFOREPLYHAVEGAMECOUNTFIELD.has_default_value = false
var_0_2.GET187INFOREPLYHAVEGAMECOUNTFIELD.default_value = 0
var_0_2.GET187INFOREPLYHAVEGAMECOUNTFIELD.type = 13
var_0_2.GET187INFOREPLYHAVEGAMECOUNTFIELD.cpp_type = 3
var_0_2.GET187INFOREPLYFINISHGAMECOUNTFIELD.name = "finishGameCount"
var_0_2.GET187INFOREPLYFINISHGAMECOUNTFIELD.full_name = ".Get187InfoReply.finishGameCount"
var_0_2.GET187INFOREPLYFINISHGAMECOUNTFIELD.number = 4
var_0_2.GET187INFOREPLYFINISHGAMECOUNTFIELD.index = 3
var_0_2.GET187INFOREPLYFINISHGAMECOUNTFIELD.label = 1
var_0_2.GET187INFOREPLYFINISHGAMECOUNTFIELD.has_default_value = false
var_0_2.GET187INFOREPLYFINISHGAMECOUNTFIELD.default_value = 0
var_0_2.GET187INFOREPLYFINISHGAMECOUNTFIELD.type = 13
var_0_2.GET187INFOREPLYFINISHGAMECOUNTFIELD.cpp_type = 3
var_0_2.GET187INFOREPLYACCEPTREWARDGAMECOUNTFIELD.name = "acceptRewardGameCount"
var_0_2.GET187INFOREPLYACCEPTREWARDGAMECOUNTFIELD.full_name = ".Get187InfoReply.acceptRewardGameCount"
var_0_2.GET187INFOREPLYACCEPTREWARDGAMECOUNTFIELD.number = 5
var_0_2.GET187INFOREPLYACCEPTREWARDGAMECOUNTFIELD.index = 4
var_0_2.GET187INFOREPLYACCEPTREWARDGAMECOUNTFIELD.label = 1
var_0_2.GET187INFOREPLYACCEPTREWARDGAMECOUNTFIELD.has_default_value = false
var_0_2.GET187INFOREPLYACCEPTREWARDGAMECOUNTFIELD.default_value = 0
var_0_2.GET187INFOREPLYACCEPTREWARDGAMECOUNTFIELD.type = 13
var_0_2.GET187INFOREPLYACCEPTREWARDGAMECOUNTFIELD.cpp_type = 3
var_0_2.GET187INFOREPLYRANDOMBONUSINFOSFIELD.name = "randomBonusInfos"
var_0_2.GET187INFOREPLYRANDOMBONUSINFOSFIELD.full_name = ".Get187InfoReply.randomBonusInfos"
var_0_2.GET187INFOREPLYRANDOMBONUSINFOSFIELD.number = 6
var_0_2.GET187INFOREPLYRANDOMBONUSINFOSFIELD.index = 5
var_0_2.GET187INFOREPLYRANDOMBONUSINFOSFIELD.label = 3
var_0_2.GET187INFOREPLYRANDOMBONUSINFOSFIELD.has_default_value = false
var_0_2.GET187INFOREPLYRANDOMBONUSINFOSFIELD.default_value = {}
var_0_2.GET187INFOREPLYRANDOMBONUSINFOSFIELD.message_type = var_0_2.RANDOMBONUSINFO_MSG
var_0_2.GET187INFOREPLYRANDOMBONUSINFOSFIELD.type = 11
var_0_2.GET187INFOREPLYRANDOMBONUSINFOSFIELD.cpp_type = 10
var_0_2.GET187INFOREPLY_MSG.name = "Get187InfoReply"
var_0_2.GET187INFOREPLY_MSG.full_name = ".Get187InfoReply"
var_0_2.GET187INFOREPLY_MSG.nested_types = {}
var_0_2.GET187INFOREPLY_MSG.enum_types = {}
var_0_2.GET187INFOREPLY_MSG.fields = {
	var_0_2.GET187INFOREPLYACTIVITYIDFIELD,
	var_0_2.GET187INFOREPLYLOGINCOUNTFIELD,
	var_0_2.GET187INFOREPLYHAVEGAMECOUNTFIELD,
	var_0_2.GET187INFOREPLYFINISHGAMECOUNTFIELD,
	var_0_2.GET187INFOREPLYACCEPTREWARDGAMECOUNTFIELD,
	var_0_2.GET187INFOREPLYRANDOMBONUSINFOSFIELD
}
var_0_2.GET187INFOREPLY_MSG.is_extendable = false
var_0_2.GET187INFOREPLY_MSG.extensions = {}
var_0_2.GET187INFOREQUESTACTIVITYIDFIELD.name = "activityId"
var_0_2.GET187INFOREQUESTACTIVITYIDFIELD.full_name = ".Get187InfoRequest.activityId"
var_0_2.GET187INFOREQUESTACTIVITYIDFIELD.number = 1
var_0_2.GET187INFOREQUESTACTIVITYIDFIELD.index = 0
var_0_2.GET187INFOREQUESTACTIVITYIDFIELD.label = 1
var_0_2.GET187INFOREQUESTACTIVITYIDFIELD.has_default_value = false
var_0_2.GET187INFOREQUESTACTIVITYIDFIELD.default_value = 0
var_0_2.GET187INFOREQUESTACTIVITYIDFIELD.type = 5
var_0_2.GET187INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
var_0_2.GET187INFOREQUEST_MSG.name = "Get187InfoRequest"
var_0_2.GET187INFOREQUEST_MSG.full_name = ".Get187InfoRequest"
var_0_2.GET187INFOREQUEST_MSG.nested_types = {}
var_0_2.GET187INFOREQUEST_MSG.enum_types = {}
var_0_2.GET187INFOREQUEST_MSG.fields = {
	var_0_2.GET187INFOREQUESTACTIVITYIDFIELD
}
var_0_2.GET187INFOREQUEST_MSG.is_extendable = false
var_0_2.GET187INFOREQUEST_MSG.extensions = {}
var_0_2.ACT187FINISHGAMEREPLYACTIVITYIDFIELD.name = "activityId"
var_0_2.ACT187FINISHGAMEREPLYACTIVITYIDFIELD.full_name = ".Act187FinishGameReply.activityId"
var_0_2.ACT187FINISHGAMEREPLYACTIVITYIDFIELD.number = 1
var_0_2.ACT187FINISHGAMEREPLYACTIVITYIDFIELD.index = 0
var_0_2.ACT187FINISHGAMEREPLYACTIVITYIDFIELD.label = 1
var_0_2.ACT187FINISHGAMEREPLYACTIVITYIDFIELD.has_default_value = false
var_0_2.ACT187FINISHGAMEREPLYACTIVITYIDFIELD.default_value = 0
var_0_2.ACT187FINISHGAMEREPLYACTIVITYIDFIELD.type = 5
var_0_2.ACT187FINISHGAMEREPLYACTIVITYIDFIELD.cpp_type = 1
var_0_2.ACT187FINISHGAMEREPLYHAVEGAMECOUNTFIELD.name = "haveGameCount"
var_0_2.ACT187FINISHGAMEREPLYHAVEGAMECOUNTFIELD.full_name = ".Act187FinishGameReply.haveGameCount"
var_0_2.ACT187FINISHGAMEREPLYHAVEGAMECOUNTFIELD.number = 2
var_0_2.ACT187FINISHGAMEREPLYHAVEGAMECOUNTFIELD.index = 1
var_0_2.ACT187FINISHGAMEREPLYHAVEGAMECOUNTFIELD.label = 1
var_0_2.ACT187FINISHGAMEREPLYHAVEGAMECOUNTFIELD.has_default_value = false
var_0_2.ACT187FINISHGAMEREPLYHAVEGAMECOUNTFIELD.default_value = 0
var_0_2.ACT187FINISHGAMEREPLYHAVEGAMECOUNTFIELD.type = 13
var_0_2.ACT187FINISHGAMEREPLYHAVEGAMECOUNTFIELD.cpp_type = 3
var_0_2.ACT187FINISHGAMEREPLYFINISHGAMECOUNTFIELD.name = "finishGameCount"
var_0_2.ACT187FINISHGAMEREPLYFINISHGAMECOUNTFIELD.full_name = ".Act187FinishGameReply.finishGameCount"
var_0_2.ACT187FINISHGAMEREPLYFINISHGAMECOUNTFIELD.number = 3
var_0_2.ACT187FINISHGAMEREPLYFINISHGAMECOUNTFIELD.index = 2
var_0_2.ACT187FINISHGAMEREPLYFINISHGAMECOUNTFIELD.label = 1
var_0_2.ACT187FINISHGAMEREPLYFINISHGAMECOUNTFIELD.has_default_value = false
var_0_2.ACT187FINISHGAMEREPLYFINISHGAMECOUNTFIELD.default_value = 0
var_0_2.ACT187FINISHGAMEREPLYFINISHGAMECOUNTFIELD.type = 13
var_0_2.ACT187FINISHGAMEREPLYFINISHGAMECOUNTFIELD.cpp_type = 3
var_0_2.ACT187FINISHGAMEREPLYRANDOMBONUSLISTFIELD.name = "randomBonusList"
var_0_2.ACT187FINISHGAMEREPLYRANDOMBONUSLISTFIELD.full_name = ".Act187FinishGameReply.randomBonusList"
var_0_2.ACT187FINISHGAMEREPLYRANDOMBONUSLISTFIELD.number = 4
var_0_2.ACT187FINISHGAMEREPLYRANDOMBONUSLISTFIELD.index = 3
var_0_2.ACT187FINISHGAMEREPLYRANDOMBONUSLISTFIELD.label = 3
var_0_2.ACT187FINISHGAMEREPLYRANDOMBONUSLISTFIELD.has_default_value = false
var_0_2.ACT187FINISHGAMEREPLYRANDOMBONUSLISTFIELD.default_value = {}
var_0_2.ACT187FINISHGAMEREPLYRANDOMBONUSLISTFIELD.message_type = var_0_2.MATERIALMODULE_PB.MATERIALDATA_MSG
var_0_2.ACT187FINISHGAMEREPLYRANDOMBONUSLISTFIELD.type = 11
var_0_2.ACT187FINISHGAMEREPLYRANDOMBONUSLISTFIELD.cpp_type = 10
var_0_2.ACT187FINISHGAMEREPLY_MSG.name = "Act187FinishGameReply"
var_0_2.ACT187FINISHGAMEREPLY_MSG.full_name = ".Act187FinishGameReply"
var_0_2.ACT187FINISHGAMEREPLY_MSG.nested_types = {}
var_0_2.ACT187FINISHGAMEREPLY_MSG.enum_types = {}
var_0_2.ACT187FINISHGAMEREPLY_MSG.fields = {
	var_0_2.ACT187FINISHGAMEREPLYACTIVITYIDFIELD,
	var_0_2.ACT187FINISHGAMEREPLYHAVEGAMECOUNTFIELD,
	var_0_2.ACT187FINISHGAMEREPLYFINISHGAMECOUNTFIELD,
	var_0_2.ACT187FINISHGAMEREPLYRANDOMBONUSLISTFIELD
}
var_0_2.ACT187FINISHGAMEREPLY_MSG.is_extendable = false
var_0_2.ACT187FINISHGAMEREPLY_MSG.extensions = {}
var_0_2.ACT187FINISHGAMEREQUESTACTIVITYIDFIELD.name = "activityId"
var_0_2.ACT187FINISHGAMEREQUESTACTIVITYIDFIELD.full_name = ".Act187FinishGameRequest.activityId"
var_0_2.ACT187FINISHGAMEREQUESTACTIVITYIDFIELD.number = 1
var_0_2.ACT187FINISHGAMEREQUESTACTIVITYIDFIELD.index = 0
var_0_2.ACT187FINISHGAMEREQUESTACTIVITYIDFIELD.label = 1
var_0_2.ACT187FINISHGAMEREQUESTACTIVITYIDFIELD.has_default_value = false
var_0_2.ACT187FINISHGAMEREQUESTACTIVITYIDFIELD.default_value = 0
var_0_2.ACT187FINISHGAMEREQUESTACTIVITYIDFIELD.type = 5
var_0_2.ACT187FINISHGAMEREQUESTACTIVITYIDFIELD.cpp_type = 1
var_0_2.ACT187FINISHGAMEREQUEST_MSG.name = "Act187FinishGameRequest"
var_0_2.ACT187FINISHGAMEREQUEST_MSG.full_name = ".Act187FinishGameRequest"
var_0_2.ACT187FINISHGAMEREQUEST_MSG.nested_types = {}
var_0_2.ACT187FINISHGAMEREQUEST_MSG.enum_types = {}
var_0_2.ACT187FINISHGAMEREQUEST_MSG.fields = {
	var_0_2.ACT187FINISHGAMEREQUESTACTIVITYIDFIELD
}
var_0_2.ACT187FINISHGAMEREQUEST_MSG.is_extendable = false
var_0_2.ACT187FINISHGAMEREQUEST_MSG.extensions = {}
var_0_2.RANDOMBONUSINFORANDOMBONUSLISTFIELD.name = "randomBonusList"
var_0_2.RANDOMBONUSINFORANDOMBONUSLISTFIELD.full_name = ".RandomBonusInfo.randomBonusList"
var_0_2.RANDOMBONUSINFORANDOMBONUSLISTFIELD.number = 4
var_0_2.RANDOMBONUSINFORANDOMBONUSLISTFIELD.index = 0
var_0_2.RANDOMBONUSINFORANDOMBONUSLISTFIELD.label = 3
var_0_2.RANDOMBONUSINFORANDOMBONUSLISTFIELD.has_default_value = false
var_0_2.RANDOMBONUSINFORANDOMBONUSLISTFIELD.default_value = {}
var_0_2.RANDOMBONUSINFORANDOMBONUSLISTFIELD.message_type = var_0_2.MATERIALMODULE_PB.MATERIALDATA_MSG
var_0_2.RANDOMBONUSINFORANDOMBONUSLISTFIELD.type = 11
var_0_2.RANDOMBONUSINFORANDOMBONUSLISTFIELD.cpp_type = 10
var_0_2.RANDOMBONUSINFO_MSG.name = "RandomBonusInfo"
var_0_2.RANDOMBONUSINFO_MSG.full_name = ".RandomBonusInfo"
var_0_2.RANDOMBONUSINFO_MSG.nested_types = {}
var_0_2.RANDOMBONUSINFO_MSG.enum_types = {}
var_0_2.RANDOMBONUSINFO_MSG.fields = {
	var_0_2.RANDOMBONUSINFORANDOMBONUSLISTFIELD
}
var_0_2.RANDOMBONUSINFO_MSG.is_extendable = false
var_0_2.RANDOMBONUSINFO_MSG.extensions = {}
var_0_2.Act187AcceptRewardReply = var_0_1.Message(var_0_2.ACT187ACCEPTREWARDREPLY_MSG)
var_0_2.Act187AcceptRewardRequest = var_0_1.Message(var_0_2.ACT187ACCEPTREWARDREQUEST_MSG)
var_0_2.Act187FinishGameReply = var_0_1.Message(var_0_2.ACT187FINISHGAMEREPLY_MSG)
var_0_2.Act187FinishGameRequest = var_0_1.Message(var_0_2.ACT187FINISHGAMEREQUEST_MSG)
var_0_2.Get187InfoReply = var_0_1.Message(var_0_2.GET187INFOREPLY_MSG)
var_0_2.Get187InfoRequest = var_0_1.Message(var_0_2.GET187INFOREQUEST_MSG)
var_0_2.RandomBonusInfo = var_0_1.Message(var_0_2.RANDOMBONUSINFO_MSG)

return var_0_2
