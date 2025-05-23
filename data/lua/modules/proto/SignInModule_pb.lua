﻿local var_0_0 = require("protobuf.protobuf")

module("modules.proto.SignInModule_pb", package.seeall)

local var_0_1 = {
	SIGNINHISTORYREQUEST_MSG = var_0_0.Descriptor(),
	SIGNINHISTORYREQUESTMONTHFIELD = var_0_0.FieldDescriptor(),
	GETHEROBIRTHDAYREQUEST_MSG = var_0_0.Descriptor(),
	GETHEROBIRTHDAYREQUESTHEROIDFIELD = var_0_0.FieldDescriptor(),
	GETHEROBIRTHDAYREPLY_MSG = var_0_0.Descriptor(),
	GETHEROBIRTHDAYREPLYHEROIDFIELD = var_0_0.FieldDescriptor(),
	SIGNINTOTALREWARDREQUEST_MSG = var_0_0.Descriptor(),
	SIGNINTOTALREWARDREQUESTIDFIELD = var_0_0.FieldDescriptor(),
	SIGNINTOTALREWARDREPLY_MSG = var_0_0.Descriptor(),
	SIGNINTOTALREWARDREPLYIDFIELD = var_0_0.FieldDescriptor(),
	SIGNINTOTALREWARDREPLYMARKFIELD = var_0_0.FieldDescriptor(),
	MONTHCARDHISTORY_MSG = var_0_0.Descriptor(),
	MONTHCARDHISTORYIDFIELD = var_0_0.FieldDescriptor(),
	MONTHCARDHISTORYSTARTTIMEFIELD = var_0_0.FieldDescriptor(),
	MONTHCARDHISTORYENDTIMEFIELD = var_0_0.FieldDescriptor(),
	SIGNINHISTORYREPLY_MSG = var_0_0.Descriptor(),
	SIGNINHISTORYREPLYMONTHFIELD = var_0_0.FieldDescriptor(),
	SIGNINHISTORYREPLYHASSIGNINDAYSFIELD = var_0_0.FieldDescriptor(),
	SIGNINHISTORYREPLYHASMONTHCARDDAYSFIELD = var_0_0.FieldDescriptor(),
	SIGNINHISTORYREPLYBIRTHDAYHEROIDSFIELD = var_0_0.FieldDescriptor(),
	SIGNINADDUPREPLY_MSG = var_0_0.Descriptor(),
	SIGNINADDUPREPLYIDFIELD = var_0_0.FieldDescriptor(),
	SIGNINTOTALREWARDALLREPLY_MSG = var_0_0.Descriptor(),
	SIGNINTOTALREWARDALLREPLYMARKFIELD = var_0_0.FieldDescriptor(),
	SIGNINREPLY_MSG = var_0_0.Descriptor(),
	SIGNINREPLYDAYFIELD = var_0_0.FieldDescriptor(),
	SIGNINREPLYBIRTHDAYHEROIDSFIELD = var_0_0.FieldDescriptor(),
	GETSIGNININFOREPLY_MSG = var_0_0.Descriptor(),
	GETSIGNININFOREPLYHASSIGNINDAYSFIELD = var_0_0.FieldDescriptor(),
	GETSIGNININFOREPLYADDUPSIGNINDAYFIELD = var_0_0.FieldDescriptor(),
	GETSIGNININFOREPLYHASGETADDUPBONUSFIELD = var_0_0.FieldDescriptor(),
	GETSIGNININFOREPLYOPENFUNCTIONTIMEFIELD = var_0_0.FieldDescriptor(),
	GETSIGNININFOREPLYHASMONTHCARDDAYSFIELD = var_0_0.FieldDescriptor(),
	GETSIGNININFOREPLYMONTHCARDHISTORYFIELD = var_0_0.FieldDescriptor(),
	GETSIGNININFOREPLYBIRTHDAYHEROIDSFIELD = var_0_0.FieldDescriptor(),
	GETSIGNININFOREPLYREWARDMARKFIELD = var_0_0.FieldDescriptor(),
	SIGNINTOTALREWARDALLREQUEST_MSG = var_0_0.Descriptor(),
	SIGNINREQUEST_MSG = var_0_0.Descriptor(),
	SIGNINADDUPREQUEST_MSG = var_0_0.Descriptor(),
	SIGNINADDUPREQUESTIDFIELD = var_0_0.FieldDescriptor(),
	GETSIGNININFOREQUEST_MSG = var_0_0.Descriptor()
}

