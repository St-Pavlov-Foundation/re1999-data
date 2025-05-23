﻿local var_0_0 = require("protobuf.protobuf")

module("modules.proto.Activity199Module_pb", package.seeall)

local var_0_1 = {
	GET199INFOREQUEST_MSG = var_0_0.Descriptor(),
	GET199INFOREQUESTACTIVITYIDFIELD = var_0_0.FieldDescriptor(),
	ACT199GAINREQUEST_MSG = var_0_0.Descriptor(),
	ACT199GAINREQUESTACTIVITYIDFIELD = var_0_0.FieldDescriptor(),
	ACT199GAINREQUESTHEROIDFIELD = var_0_0.FieldDescriptor(),
	ACT199GAINREPLY_MSG = var_0_0.Descriptor(),
	ACT199GAINREPLYACTIVITYIDFIELD = var_0_0.FieldDescriptor(),
	ACT199GAINREPLYHEROIDFIELD = var_0_0.FieldDescriptor(),
	GET199INFOREPLY_MSG = var_0_0.Descriptor(),
	GET199INFOREPLYACTIVITYIDFIELD = var_0_0.FieldDescriptor(),
	GET199INFOREPLYHEROIDFIELD = var_0_0.FieldDescriptor()
}

var_0_1.GET199INFOREQUESTACTIVITYIDFIELD.name = "activityId"
var_0_1.GET199INFOREQUESTACTIVITYIDFIELD.full_name = ".Get199InfoRequest.activityId"
var_0_1.GET199INFOREQUESTACTIVITYIDFIELD.number = 1
var_0_1.GET199INFOREQUESTACTIVITYIDFIELD.index = 0
var_0_1.GET199INFOREQUESTACTIVITYIDFIELD.label = 1
var_0_1.GET199INFOREQUESTACTIVITYIDFIELD.has_default_value = false
var_0_1.GET199INFOREQUESTACTIVITYIDFIELD.default_value = 0
var_0_1.GET199INFOREQUESTACTIVITYIDFIELD.type = 5
var_0_1.GET199INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
var_0_1.GET199INFOREQUEST_MSG.name = "Get199InfoRequest"
var_0_1.GET199INFOREQUEST_MSG.full_name = ".Get199InfoRequest"
var_0_1.GET199INFOREQUEST_MSG.nested_types = {}
var_0_1.GET199INFOREQUEST_MSG.enum_types = {}
var_0_1.GET199INFOREQUEST_MSG.fields = {
	var_0_1.GET199INFOREQUESTACTIVITYIDFIELD
}
var_0_1.GET199INFOREQUEST_MSG.is_extendable = false
var_0_1.GET199INFOREQUEST_MSG.extensions = {}
var_0_1.ACT199GAINREQUESTACTIVITYIDFIELD.name = "activityId"
var_0_1.ACT199GAINREQUESTACTIVITYIDFIELD.full_name = ".Act199GainRequest.activityId"
var_0_1.ACT199GAINREQUESTACTIVITYIDFIELD.number = 1
var_0_1.ACT199GAINREQUESTACTIVITYIDFIELD.index = 0
var_0_1.ACT199GAINREQUESTACTIVITYIDFIELD.label = 1
var_0_1.ACT199GAINREQUESTACTIVITYIDFIELD.has_default_value = false
var_0_1.ACT199GAINREQUESTACTIVITYIDFIELD.default_value = 0
var_0_1.ACT199GAINREQUESTACTIVITYIDFIELD.type = 5
var_0_1.ACT199GAINREQUESTACTIVITYIDFIELD.cpp_type = 1
var_0_1.ACT199GAINREQUESTHEROIDFIELD.name = "heroId"
var_0_1.ACT199GAINREQUESTHEROIDFIELD.full_name = ".Act199GainRequest.heroId"
var_0_1.ACT199GAINREQUESTHEROIDFIELD.number = 2
var_0_1.ACT199GAINREQUESTHEROIDFIELD.index = 1
var_0_1.ACT199GAINREQUESTHEROIDFIELD.label = 1
var_0_1.ACT199GAINREQUESTHEROIDFIELD.has_default_value = false
var_0_1.ACT199GAINREQUESTHEROIDFIELD.default_value = 0
var_0_1.ACT199GAINREQUESTHEROIDFIELD.type = 5
var_0_1.ACT199GAINREQUESTHEROIDFIELD.cpp_type = 1
var_0_1.ACT199GAINREQUEST_MSG.name = "Act199GainRequest"
var_0_1.ACT199GAINREQUEST_MSG.full_name = ".Act199GainRequest"
var_0_1.ACT199GAINREQUEST_MSG.nested_types = {}
var_0_1.ACT199GAINREQUEST_MSG.enum_types = {}
var_0_1.ACT199GAINREQUEST_MSG.fields = {
	var_0_1.ACT199GAINREQUESTACTIVITYIDFIELD,
	var_0_1.ACT199GAINREQUESTHEROIDFIELD
}
var_0_1.ACT199GAINREQUEST_MSG.is_extendable = false
var_0_1.ACT199GAINREQUEST_MSG.extensions = {}
var_0_1.ACT199GAINREPLYACTIVITYIDFIELD.name = "activityId"
var_0_1.ACT199GAINREPLYACTIVITYIDFIELD.full_name = ".Act199GainReply.activityId"
var_0_1.ACT199GAINREPLYACTIVITYIDFIELD.number = 1
var_0_1.ACT199GAINREPLYACTIVITYIDFIELD.index = 0
var_0_1.ACT199GAINREPLYACTIVITYIDFIELD.label = 1
var_0_1.ACT199GAINREPLYACTIVITYIDFIELD.has_default_value = false
var_0_1.ACT199GAINREPLYACTIVITYIDFIELD.default_value = 0
var_0_1.ACT199GAINREPLYACTIVITYIDFIELD.type = 5
var_0_1.ACT199GAINREPLYACTIVITYIDFIELD.cpp_type = 1
var_0_1.ACT199GAINREPLYHEROIDFIELD.name = "heroId"
var_0_1.ACT199GAINREPLYHEROIDFIELD.full_name = ".Act199GainReply.heroId"
var_0_1.ACT199GAINREPLYHEROIDFIELD.number = 2
var_0_1.ACT199GAINREPLYHEROIDFIELD.index = 1
var_0_1.ACT199GAINREPLYHEROIDFIELD.label = 1
var_0_1.ACT199GAINREPLYHEROIDFIELD.has_default_value = false
var_0_1.ACT199GAINREPLYHEROIDFIELD.default_value = 0
var_0_1.ACT199GAINREPLYHEROIDFIELD.type = 5
var_0_1.ACT199GAINREPLYHEROIDFIELD.cpp_type = 1
var_0_1.ACT199GAINREPLY_MSG.name = "Act199GainReply"
var_0_1.ACT199GAINREPLY_MSG.full_name = ".Act199GainReply"
var_0_1.ACT199GAINREPLY_MSG.nested_types = {}
var_0_1.ACT199GAINREPLY_MSG.enum_types = {}
var_0_1.ACT199GAINREPLY_MSG.fields = {
	var_0_1.ACT199GAINREPLYACTIVITYIDFIELD,
	var_0_1.ACT199GAINREPLYHEROIDFIELD
}
var_0_1.ACT199GAINREPLY_MSG.is_extendable = false
var_0_1.ACT199GAINREPLY_MSG.extensions = {}
var_0_1.GET199INFOREPLYACTIVITYIDFIELD.name = "activityId"
var_0_1.GET199INFOREPLYACTIVITYIDFIELD.full_name = ".Get199InfoReply.activityId"
var_0_1.GET199INFOREPLYACTIVITYIDFIELD.number = 1
var_0_1.GET199INFOREPLYACTIVITYIDFIELD.index = 0
var_0_1.GET199INFOREPLYACTIVITYIDFIELD.label = 1
var_0_1.GET199INFOREPLYACTIVITYIDFIELD.has_default_value = false
var_0_1.GET199INFOREPLYACTIVITYIDFIELD.default_value = 0
var_0_1.GET199INFOREPLYACTIVITYIDFIELD.type = 5
var_0_1.GET199INFOREPLYACTIVITYIDFIELD.cpp_type = 1
var_0_1.GET199INFOREPLYHEROIDFIELD.name = "heroId"
var_0_1.GET199INFOREPLYHEROIDFIELD.full_name = ".Get199InfoReply.heroId"
var_0_1.GET199INFOREPLYHEROIDFIELD.number = 2
var_0_1.GET199INFOREPLYHEROIDFIELD.index = 1
var_0_1.GET199INFOREPLYHEROIDFIELD.label = 1
var_0_1.GET199INFOREPLYHEROIDFIELD.has_default_value = false
var_0_1.GET199INFOREPLYHEROIDFIELD.default_value = 0
var_0_1.GET199INFOREPLYHEROIDFIELD.type = 5
var_0_1.GET199INFOREPLYHEROIDFIELD.cpp_type = 1
var_0_1.GET199INFOREPLY_MSG.name = "Get199InfoReply"
var_0_1.GET199INFOREPLY_MSG.full_name = ".Get199InfoReply"
var_0_1.GET199INFOREPLY_MSG.nested_types = {}
var_0_1.GET199INFOREPLY_MSG.enum_types = {}
var_0_1.GET199INFOREPLY_MSG.fields = {
	var_0_1.GET199INFOREPLYACTIVITYIDFIELD,
	var_0_1.GET199INFOREPLYHEROIDFIELD
}
var_0_1.GET199INFOREPLY_MSG.is_extendable = false
var_0_1.GET199INFOREPLY_MSG.extensions = {}
var_0_1.Act199GainReply = var_0_0.Message(var_0_1.ACT199GAINREPLY_MSG)
var_0_1.Act199GainRequest = var_0_0.Message(var_0_1.ACT199GAINREQUEST_MSG)
var_0_1.Get199InfoReply = var_0_0.Message(var_0_1.GET199INFOREPLY_MSG)
var_0_1.Get199InfoRequest = var_0_0.Message(var_0_1.GET199INFOREQUEST_MSG)

return var_0_1
