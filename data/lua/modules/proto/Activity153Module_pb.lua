slot1 = require("protobuf.protobuf")

module("modules.proto.Activity153Module_pb", package.seeall)

slot2 = {
	GET153INFOSREQUEST_MSG = slot1.Descriptor(),
	GET153INFOSREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor(),
	GET153INFOSREPLY_MSG = slot1.Descriptor(),
	GET153INFOSREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	GET153INFOSREPLYTOTALCOUNTFIELD = slot1.FieldDescriptor(),
	GET153INFOSREPLYDAILYCOUNTFIELD = slot1.FieldDescriptor(),
	ACT153COUNTCHANGEPUSH_MSG = slot1.Descriptor(),
	ACT153COUNTCHANGEPUSHACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT153COUNTCHANGEPUSHTOTALCOUNTFIELD = slot1.FieldDescriptor(),
	ACT153COUNTCHANGEPUSHDAILYCOUNTFIELD = slot1.FieldDescriptor()
}
slot2.GET153INFOSREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.GET153INFOSREQUESTACTIVITYIDFIELD.full_name = ".Get153InfosRequest.activityId"
slot2.GET153INFOSREQUESTACTIVITYIDFIELD.number = 1
slot2.GET153INFOSREQUESTACTIVITYIDFIELD.index = 0
slot2.GET153INFOSREQUESTACTIVITYIDFIELD.label = 1
slot2.GET153INFOSREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.GET153INFOSREQUESTACTIVITYIDFIELD.default_value = 0
slot2.GET153INFOSREQUESTACTIVITYIDFIELD.type = 5
slot2.GET153INFOSREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.GET153INFOSREQUEST_MSG.name = "Get153InfosRequest"
slot2.GET153INFOSREQUEST_MSG.full_name = ".Get153InfosRequest"
slot2.GET153INFOSREQUEST_MSG.nested_types = {}
slot2.GET153INFOSREQUEST_MSG.enum_types = {}
slot2.GET153INFOSREQUEST_MSG.fields = {
	slot2.GET153INFOSREQUESTACTIVITYIDFIELD
}
slot2.GET153INFOSREQUEST_MSG.is_extendable = false
slot2.GET153INFOSREQUEST_MSG.extensions = {}
slot2.GET153INFOSREPLYACTIVITYIDFIELD.name = "activityId"
slot2.GET153INFOSREPLYACTIVITYIDFIELD.full_name = ".Get153InfosReply.activityId"
slot2.GET153INFOSREPLYACTIVITYIDFIELD.number = 1
slot2.GET153INFOSREPLYACTIVITYIDFIELD.index = 0
slot2.GET153INFOSREPLYACTIVITYIDFIELD.label = 1
slot2.GET153INFOSREPLYACTIVITYIDFIELD.has_default_value = false
slot2.GET153INFOSREPLYACTIVITYIDFIELD.default_value = 0
slot2.GET153INFOSREPLYACTIVITYIDFIELD.type = 5
slot2.GET153INFOSREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.GET153INFOSREPLYTOTALCOUNTFIELD.name = "totalCount"
slot2.GET153INFOSREPLYTOTALCOUNTFIELD.full_name = ".Get153InfosReply.totalCount"
slot2.GET153INFOSREPLYTOTALCOUNTFIELD.number = 2
slot2.GET153INFOSREPLYTOTALCOUNTFIELD.index = 1
slot2.GET153INFOSREPLYTOTALCOUNTFIELD.label = 1
slot2.GET153INFOSREPLYTOTALCOUNTFIELD.has_default_value = false
slot2.GET153INFOSREPLYTOTALCOUNTFIELD.default_value = 0
slot2.GET153INFOSREPLYTOTALCOUNTFIELD.type = 13
slot2.GET153INFOSREPLYTOTALCOUNTFIELD.cpp_type = 3
slot2.GET153INFOSREPLYDAILYCOUNTFIELD.name = "dailyCount"
slot2.GET153INFOSREPLYDAILYCOUNTFIELD.full_name = ".Get153InfosReply.dailyCount"
slot2.GET153INFOSREPLYDAILYCOUNTFIELD.number = 3
slot2.GET153INFOSREPLYDAILYCOUNTFIELD.index = 2
slot2.GET153INFOSREPLYDAILYCOUNTFIELD.label = 1
slot2.GET153INFOSREPLYDAILYCOUNTFIELD.has_default_value = false
slot2.GET153INFOSREPLYDAILYCOUNTFIELD.default_value = 0
slot2.GET153INFOSREPLYDAILYCOUNTFIELD.type = 13
slot2.GET153INFOSREPLYDAILYCOUNTFIELD.cpp_type = 3
slot2.GET153INFOSREPLY_MSG.name = "Get153InfosReply"
slot2.GET153INFOSREPLY_MSG.full_name = ".Get153InfosReply"
slot2.GET153INFOSREPLY_MSG.nested_types = {}
slot2.GET153INFOSREPLY_MSG.enum_types = {}
slot2.GET153INFOSREPLY_MSG.fields = {
	slot2.GET153INFOSREPLYACTIVITYIDFIELD,
	slot2.GET153INFOSREPLYTOTALCOUNTFIELD,
	slot2.GET153INFOSREPLYDAILYCOUNTFIELD
}
slot2.GET153INFOSREPLY_MSG.is_extendable = false
slot2.GET153INFOSREPLY_MSG.extensions = {}
slot2.ACT153COUNTCHANGEPUSHACTIVITYIDFIELD.name = "activityId"
slot2.ACT153COUNTCHANGEPUSHACTIVITYIDFIELD.full_name = ".Act153CountChangePush.activityId"
slot2.ACT153COUNTCHANGEPUSHACTIVITYIDFIELD.number = 1
slot2.ACT153COUNTCHANGEPUSHACTIVITYIDFIELD.index = 0
slot2.ACT153COUNTCHANGEPUSHACTIVITYIDFIELD.label = 1
slot2.ACT153COUNTCHANGEPUSHACTIVITYIDFIELD.has_default_value = false
slot2.ACT153COUNTCHANGEPUSHACTIVITYIDFIELD.default_value = 0
slot2.ACT153COUNTCHANGEPUSHACTIVITYIDFIELD.type = 5
slot2.ACT153COUNTCHANGEPUSHACTIVITYIDFIELD.cpp_type = 1
slot2.ACT153COUNTCHANGEPUSHTOTALCOUNTFIELD.name = "totalCount"
slot2.ACT153COUNTCHANGEPUSHTOTALCOUNTFIELD.full_name = ".Act153CountChangePush.totalCount"
slot2.ACT153COUNTCHANGEPUSHTOTALCOUNTFIELD.number = 2
slot2.ACT153COUNTCHANGEPUSHTOTALCOUNTFIELD.index = 1
slot2.ACT153COUNTCHANGEPUSHTOTALCOUNTFIELD.label = 1
slot2.ACT153COUNTCHANGEPUSHTOTALCOUNTFIELD.has_default_value = false
slot2.ACT153COUNTCHANGEPUSHTOTALCOUNTFIELD.default_value = 0
slot2.ACT153COUNTCHANGEPUSHTOTALCOUNTFIELD.type = 13
slot2.ACT153COUNTCHANGEPUSHTOTALCOUNTFIELD.cpp_type = 3
slot2.ACT153COUNTCHANGEPUSHDAILYCOUNTFIELD.name = "dailyCount"
slot2.ACT153COUNTCHANGEPUSHDAILYCOUNTFIELD.full_name = ".Act153CountChangePush.dailyCount"
slot2.ACT153COUNTCHANGEPUSHDAILYCOUNTFIELD.number = 3
slot2.ACT153COUNTCHANGEPUSHDAILYCOUNTFIELD.index = 2
slot2.ACT153COUNTCHANGEPUSHDAILYCOUNTFIELD.label = 1
slot2.ACT153COUNTCHANGEPUSHDAILYCOUNTFIELD.has_default_value = false
slot2.ACT153COUNTCHANGEPUSHDAILYCOUNTFIELD.default_value = 0
slot2.ACT153COUNTCHANGEPUSHDAILYCOUNTFIELD.type = 13
slot2.ACT153COUNTCHANGEPUSHDAILYCOUNTFIELD.cpp_type = 3
slot2.ACT153COUNTCHANGEPUSH_MSG.name = "Act153CountChangePush"
slot2.ACT153COUNTCHANGEPUSH_MSG.full_name = ".Act153CountChangePush"
slot2.ACT153COUNTCHANGEPUSH_MSG.nested_types = {}
slot2.ACT153COUNTCHANGEPUSH_MSG.enum_types = {}
slot2.ACT153COUNTCHANGEPUSH_MSG.fields = {
	slot2.ACT153COUNTCHANGEPUSHACTIVITYIDFIELD,
	slot2.ACT153COUNTCHANGEPUSHTOTALCOUNTFIELD,
	slot2.ACT153COUNTCHANGEPUSHDAILYCOUNTFIELD
}
slot2.ACT153COUNTCHANGEPUSH_MSG.is_extendable = false
slot2.ACT153COUNTCHANGEPUSH_MSG.extensions = {}
slot2.Act153CountChangePush = slot1.Message(slot2.ACT153COUNTCHANGEPUSH_MSG)
slot2.Get153InfosReply = slot1.Message(slot2.GET153INFOSREPLY_MSG)
slot2.Get153InfosRequest = slot1.Message(slot2.GET153INFOSREQUEST_MSG)

return slot2
