slot0 = require
slot1 = slot0("protobuf.protobuf")

module("modules.proto.Activity133Module_pb", package.seeall)

slot2 = {
	TASKMODULE_PB = slot0("modules.proto.TaskModule_pb"),
	GET133INFOSREPLY_MSG = slot1.Descriptor(),
	GET133INFOSREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	GET133INFOSREPLYHASGETBONUSIDSFIELD = slot1.FieldDescriptor(),
	GET133INFOSREPLYTASKSFIELD = slot1.FieldDescriptor(),
	ACT133BONUSREQUEST_MSG = slot1.Descriptor(),
	ACT133BONUSREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT133BONUSREQUESTIDFIELD = slot1.FieldDescriptor(),
	ACT133BONUSREPLY_MSG = slot1.Descriptor(),
	ACT133BONUSREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT133BONUSREPLYIDFIELD = slot1.FieldDescriptor(),
	GET133INFOSREQUEST_MSG = slot1.Descriptor(),
	GET133INFOSREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor()
}
slot2.GET133INFOSREPLYACTIVITYIDFIELD.name = "activityId"
slot2.GET133INFOSREPLYACTIVITYIDFIELD.full_name = ".Get133InfosReply.activityId"
slot2.GET133INFOSREPLYACTIVITYIDFIELD.number = 1
slot2.GET133INFOSREPLYACTIVITYIDFIELD.index = 0
slot2.GET133INFOSREPLYACTIVITYIDFIELD.label = 1
slot2.GET133INFOSREPLYACTIVITYIDFIELD.has_default_value = false
slot2.GET133INFOSREPLYACTIVITYIDFIELD.default_value = 0
slot2.GET133INFOSREPLYACTIVITYIDFIELD.type = 5
slot2.GET133INFOSREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.GET133INFOSREPLYHASGETBONUSIDSFIELD.name = "hasGetBonusIds"
slot2.GET133INFOSREPLYHASGETBONUSIDSFIELD.full_name = ".Get133InfosReply.hasGetBonusIds"
slot2.GET133INFOSREPLYHASGETBONUSIDSFIELD.number = 2
slot2.GET133INFOSREPLYHASGETBONUSIDSFIELD.index = 1
slot2.GET133INFOSREPLYHASGETBONUSIDSFIELD.label = 3
slot2.GET133INFOSREPLYHASGETBONUSIDSFIELD.has_default_value = false
slot2.GET133INFOSREPLYHASGETBONUSIDSFIELD.default_value = {}
slot2.GET133INFOSREPLYHASGETBONUSIDSFIELD.type = 5
slot2.GET133INFOSREPLYHASGETBONUSIDSFIELD.cpp_type = 1
slot2.GET133INFOSREPLYTASKSFIELD.name = "tasks"
slot2.GET133INFOSREPLYTASKSFIELD.full_name = ".Get133InfosReply.tasks"
slot2.GET133INFOSREPLYTASKSFIELD.number = 3
slot2.GET133INFOSREPLYTASKSFIELD.index = 2
slot2.GET133INFOSREPLYTASKSFIELD.label = 3
slot2.GET133INFOSREPLYTASKSFIELD.has_default_value = false
slot2.GET133INFOSREPLYTASKSFIELD.default_value = {}
slot2.GET133INFOSREPLYTASKSFIELD.message_type = slot2.TASKMODULE_PB.TASK_MSG
slot2.GET133INFOSREPLYTASKSFIELD.type = 11
slot2.GET133INFOSREPLYTASKSFIELD.cpp_type = 10
slot2.GET133INFOSREPLY_MSG.name = "Get133InfosReply"
slot2.GET133INFOSREPLY_MSG.full_name = ".Get133InfosReply"
slot2.GET133INFOSREPLY_MSG.nested_types = {}
slot2.GET133INFOSREPLY_MSG.enum_types = {}
slot2.GET133INFOSREPLY_MSG.fields = {
	slot2.GET133INFOSREPLYACTIVITYIDFIELD,
	slot2.GET133INFOSREPLYHASGETBONUSIDSFIELD,
	slot2.GET133INFOSREPLYTASKSFIELD
}
slot2.GET133INFOSREPLY_MSG.is_extendable = false
slot2.GET133INFOSREPLY_MSG.extensions = {}
slot2.ACT133BONUSREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.ACT133BONUSREQUESTACTIVITYIDFIELD.full_name = ".Act133BonusRequest.activityId"
slot2.ACT133BONUSREQUESTACTIVITYIDFIELD.number = 1
slot2.ACT133BONUSREQUESTACTIVITYIDFIELD.index = 0
slot2.ACT133BONUSREQUESTACTIVITYIDFIELD.label = 1
slot2.ACT133BONUSREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.ACT133BONUSREQUESTACTIVITYIDFIELD.default_value = 0
slot2.ACT133BONUSREQUESTACTIVITYIDFIELD.type = 5
slot2.ACT133BONUSREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.ACT133BONUSREQUESTIDFIELD.name = "id"
slot2.ACT133BONUSREQUESTIDFIELD.full_name = ".Act133BonusRequest.id"
slot2.ACT133BONUSREQUESTIDFIELD.number = 2
slot2.ACT133BONUSREQUESTIDFIELD.index = 1
slot2.ACT133BONUSREQUESTIDFIELD.label = 1
slot2.ACT133BONUSREQUESTIDFIELD.has_default_value = false
slot2.ACT133BONUSREQUESTIDFIELD.default_value = 0
slot2.ACT133BONUSREQUESTIDFIELD.type = 5
slot2.ACT133BONUSREQUESTIDFIELD.cpp_type = 1
slot2.ACT133BONUSREQUEST_MSG.name = "Act133BonusRequest"
slot2.ACT133BONUSREQUEST_MSG.full_name = ".Act133BonusRequest"
slot2.ACT133BONUSREQUEST_MSG.nested_types = {}
slot2.ACT133BONUSREQUEST_MSG.enum_types = {}
slot2.ACT133BONUSREQUEST_MSG.fields = {
	slot2.ACT133BONUSREQUESTACTIVITYIDFIELD,
	slot2.ACT133BONUSREQUESTIDFIELD
}
slot2.ACT133BONUSREQUEST_MSG.is_extendable = false
slot2.ACT133BONUSREQUEST_MSG.extensions = {}
slot2.ACT133BONUSREPLYACTIVITYIDFIELD.name = "activityId"
slot2.ACT133BONUSREPLYACTIVITYIDFIELD.full_name = ".Act133BonusReply.activityId"
slot2.ACT133BONUSREPLYACTIVITYIDFIELD.number = 1
slot2.ACT133BONUSREPLYACTIVITYIDFIELD.index = 0
slot2.ACT133BONUSREPLYACTIVITYIDFIELD.label = 1
slot2.ACT133BONUSREPLYACTIVITYIDFIELD.has_default_value = false
slot2.ACT133BONUSREPLYACTIVITYIDFIELD.default_value = 0
slot2.ACT133BONUSREPLYACTIVITYIDFIELD.type = 5
slot2.ACT133BONUSREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.ACT133BONUSREPLYIDFIELD.name = "id"
slot2.ACT133BONUSREPLYIDFIELD.full_name = ".Act133BonusReply.id"
slot2.ACT133BONUSREPLYIDFIELD.number = 2
slot2.ACT133BONUSREPLYIDFIELD.index = 1
slot2.ACT133BONUSREPLYIDFIELD.label = 1
slot2.ACT133BONUSREPLYIDFIELD.has_default_value = false
slot2.ACT133BONUSREPLYIDFIELD.default_value = 0
slot2.ACT133BONUSREPLYIDFIELD.type = 5
slot2.ACT133BONUSREPLYIDFIELD.cpp_type = 1
slot2.ACT133BONUSREPLY_MSG.name = "Act133BonusReply"
slot2.ACT133BONUSREPLY_MSG.full_name = ".Act133BonusReply"
slot2.ACT133BONUSREPLY_MSG.nested_types = {}
slot2.ACT133BONUSREPLY_MSG.enum_types = {}
slot2.ACT133BONUSREPLY_MSG.fields = {
	slot2.ACT133BONUSREPLYACTIVITYIDFIELD,
	slot2.ACT133BONUSREPLYIDFIELD
}
slot2.ACT133BONUSREPLY_MSG.is_extendable = false
slot2.ACT133BONUSREPLY_MSG.extensions = {}
slot2.GET133INFOSREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.GET133INFOSREQUESTACTIVITYIDFIELD.full_name = ".Get133InfosRequest.activityId"
slot2.GET133INFOSREQUESTACTIVITYIDFIELD.number = 1
slot2.GET133INFOSREQUESTACTIVITYIDFIELD.index = 0
slot2.GET133INFOSREQUESTACTIVITYIDFIELD.label = 1
slot2.GET133INFOSREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.GET133INFOSREQUESTACTIVITYIDFIELD.default_value = 0
slot2.GET133INFOSREQUESTACTIVITYIDFIELD.type = 5
slot2.GET133INFOSREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.GET133INFOSREQUEST_MSG.name = "Get133InfosRequest"
slot2.GET133INFOSREQUEST_MSG.full_name = ".Get133InfosRequest"
slot2.GET133INFOSREQUEST_MSG.nested_types = {}
slot2.GET133INFOSREQUEST_MSG.enum_types = {}
slot2.GET133INFOSREQUEST_MSG.fields = {
	slot2.GET133INFOSREQUESTACTIVITYIDFIELD
}
slot2.GET133INFOSREQUEST_MSG.is_extendable = false
slot2.GET133INFOSREQUEST_MSG.extensions = {}
slot2.Act133BonusReply = slot1.Message(slot2.ACT133BONUSREPLY_MSG)
slot2.Act133BonusRequest = slot1.Message(slot2.ACT133BONUSREQUEST_MSG)
slot2.Get133InfosReply = slot1.Message(slot2.GET133INFOSREPLY_MSG)
slot2.Get133InfosRequest = slot1.Message(slot2.GET133INFOSREQUEST_MSG)

return slot2