var_0_1.SIGNINHISTORYREQUESTMONTHFIELD.name = "month"
var_0_1.SIGNINHISTORYREQUESTMONTHFIELD.full_name = ".SignInHistoryRequest.month"
var_0_1.SIGNINHISTORYREQUESTMONTHFIELD.number = 1
var_0_1.SIGNINHISTORYREQUESTMONTHFIELD.index = 0
var_0_1.SIGNINHISTORYREQUESTMONTHFIELD.label = 1
var_0_1.SIGNINHISTORYREQUESTMONTHFIELD.has_default_value = false
var_0_1.SIGNINHISTORYREQUESTMONTHFIELD.default_value = 0
var_0_1.SIGNINHISTORYREQUESTMONTHFIELD.type = 5
var_0_1.SIGNINHISTORYREQUESTMONTHFIELD.cpp_type = 1
var_0_1.SIGNINHISTORYREQUEST_MSG.name = "SignInHistoryRequest"
var_0_1.SIGNINHISTORYREQUEST_MSG.full_name = ".SignInHistoryRequest"
var_0_1.SIGNINHISTORYREQUEST_MSG.nested_types = {}
var_0_1.SIGNINHISTORYREQUEST_MSG.enum_types = {}
var_0_1.SIGNINHISTORYREQUEST_MSG.fields = {
	var_0_1.SIGNINHISTORYREQUESTMONTHFIELD
}
var_0_1.SIGNINHISTORYREQUEST_MSG.is_extendable = false
var_0_1.SIGNINHISTORYREQUEST_MSG.extensions = {}
var_0_1.GETHEROBIRTHDAYREQUESTHEROIDFIELD.name = "heroId"
var_0_1.GETHEROBIRTHDAYREQUESTHEROIDFIELD.full_name = ".GetHeroBirthdayRequest.heroId"
var_0_1.GETHEROBIRTHDAYREQUESTHEROIDFIELD.number = 1
var_0_1.GETHEROBIRTHDAYREQUESTHEROIDFIELD.index = 0
var_0_1.GETHEROBIRTHDAYREQUESTHEROIDFIELD.label = 1
var_0_1.GETHEROBIRTHDAYREQUESTHEROIDFIELD.has_default_value = false
var_0_1.GETHEROBIRTHDAYREQUESTHEROIDFIELD.default_value = 0
var_0_1.GETHEROBIRTHDAYREQUESTHEROIDFIELD.type = 5
var_0_1.GETHEROBIRTHDAYREQUESTHEROIDFIELD.cpp_type = 1
var_0_1.GETHEROBIRTHDAYREQUEST_MSG.name = "GetHeroBirthdayRequest"
var_0_1.GETHEROBIRTHDAYREQUEST_MSG.full_name = ".GetHeroBirthdayRequest"
var_0_1.GETHEROBIRTHDAYREQUEST_MSG.nested_types = {}
var_0_1.GETHEROBIRTHDAYREQUEST_MSG.enum_types = {}
var_0_1.GETHEROBIRTHDAYREQUEST_MSG.fields = {
	var_0_1.GETHEROBIRTHDAYREQUESTHEROIDFIELD
}
var_0_1.GETHEROBIRTHDAYREQUEST_MSG.is_extendable = false
var_0_1.GETHEROBIRTHDAYREQUEST_MSG.extensions = {}
var_0_1.GETHEROBIRTHDAYREPLYHEROIDFIELD.name = "heroId"
var_0_1.GETHEROBIRTHDAYREPLYHEROIDFIELD.full_name = ".GetHeroBirthdayReply.heroId"
var_0_1.GETHEROBIRTHDAYREPLYHEROIDFIELD.number = 1
var_0_1.GETHEROBIRTHDAYREPLYHEROIDFIELD.index = 0
var_0_1.GETHEROBIRTHDAYREPLYHEROIDFIELD.label = 1
var_0_1.GETHEROBIRTHDAYREPLYHEROIDFIELD.has_default_value = false
var_0_1.GETHEROBIRTHDAYREPLYHEROIDFIELD.default_value = 0
var_0_1.GETHEROBIRTHDAYREPLYHEROIDFIELD.type = 5
var_0_1.GETHEROBIRTHDAYREPLYHEROIDFIELD.cpp_type = 1
var_0_1.GETHEROBIRTHDAYREPLY_MSG.name = "GetHeroBirthdayReply"
var_0_1.GETHEROBIRTHDAYREPLY_MSG.full_name = ".GetHeroBirthdayReply"
var_0_1.GETHEROBIRTHDAYREPLY_MSG.nested_types = {}
var_0_1.GETHEROBIRTHDAYREPLY_MSG.enum_types = {}
var_0_1.GETHEROBIRTHDAYREPLY_MSG.fields = {
	var_0_1.GETHEROBIRTHDAYREPLYHEROIDFIELD
}
var_0_1.GETHEROBIRTHDAYREPLY_MSG.is_extendable = false
var_0_1.GETHEROBIRTHDAYREPLY_MSG.extensions = {}
var_0_1.SIGNINTOTALREWARDREQUESTIDFIELD.name = "id"
var_0_1.SIGNINTOTALREWARDREQUESTIDFIELD.full_name = ".SignInTotalRewardRequest.id"
var_0_1.SIGNINTOTALREWARDREQUESTIDFIELD.number = 1
var_0_1.SIGNINTOTALREWARDREQUESTIDFIELD.index = 0
var_0_1.SIGNINTOTALREWARDREQUESTIDFIELD.label = 1
var_0_1.SIGNINTOTALREWARDREQUESTIDFIELD.has_default_value = false
var_0_1.SIGNINTOTALREWARDREQUESTIDFIELD.default_value = 0
var_0_1.SIGNINTOTALREWARDREQUESTIDFIELD.type = 5
var_0_1.SIGNINTOTALREWARDREQUESTIDFIELD.cpp_type = 1
var_0_1.SIGNINTOTALREWARDREQUEST_MSG.name = "SignInTotalRewardRequest"
var_0_1.SIGNINTOTALREWARDREQUEST_MSG.full_name = ".SignInTotalRewardRequest"
var_0_1.SIGNINTOTALREWARDREQUEST_MSG.nested_types = {}
var_0_1.SIGNINTOTALREWARDREQUEST_MSG.enum_types = {}
var_0_1.SIGNINTOTALREWARDREQUEST_MSG.fields = {
	var_0_1.SIGNINTOTALREWARDREQUESTIDFIELD
}
var_0_1.SIGNINTOTALREWARDREQUEST_MSG.is_extendable = false
var_0_1.SIGNINTOTALREWARDREQUEST_MSG.extensions = {}
var_0_1.SIGNINTOTALREWARDREPLYIDFIELD.name = "id"
var_0_1.SIGNINTOTALREWARDREPLYIDFIELD.full_name = ".SignInTotalRewardReply.id"
var_0_1.SIGNINTOTALREWARDREPLYIDFIELD.number = 1
var_0_1.SIGNINTOTALREWARDREPLYIDFIELD.index = 0
var_0_1.SIGNINTOTALREWARDREPLYIDFIELD.label = 1
var_0_1.SIGNINTOTALREWARDREPLYIDFIELD.has_default_value = false
var_0_1.SIGNINTOTALREWARDREPLYIDFIELD.default_value = 0
var_0_1.SIGNINTOTALREWARDREPLYIDFIELD.type = 5
var_0_1.SIGNINTOTALREWARDREPLYIDFIELD.cpp_type = 1
var_0_1.SIGNINTOTALREWARDREPLYMARKFIELD.name = "mark"
var_0_1.SIGNINTOTALREWARDREPLYMARKFIELD.full_name = ".SignInTotalRewardReply.mark"
var_0_1.SIGNINTOTALREWARDREPLYMARKFIELD.number = 2
var_0_1.SIGNINTOTALREWARDREPLYMARKFIELD.index = 1
var_0_1.SIGNINTOTALREWARDREPLYMARKFIELD.label = 1
var_0_1.SIGNINTOTALREWARDREPLYMARKFIELD.has_default_value = false
var_0_1.SIGNINTOTALREWARDREPLYMARKFIELD.default_value = 0
var_0_1.SIGNINTOTALREWARDREPLYMARKFIELD.type = 5
var_0_1.SIGNINTOTALREWARDREPLYMARKFIELD.cpp_type = 1
var_0_1.SIGNINTOTALREWARDREPLY_MSG.name = "SignInTotalRewardReply"
var_0_1.SIGNINTOTALREWARDREPLY_MSG.full_name = ".SignInTotalRewardReply"
var_0_1.SIGNINTOTALREWARDREPLY_MSG.nested_types = {}
var_0_1.SIGNINTOTALREWARDREPLY_MSG.enum_types = {}
var_0_1.SIGNINTOTALREWARDREPLY_MSG.fields = {
	var_0_1.SIGNINTOTALREWARDREPLYIDFIELD,
	var_0_1.SIGNINTOTALREWARDREPLYMARKFIELD
}
var_0_1.SIGNINTOTALREWARDREPLY_MSG.is_extendable = false
var_0_1.SIGNINTOTALREWARDREPLY_MSG.extensions = {}
var_0_1.MONTHCARDHISTORYIDFIELD.name = "id"
var_0_1.MONTHCARDHISTORYIDFIELD.full_name = ".MonthCardHistory.id"
var_0_1.MONTHCARDHISTORYIDFIELD.number = 1
var_0_1.MONTHCARDHISTORYIDFIELD.index = 0
var_0_1.MONTHCARDHISTORYIDFIELD.label = 1
var_0_1.MONTHCARDHISTORYIDFIELD.has_default_value = false
var_0_1.MONTHCARDHISTORYIDFIELD.default_value = 0
var_0_1.MONTHCARDHISTORYIDFIELD.type = 5
var_0_1.MONTHCARDHISTORYIDFIELD.cpp_type = 1
var_0_1.MONTHCARDHISTORYSTARTTIMEFIELD.name = "startTime"
var_0_1.MONTHCARDHISTORYSTARTTIMEFIELD.full_name = ".MonthCardHistory.startTime"
var_0_1.MONTHCARDHISTORYSTARTTIMEFIELD.number = 2
var_0_1.MONTHCARDHISTORYSTARTTIMEFIELD.index = 1
var_0_1.MONTHCARDHISTORYSTARTTIMEFIELD.label = 1
var_0_1.MONTHCARDHISTORYSTARTTIMEFIELD.has_default_value = false
var_0_1.MONTHCARDHISTORYSTARTTIMEFIELD.default_value = 0
var_0_1.MONTHCARDHISTORYSTARTTIMEFIELD.type = 5
var_0_1.MONTHCARDHISTORYSTARTTIMEFIELD.cpp_type = 1
var_0_1.MONTHCARDHISTORYENDTIMEFIELD.name = "endTime"
var_0_1.MONTHCARDHISTORYENDTIMEFIELD.full_name = ".MonthCardHistory.endTime"
var_0_1.MONTHCARDHISTORYENDTIMEFIELD.number = 3
var_0_1.MONTHCARDHISTORYENDTIMEFIELD.index = 2
var_0_1.MONTHCARDHISTORYENDTIMEFIELD.label = 1
var_0_1.MONTHCARDHISTORYENDTIMEFIELD.has_default_value = false
var_0_1.MONTHCARDHISTORYENDTIMEFIELD.default_value = 0
var_0_1.MONTHCARDHISTORYENDTIMEFIELD.type = 5
var_0_1.MONTHCARDHISTORYENDTIMEFIELD.cpp_type = 1
var_0_1.MONTHCARDHISTORY_MSG.name = "MonthCardHistory"
var_0_1.MONTHCARDHISTORY_MSG.full_name = ".MonthCardHistory"
var_0_1.MONTHCARDHISTORY_MSG.nested_types = {}
var_0_1.MONTHCARDHISTORY_MSG.enum_types = {}
var_0_1.MONTHCARDHISTORY_MSG.fields = {
	var_0_1.MONTHCARDHISTORYIDFIELD,
	var_0_1.MONTHCARDHISTORYSTARTTIMEFIELD,
	var_0_1.MONTHCARDHISTORYENDTIMEFIELD
}
var_0_1.MONTHCARDHISTORY_MSG.is_extendable = false
var_0_1.MONTHCARDHISTORY_MSG.extensions = {}
var_0_1.SIGNINHISTORYREPLYMONTHFIELD.name = "month"
var_0_1.SIGNINHISTORYREPLYMONTHFIELD.full_name = ".SignInHistoryReply.month"
var_0_1.SIGNINHISTORYREPLYMONTHFIELD.number = 1
var_0_1.SIGNINHISTORYREPLYMONTHFIELD.index = 0
var_0_1.SIGNINHISTORYREPLYMONTHFIELD.label = 1
var_0_1.SIGNINHISTORYREPLYMONTHFIELD.has_default_value = false
var_0_1.SIGNINHISTORYREPLYMONTHFIELD.default_value = 0
var_0_1.SIGNINHISTORYREPLYMONTHFIELD.type = 5
var_0_1.SIGNINHISTORYREPLYMONTHFIELD.cpp_type = 1
var_0_1.SIGNINHISTORYREPLYHASSIGNINDAYSFIELD.name = "hasSignInDays"
var_0_1.SIGNINHISTORYREPLYHASSIGNINDAYSFIELD.full_name = ".SignInHistoryReply.hasSignInDays"
var_0_1.SIGNINHISTORYREPLYHASSIGNINDAYSFIELD.number = 2
var_0_1.SIGNINHISTORYREPLYHASSIGNINDAYSFIELD.index = 1
var_0_1.SIGNINHISTORYREPLYHASSIGNINDAYSFIELD.label = 3
var_0_1.SIGNINHISTORYREPLYHASSIGNINDAYSFIELD.has_default_value = false
var_0_1.SIGNINHISTORYREPLYHASSIGNINDAYSFIELD.default_value = {}
var_0_1.SIGNINHISTORYREPLYHASSIGNINDAYSFIELD.type = 5
var_0_1.SIGNINHISTORYREPLYHASSIGNINDAYSFIELD.cpp_type = 1
var_0_1.SIGNINHISTORYREPLYHASMONTHCARDDAYSFIELD.name = "hasMonthCardDays"
var_0_1.SIGNINHISTORYREPLYHASMONTHCARDDAYSFIELD.full_name = ".SignInHistoryReply.hasMonthCardDays"
var_0_1.SIGNINHISTORYREPLYHASMONTHCARDDAYSFIELD.number = 3
var_0_1.SIGNINHISTORYREPLYHASMONTHCARDDAYSFIELD.index = 2
var_0_1.SIGNINHISTORYREPLYHASMONTHCARDDAYSFIELD.label = 3
var_0_1.SIGNINHISTORYREPLYHASMONTHCARDDAYSFIELD.has_default_value = false
var_0_1.SIGNINHISTORYREPLYHASMONTHCARDDAYSFIELD.default_value = {}
var_0_1.SIGNINHISTORYREPLYHASMONTHCARDDAYSFIELD.type = 5
var_0_1.SIGNINHISTORYREPLYHASMONTHCARDDAYSFIELD.cpp_type = 1
var_0_1.SIGNINHISTORYREPLYBIRTHDAYHEROIDSFIELD.name = "birthdayHeroIds"
var_0_1.SIGNINHISTORYREPLYBIRTHDAYHEROIDSFIELD.full_name = ".SignInHistoryReply.birthdayHeroIds"
var_0_1.SIGNINHISTORYREPLYBIRTHDAYHEROIDSFIELD.number = 4
var_0_1.SIGNINHISTORYREPLYBIRTHDAYHEROIDSFIELD.index = 3
var_0_1.SIGNINHISTORYREPLYBIRTHDAYHEROIDSFIELD.label = 3
var_0_1.SIGNINHISTORYREPLYBIRTHDAYHEROIDSFIELD.has_default_value = false
var_0_1.SIGNINHISTORYREPLYBIRTHDAYHEROIDSFIELD.default_value = {}
var_0_1.SIGNINHISTORYREPLYBIRTHDAYHEROIDSFIELD.type = 5
var_0_1.SIGNINHISTORYREPLYBIRTHDAYHEROIDSFIELD.cpp_type = 1
var_0_1.SIGNINHISTORYREPLY_MSG.name = "SignInHistoryReply"
var_0_1.SIGNINHISTORYREPLY_MSG.full_name = ".SignInHistoryReply"
var_0_1.SIGNINHISTORYREPLY_MSG.nested_types = {}
var_0_1.SIGNINHISTORYREPLY_MSG.enum_types = {}
var_0_1.SIGNINHISTORYREPLY_MSG.fields = {
	var_0_1.SIGNINHISTORYREPLYMONTHFIELD,
	var_0_1.SIGNINHISTORYREPLYHASSIGNINDAYSFIELD,
	var_0_1.SIGNINHISTORYREPLYHASMONTHCARDDAYSFIELD,
	var_0_1.SIGNINHISTORYREPLYBIRTHDAYHEROIDSFIELD
}
var_0_1.SIGNINHISTORYREPLY_MSG.is_extendable = false
var_0_1.SIGNINHISTORYREPLY_MSG.extensions = {}
var_0_1.SIGNINADDUPREPLYIDFIELD.name = "id"
var_0_1.SIGNINADDUPREPLYIDFIELD.full_name = ".SignInAddupReply.id"
var_0_1.SIGNINADDUPREPLYIDFIELD.number = 1
var_0_1.SIGNINADDUPREPLYIDFIELD.index = 0
var_0_1.SIGNINADDUPREPLYIDFIELD.label = 1
var_0_1.SIGNINADDUPREPLYIDFIELD.has_default_value = false
var_0_1.SIGNINADDUPREPLYIDFIELD.default_value = 0
var_0_1.SIGNINADDUPREPLYIDFIELD.type = 5
var_0_1.SIGNINADDUPREPLYIDFIELD.cpp_type = 1
var_0_1.SIGNINADDUPREPLY_MSG.name = "SignInAddupReply"
var_0_1.SIGNINADDUPREPLY_MSG.full_name = ".SignInAddupReply"
var_0_1.SIGNINADDUPREPLY_MSG.nested_types = {}
var_0_1.SIGNINADDUPREPLY_MSG.enum_types = {}
var_0_1.SIGNINADDUPREPLY_MSG.fields = {
	var_0_1.SIGNINADDUPREPLYIDFIELD
}
var_0_1.SIGNINADDUPREPLY_MSG.is_extendable = false
var_0_1.SIGNINADDUPREPLY_MSG.extensions = {}
var_0_1.SIGNINTOTALREWARDALLREPLYMARKFIELD.name = "mark"
var_0_1.SIGNINTOTALREWARDALLREPLYMARKFIELD.full_name = ".SignInTotalRewardAllReply.mark"
var_0_1.SIGNINTOTALREWARDALLREPLYMARKFIELD.number = 1
var_0_1.SIGNINTOTALREWARDALLREPLYMARKFIELD.index = 0
var_0_1.SIGNINTOTALREWARDALLREPLYMARKFIELD.label = 1
var_0_1.SIGNINTOTALREWARDALLREPLYMARKFIELD.has_default_value = false
var_0_1.SIGNINTOTALREWARDALLREPLYMARKFIELD.default_value = 0
var_0_1.SIGNINTOTALREWARDALLREPLYMARKFIELD.type = 5
var_0_1.SIGNINTOTALREWARDALLREPLYMARKFIELD.cpp_type = 1
var_0_1.SIGNINTOTALREWARDALLREPLY_MSG.name = "SignInTotalRewardAllReply"
var_0_1.SIGNINTOTALREWARDALLREPLY_MSG.full_name = ".SignInTotalRewardAllReply"
var_0_1.SIGNINTOTALREWARDALLREPLY_MSG.nested_types = {}
var_0_1.SIGNINTOTALREWARDALLREPLY_MSG.enum_types = {}
var_0_1.SIGNINTOTALREWARDALLREPLY_MSG.fields = {
	var_0_1.SIGNINTOTALREWARDALLREPLYMARKFIELD
}
var_0_1.SIGNINTOTALREWARDALLREPLY_MSG.is_extendable = false
var_0_1.SIGNINTOTALREWARDALLREPLY_MSG.extensions = {}
var_0_1.SIGNINREPLYDAYFIELD.name = "day"
var_0_1.SIGNINREPLYDAYFIELD.full_name = ".SignInReply.day"
var_0_1.SIGNINREPLYDAYFIELD.number = 1
var_0_1.SIGNINREPLYDAYFIELD.index = 0
var_0_1.SIGNINREPLYDAYFIELD.label = 1
var_0_1.SIGNINREPLYDAYFIELD.has_default_value = false
var_0_1.SIGNINREPLYDAYFIELD.default_value = 0
var_0_1.SIGNINREPLYDAYFIELD.type = 5
var_0_1.SIGNINREPLYDAYFIELD.cpp_type = 1
var_0_1.SIGNINREPLYBIRTHDAYHEROIDSFIELD.name = "birthdayHeroIds"
var_0_1.SIGNINREPLYBIRTHDAYHEROIDSFIELD.full_name = ".SignInReply.birthdayHeroIds"
var_0_1.SIGNINREPLYBIRTHDAYHEROIDSFIELD.number = 2
var_0_1.SIGNINREPLYBIRTHDAYHEROIDSFIELD.index = 1
var_0_1.SIGNINREPLYBIRTHDAYHEROIDSFIELD.label = 3
var_0_1.SIGNINREPLYBIRTHDAYHEROIDSFIELD.has_default_value = false
var_0_1.SIGNINREPLYBIRTHDAYHEROIDSFIELD.default_value = {}
var_0_1.SIGNINREPLYBIRTHDAYHEROIDSFIELD.type = 5
var_0_1.SIGNINREPLYBIRTHDAYHEROIDSFIELD.cpp_type = 1
var_0_1.SIGNINREPLY_MSG.name = "SignInReply"
var_0_1.SIGNINREPLY_MSG.full_name = ".SignInReply"
var_0_1.SIGNINREPLY_MSG.nested_types = {}
var_0_1.SIGNINREPLY_MSG.enum_types = {}
var_0_1.SIGNINREPLY_MSG.fields = {
	var_0_1.SIGNINREPLYDAYFIELD,
	var_0_1.SIGNINREPLYBIRTHDAYHEROIDSFIELD
}
var_0_1.SIGNINREPLY_MSG.is_extendable = false
var_0_1.SIGNINREPLY_MSG.extensions = {}
var_0_1.GETSIGNININFOREPLYHASSIGNINDAYSFIELD.name = "hasSignInDays"
var_0_1.GETSIGNININFOREPLYHASSIGNINDAYSFIELD.full_name = ".GetSignInInfoReply.hasSignInDays"
var_0_1.GETSIGNININFOREPLYHASSIGNINDAYSFIELD.number = 1
var_0_1.GETSIGNININFOREPLYHASSIGNINDAYSFIELD.index = 0
var_0_1.GETSIGNININFOREPLYHASSIGNINDAYSFIELD.label = 3
var_0_1.GETSIGNININFOREPLYHASSIGNINDAYSFIELD.has_default_value = false
var_0_1.GETSIGNININFOREPLYHASSIGNINDAYSFIELD.default_value = {}
var_0_1.GETSIGNININFOREPLYHASSIGNINDAYSFIELD.type = 5
var_0_1.GETSIGNININFOREPLYHASSIGNINDAYSFIELD.cpp_type = 1
var_0_1.GETSIGNININFOREPLYADDUPSIGNINDAYFIELD.name = "addupSignInDay"
var_0_1.GETSIGNININFOREPLYADDUPSIGNINDAYFIELD.full_name = ".GetSignInInfoReply.addupSignInDay"
var_0_1.GETSIGNININFOREPLYADDUPSIGNINDAYFIELD.number = 2
var_0_1.GETSIGNININFOREPLYADDUPSIGNINDAYFIELD.index = 1
var_0_1.GETSIGNININFOREPLYADDUPSIGNINDAYFIELD.label = 1
var_0_1.GETSIGNININFOREPLYADDUPSIGNINDAYFIELD.has_default_value = false
var_0_1.GETSIGNININFOREPLYADDUPSIGNINDAYFIELD.default_value = 0
var_0_1.GETSIGNININFOREPLYADDUPSIGNINDAYFIELD.type = 5
var_0_1.GETSIGNININFOREPLYADDUPSIGNINDAYFIELD.cpp_type = 1
var_0_1.GETSIGNININFOREPLYHASGETADDUPBONUSFIELD.name = "hasGetAddupBonus"
var_0_1.GETSIGNININFOREPLYHASGETADDUPBONUSFIELD.full_name = ".GetSignInInfoReply.hasGetAddupBonus"
var_0_1.GETSIGNININFOREPLYHASGETADDUPBONUSFIELD.number = 3
var_0_1.GETSIGNININFOREPLYHASGETADDUPBONUSFIELD.index = 2
var_0_1.GETSIGNININFOREPLYHASGETADDUPBONUSFIELD.label = 3
var_0_1.GETSIGNININFOREPLYHASGETADDUPBONUSFIELD.has_default_value = false
var_0_1.GETSIGNININFOREPLYHASGETADDUPBONUSFIELD.default_value = {}
var_0_1.GETSIGNININFOREPLYHASGETADDUPBONUSFIELD.type = 5
var_0_1.GETSIGNININFOREPLYHASGETADDUPBONUSFIELD.cpp_type = 1
var_0_1.GETSIGNININFOREPLYOPENFUNCTIONTIMEFIELD.name = "openFunctionTime"
var_0_1.GETSIGNININFOREPLYOPENFUNCTIONTIMEFIELD.full_name = ".GetSignInInfoReply.openFunctionTime"
var_0_1.GETSIGNININFOREPLYOPENFUNCTIONTIMEFIELD.number = 4
var_0_1.GETSIGNININFOREPLYOPENFUNCTIONTIMEFIELD.index = 3
var_0_1.GETSIGNININFOREPLYOPENFUNCTIONTIMEFIELD.label = 1
var_0_1.GETSIGNININFOREPLYOPENFUNCTIONTIMEFIELD.has_default_value = false
var_0_1.GETSIGNININFOREPLYOPENFUNCTIONTIMEFIELD.default_value = 0
var_0_1.GETSIGNININFOREPLYOPENFUNCTIONTIMEFIELD.type = 5
var_0_1.GETSIGNININFOREPLYOPENFUNCTIONTIMEFIELD.cpp_type = 1
var_0_1.GETSIGNININFOREPLYHASMONTHCARDDAYSFIELD.name = "hasMonthCardDays"
var_0_1.GETSIGNININFOREPLYHASMONTHCARDDAYSFIELD.full_name = ".GetSignInInfoReply.hasMonthCardDays"
var_0_1.GETSIGNININFOREPLYHASMONTHCARDDAYSFIELD.number = 5
var_0_1.GETSIGNININFOREPLYHASMONTHCARDDAYSFIELD.index = 4
var_0_1.GETSIGNININFOREPLYHASMONTHCARDDAYSFIELD.label = 3
var_0_1.GETSIGNININFOREPLYHASMONTHCARDDAYSFIELD.has_default_value = false
var_0_1.GETSIGNININFOREPLYHASMONTHCARDDAYSFIELD.default_value = {}
var_0_1.GETSIGNININFOREPLYHASMONTHCARDDAYSFIELD.type = 5
var_0_1.GETSIGNININFOREPLYHASMONTHCARDDAYSFIELD.cpp_type = 1
var_0_1.GETSIGNININFOREPLYMONTHCARDHISTORYFIELD.name = "monthCardHistory"
var_0_1.GETSIGNININFOREPLYMONTHCARDHISTORYFIELD.full_name = ".GetSignInInfoReply.monthCardHistory"
var_0_1.GETSIGNININFOREPLYMONTHCARDHISTORYFIELD.number = 6
var_0_1.GETSIGNININFOREPLYMONTHCARDHISTORYFIELD.index = 5
var_0_1.GETSIGNININFOREPLYMONTHCARDHISTORYFIELD.label = 3
var_0_1.GETSIGNININFOREPLYMONTHCARDHISTORYFIELD.has_default_value = false
var_0_1.GETSIGNININFOREPLYMONTHCARDHISTORYFIELD.default_value = {}
var_0_1.GETSIGNININFOREPLYMONTHCARDHISTORYFIELD.message_type = var_0_1.MONTHCARDHISTORY_MSG
var_0_1.GETSIGNININFOREPLYMONTHCARDHISTORYFIELD.type = 11
var_0_1.GETSIGNININFOREPLYMONTHCARDHISTORYFIELD.cpp_type = 10
var_0_1.GETSIGNININFOREPLYBIRTHDAYHEROIDSFIELD.name = "birthdayHeroIds"
var_0_1.GETSIGNININFOREPLYBIRTHDAYHEROIDSFIELD.full_name = ".GetSignInInfoReply.birthdayHeroIds"
var_0_1.GETSIGNININFOREPLYBIRTHDAYHEROIDSFIELD.number = 7
var_0_1.GETSIGNININFOREPLYBIRTHDAYHEROIDSFIELD.index = 6
var_0_1.GETSIGNININFOREPLYBIRTHDAYHEROIDSFIELD.label = 3
var_0_1.GETSIGNININFOREPLYBIRTHDAYHEROIDSFIELD.has_default_value = false
var_0_1.GETSIGNININFOREPLYBIRTHDAYHEROIDSFIELD.default_value = {}
var_0_1.GETSIGNININFOREPLYBIRTHDAYHEROIDSFIELD.type = 5
var_0_1.GETSIGNININFOREPLYBIRTHDAYHEROIDSFIELD.cpp_type = 1
var_0_1.GETSIGNININFOREPLYREWARDMARKFIELD.name = "rewardMark"
var_0_1.GETSIGNININFOREPLYREWARDMARKFIELD.full_name = ".GetSignInInfoReply.rewardMark"
var_0_1.GETSIGNININFOREPLYREWARDMARKFIELD.number = 8
var_0_1.GETSIGNININFOREPLYREWARDMARKFIELD.index = 7
var_0_1.GETSIGNININFOREPLYREWARDMARKFIELD.label = 1
var_0_1.GETSIGNININFOREPLYREWARDMARKFIELD.has_default_value = false
var_0_1.GETSIGNININFOREPLYREWARDMARKFIELD.default_value = 0
var_0_1.GETSIGNININFOREPLYREWARDMARKFIELD.type = 5
var_0_1.GETSIGNININFOREPLYREWARDMARKFIELD.cpp_type = 1
var_0_1.GETSIGNININFOREPLY_MSG.name = "GetSignInInfoReply"
var_0_1.GETSIGNININFOREPLY_MSG.full_name = ".GetSignInInfoReply"
var_0_1.GETSIGNININFOREPLY_MSG.nested_types = {}
var_0_1.GETSIGNININFOREPLY_MSG.enum_types = {}
var_0_1.GETSIGNININFOREPLY_MSG.fields = {
	var_0_1.GETSIGNININFOREPLYHASSIGNINDAYSFIELD,
	var_0_1.GETSIGNININFOREPLYADDUPSIGNINDAYFIELD,
	var_0_1.GETSIGNININFOREPLYHASGETADDUPBONUSFIELD,
	var_0_1.GETSIGNININFOREPLYOPENFUNCTIONTIMEFIELD,
	var_0_1.GETSIGNININFOREPLYHASMONTHCARDDAYSFIELD,
	var_0_1.GETSIGNININFOREPLYMONTHCARDHISTORYFIELD,
	var_0_1.GETSIGNININFOREPLYBIRTHDAYHEROIDSFIELD,
	var_0_1.GETSIGNININFOREPLYREWARDMARKFIELD
}
var_0_1.GETSIGNININFOREPLY_MSG.is_extendable = false
var_0_1.GETSIGNININFOREPLY_MSG.extensions = {}
var_0_1.SIGNINTOTALREWARDALLREQUEST_MSG.name = "SignInTotalRewardAllRequest"
var_0_1.SIGNINTOTALREWARDALLREQUEST_MSG.full_name = ".SignInTotalRewardAllRequest"
var_0_1.SIGNINTOTALREWARDALLREQUEST_MSG.nested_types = {}
var_0_1.SIGNINTOTALREWARDALLREQUEST_MSG.enum_types = {}
var_0_1.SIGNINTOTALREWARDALLREQUEST_MSG.fields = {}
var_0_1.SIGNINTOTALREWARDALLREQUEST_MSG.is_extendable = false
var_0_1.SIGNINTOTALREWARDALLREQUEST_MSG.extensions = {}
var_0_1.SIGNINREQUEST_MSG.name = "SignInRequest"
var_0_1.SIGNINREQUEST_MSG.full_name = ".SignInRequest"
var_0_1.SIGNINREQUEST_MSG.nested_types = {}
var_0_1.SIGNINREQUEST_MSG.enum_types = {}
var_0_1.SIGNINREQUEST_MSG.fields = {}
var_0_1.SIGNINREQUEST_MSG.is_extendable = false
var_0_1.SIGNINREQUEST_MSG.extensions = {}
var_0_1.SIGNINADDUPREQUESTIDFIELD.name = "id"
var_0_1.SIGNINADDUPREQUESTIDFIELD.full_name = ".SignInAddupRequest.id"
var_0_1.SIGNINADDUPREQUESTIDFIELD.number = 1
var_0_1.SIGNINADDUPREQUESTIDFIELD.index = 0
var_0_1.SIGNINADDUPREQUESTIDFIELD.label = 1
var_0_1.SIGNINADDUPREQUESTIDFIELD.has_default_value = false
var_0_1.SIGNINADDUPREQUESTIDFIELD.default_value = 0
var_0_1.SIGNINADDUPREQUESTIDFIELD.type = 5
var_0_1.SIGNINADDUPREQUESTIDFIELD.cpp_type = 1
var_0_1.SIGNINADDUPREQUEST_MSG.name = "SignInAddupRequest"
var_0_1.SIGNINADDUPREQUEST_MSG.full_name = ".SignInAddupRequest"
var_0_1.SIGNINADDUPREQUEST_MSG.nested_types = {}
var_0_1.SIGNINADDUPREQUEST_MSG.enum_types = {}
var_0_1.SIGNINADDUPREQUEST_MSG.fields = {
	var_0_1.SIGNINADDUPREQUESTIDFIELD
}
var_0_1.SIGNINADDUPREQUEST_MSG.is_extendable = false
var_0_1.SIGNINADDUPREQUEST_MSG.extensions = {}
var_0_1.GETSIGNININFOREQUEST_MSG.name = "GetSignInInfoRequest"
var_0_1.GETSIGNININFOREQUEST_MSG.full_name = ".GetSignInInfoRequest"
var_0_1.GETSIGNININFOREQUEST_MSG.nested_types = {}
var_0_1.GETSIGNININFOREQUEST_MSG.enum_types = {}
var_0_1.GETSIGNININFOREQUEST_MSG.fields = {}
var_0_1.GETSIGNININFOREQUEST_MSG.is_extendable = false
var_0_1.GETSIGNININFOREQUEST_MSG.extensions = {}
var_0_1.GetHeroBirthdayReply = var_0_0.Message(var_0_1.GETHEROBIRTHDAYREPLY_MSG)
var_0_1.GetHeroBirthdayRequest = var_0_0.Message(var_0_1.GETHEROBIRTHDAYREQUEST_MSG)
var_0_1.GetSignInInfoReply = var_0_0.Message(var_0_1.GETSIGNININFOREPLY_MSG)
var_0_1.GetSignInInfoRequest = var_0_0.Message(var_0_1.GETSIGNININFOREQUEST_MSG)
var_0_1.MonthCardHistory = var_0_0.Message(var_0_1.MONTHCARDHISTORY_MSG)
var_0_1.SignInAddupReply = var_0_0.Message(var_0_1.SIGNINADDUPREPLY_MSG)
var_0_1.SignInAddupRequest = var_0_0.Message(var_0_1.SIGNINADDUPREQUEST_MSG)
var_0_1.SignInHistoryReply = var_0_0.Message(var_0_1.SIGNINHISTORYREPLY_MSG)
var_0_1.SignInHistoryRequest = var_0_0.Message(var_0_1.SIGNINHISTORYREQUEST_MSG)
var_0_1.SignInReply = var_0_0.Message(var_0_1.SIGNINREPLY_MSG)
var_0_1.SignInRequest = var_0_0.Message(var_0_1.SIGNINREQUEST_MSG)
var_0_1.SignInTotalRewardAllReply = var_0_0.Message(var_0_1.SIGNINTOTALREWARDALLREPLY_MSG)
var_0_1.SignInTotalRewardAllRequest = var_0_0.Message(var_0_1.SIGNINTOTALREWARDALLREQUEST_MSG)
var_0_1.SignInTotalRewardReply = var_0_0.Message(var_0_1.SIGNINTOTALREWARDREPLY_MSG)
var_0_1.SignInTotalRewardRequest = var_0_0.Message(var_0_1.SIGNINTOTALREWARDREQUEST_MSG)

return var_0_1
