﻿local var_0_0 = require("protobuf.protobuf")

module("modules.proto.Activity196Module_pb", package.seeall)

local var_0_1 = {
	GET196INFOREQUEST_MSG = var_0_0.Descriptor(),
	GET196INFOREQUESTACTIVITYIDFIELD = var_0_0.FieldDescriptor(),
	ACT196GAINREPLY_MSG = var_0_0.Descriptor(),
	ACT196GAINREPLYACTIVITYIDFIELD = var_0_0.FieldDescriptor(),
	ACT196GAINREPLYIDFIELD = var_0_0.FieldDescriptor(),
	GET196INFOREPLY_MSG = var_0_0.Descriptor(),
	GET196INFOREPLYACTIVITYIDFIELD = var_0_0.FieldDescriptor(),
	GET196INFOREPLYHASGAINFIELD = var_0_0.FieldDescriptor(),
	ACT196GAINREQUEST_MSG = var_0_0.Descriptor(),
	ACT196GAINREQUESTACTIVITYIDFIELD = var_0_0.FieldDescriptor(),
	ACT196GAINREQUESTIDFIELD = var_0_0.FieldDescriptor()
}

var_0_1.GET196INFOREQUESTACTIVITYIDFIELD.name = "activityId"
var_0_1.GET196INFOREQUESTACTIVITYIDFIELD.full_name = ".Get196InfoRequest.activityId"
var_0_1.GET196INFOREQUESTACTIVITYIDFIELD.number = 1
var_0_1.GET196INFOREQUESTACTIVITYIDFIELD.index = 0
var_0_1.GET196INFOREQUESTACTIVITYIDFIELD.label = 1
var_0_1.GET196INFOREQUESTACTIVITYIDFIELD.has_default_value = false
var_0_1.GET196INFOREQUESTACTIVITYIDFIELD.default_value = 0
var_0_1.GET196INFOREQUESTACTIVITYIDFIELD.type = 5
var_0_1.GET196INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
var_0_1.GET196INFOREQUEST_MSG.name = "Get196InfoRequest"
var_0_1.GET196INFOREQUEST_MSG.full_name = ".Get196InfoRequest"
var_0_1.GET196INFOREQUEST_MSG.nested_types = {}
var_0_1.GET196INFOREQUEST_MSG.enum_types = {}
var_0_1.GET196INFOREQUEST_MSG.fields = {
	var_0_1.GET196INFOREQUESTACTIVITYIDFIELD
}
var_0_1.GET196INFOREQUEST_MSG.is_extendable = false
var_0_1.GET196INFOREQUEST_MSG.extensions = {}
var_0_1.ACT196GAINREPLYACTIVITYIDFIELD.name = "activityId"
var_0_1.ACT196GAINREPLYACTIVITYIDFIELD.full_name = ".Act196GainReply.activityId"
var_0_1.ACT196GAINREPLYACTIVITYIDFIELD.number = 1
var_0_1.ACT196GAINREPLYACTIVITYIDFIELD.index = 0
var_0_1.ACT196GAINREPLYACTIVITYIDFIELD.label = 1
var_0_1.ACT196GAINREPLYACTIVITYIDFIELD.has_default_value = false
var_0_1.ACT196GAINREPLYACTIVITYIDFIELD.default_value = 0
var_0_1.ACT196GAINREPLYACTIVITYIDFIELD.type = 5
var_0_1.ACT196GAINREPLYACTIVITYIDFIELD.cpp_type = 1
var_0_1.ACT196GAINREPLYIDFIELD.name = "id"
var_0_1.ACT196GAINREPLYIDFIELD.full_name = ".Act196GainReply.id"
var_0_1.ACT196GAINREPLYIDFIELD.number = 2
var_0_1.ACT196GAINREPLYIDFIELD.index = 1
var_0_1.ACT196GAINREPLYIDFIELD.label = 1
var_0_1.ACT196GAINREPLYIDFIELD.has_default_value = false
var_0_1.ACT196GAINREPLYIDFIELD.default_value = 0
var_0_1.ACT196GAINREPLYIDFIELD.type = 5
var_0_1.ACT196GAINREPLYIDFIELD.cpp_type = 1
var_0_1.ACT196GAINREPLY_MSG.name = "Act196GainReply"
var_0_1.ACT196GAINREPLY_MSG.full_name = ".Act196GainReply"
var_0_1.ACT196GAINREPLY_MSG.nested_types = {}
var_0_1.ACT196GAINREPLY_MSG.enum_types = {}
var_0_1.ACT196GAINREPLY_MSG.fields = {
	var_0_1.ACT196GAINREPLYACTIVITYIDFIELD,
	var_0_1.ACT196GAINREPLYIDFIELD
}
var_0_1.ACT196GAINREPLY_MSG.is_extendable = false
var_0_1.ACT196GAINREPLY_MSG.extensions = {}
var_0_1.GET196INFOREPLYACTIVITYIDFIELD.name = "activityId"
var_0_1.GET196INFOREPLYACTIVITYIDFIELD.full_name = ".Get196InfoReply.activityId"
var_0_1.GET196INFOREPLYACTIVITYIDFIELD.number = 1
var_0_1.GET196INFOREPLYACTIVITYIDFIELD.index = 0
var_0_1.GET196INFOREPLYACTIVITYIDFIELD.label = 1
var_0_1.GET196INFOREPLYACTIVITYIDFIELD.has_default_value = false
var_0_1.GET196INFOREPLYACTIVITYIDFIELD.default_value = 0
var_0_1.GET196INFOREPLYACTIVITYIDFIELD.type = 5
var_0_1.GET196INFOREPLYACTIVITYIDFIELD.cpp_type = 1
var_0_1.GET196INFOREPLYHASGAINFIELD.name = "hasGain"
var_0_1.GET196INFOREPLYHASGAINFIELD.full_name = ".Get196InfoReply.hasGain"
var_0_1.GET196INFOREPLYHASGAINFIELD.number = 2
var_0_1.GET196INFOREPLYHASGAINFIELD.index = 1
var_0_1.GET196INFOREPLYHASGAINFIELD.label = 3
var_0_1.GET196INFOREPLYHASGAINFIELD.has_default_value = false
var_0_1.GET196INFOREPLYHASGAINFIELD.default_value = {}
var_0_1.GET196INFOREPLYHASGAINFIELD.type = 5
var_0_1.GET196INFOREPLYHASGAINFIELD.cpp_type = 1
var_0_1.GET196INFOREPLY_MSG.name = "Get196InfoReply"
var_0_1.GET196INFOREPLY_MSG.full_name = ".Get196InfoReply"
var_0_1.GET196INFOREPLY_MSG.nested_types = {}
var_0_1.GET196INFOREPLY_MSG.enum_types = {}
var_0_1.GET196INFOREPLY_MSG.fields = {
	var_0_1.GET196INFOREPLYACTIVITYIDFIELD,
	var_0_1.GET196INFOREPLYHASGAINFIELD
}
var_0_1.GET196INFOREPLY_MSG.is_extendable = false
var_0_1.GET196INFOREPLY_MSG.extensions = {}
var_0_1.ACT196GAINREQUESTACTIVITYIDFIELD.name = "activityId"
var_0_1.ACT196GAINREQUESTACTIVITYIDFIELD.full_name = ".Act196GainRequest.activityId"
var_0_1.ACT196GAINREQUESTACTIVITYIDFIELD.number = 1
var_0_1.ACT196GAINREQUESTACTIVITYIDFIELD.index = 0
var_0_1.ACT196GAINREQUESTACTIVITYIDFIELD.label = 1
var_0_1.ACT196GAINREQUESTACTIVITYIDFIELD.has_default_value = false
var_0_1.ACT196GAINREQUESTACTIVITYIDFIELD.default_value = 0
var_0_1.ACT196GAINREQUESTACTIVITYIDFIELD.type = 5
var_0_1.ACT196GAINREQUESTACTIVITYIDFIELD.cpp_type = 1
var_0_1.ACT196GAINREQUESTIDFIELD.name = "id"
var_0_1.ACT196GAINREQUESTIDFIELD.full_name = ".Act196GainRequest.id"
var_0_1.ACT196GAINREQUESTIDFIELD.number = 2
var_0_1.ACT196GAINREQUESTIDFIELD.index = 1
var_0_1.ACT196GAINREQUESTIDFIELD.label = 1
var_0_1.ACT196GAINREQUESTIDFIELD.has_default_value = false
var_0_1.ACT196GAINREQUESTIDFIELD.default_value = 0
var_0_1.ACT196GAINREQUESTIDFIELD.type = 5
var_0_1.ACT196GAINREQUESTIDFIELD.cpp_type = 1
var_0_1.ACT196GAINREQUEST_MSG.name = "Act196GainRequest"
var_0_1.ACT196GAINREQUEST_MSG.full_name = ".Act196GainRequest"
var_0_1.ACT196GAINREQUEST_MSG.nested_types = {}
var_0_1.ACT196GAINREQUEST_MSG.enum_types = {}
var_0_1.ACT196GAINREQUEST_MSG.fields = {
	var_0_1.ACT196GAINREQUESTACTIVITYIDFIELD,
	var_0_1.ACT196GAINREQUESTIDFIELD
}
var_0_1.ACT196GAINREQUEST_MSG.is_extendable = false
var_0_1.ACT196GAINREQUEST_MSG.extensions = {}
var_0_1.Act196GainReply = var_0_0.Message(var_0_1.ACT196GAINREPLY_MSG)
var_0_1.Act196GainRequest = var_0_0.Message(var_0_1.ACT196GAINREQUEST_MSG)
var_0_1.Get196InfoReply = var_0_0.Message(var_0_1.GET196INFOREPLY_MSG)
var_0_1.Get196InfoRequest = var_0_0.Message(var_0_1.GET196INFOREQUEST_MSG)

return var_0_1
