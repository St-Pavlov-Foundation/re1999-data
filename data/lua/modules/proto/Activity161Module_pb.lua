slot1 = require("protobuf.protobuf")

module("modules.proto.Activity161Module_pb", package.seeall)

slot2 = {
	ACT161GETINFOREQUEST_MSG = slot1.Descriptor(),
	ACT161GETINFOREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT161GAINMILESTONEREWARDREPLY_MSG = slot1.Descriptor(),
	ACT161GAINMILESTONEREWARDREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT161GAINMILESTONEREWARDREPLYREWARDIDSFIELD = slot1.FieldDescriptor(),
	ACT161GETINFOREPLY_MSG = slot1.Descriptor(),
	ACT161GETINFOREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT161GETINFOREPLYGRAFFITIINFOSFIELD = slot1.FieldDescriptor(),
	ACT161GETINFOREPLYGAINEDREWARDIDSFIELD = slot1.FieldDescriptor(),
	ACT161REFRESHELEMENTSREQUEST_MSG = slot1.Descriptor(),
	ACT161REFRESHELEMENTSREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT161GRAFFITIINFO_MSG = slot1.Descriptor(),
	ACT161GRAFFITIINFOIDFIELD = slot1.FieldDescriptor(),
	ACT161GRAFFITIINFOSTATEFIELD = slot1.FieldDescriptor(),
	ACT161GRAFFITIINFOMAINELEMENTCDBEGINTIMEFIELD = slot1.FieldDescriptor(),
	ACT161GAINMILESTONEREWARDREQUEST_MSG = slot1.Descriptor(),
	ACT161GAINMILESTONEREWARDREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT161REFRESHELEMENTSREPLY_MSG = slot1.Descriptor(),
	ACT161REFRESHELEMENTSREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT161CDBEGINPUSH_MSG = slot1.Descriptor(),
	ACT161CDBEGINPUSHACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT161CDBEGINPUSHGRAFFITIINFOSFIELD = slot1.FieldDescriptor()
}
slot2.ACT161GETINFOREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.ACT161GETINFOREQUESTACTIVITYIDFIELD.full_name = ".Act161GetInfoRequest.activityId"
slot2.ACT161GETINFOREQUESTACTIVITYIDFIELD.number = 1
slot2.ACT161GETINFOREQUESTACTIVITYIDFIELD.index = 0
slot2.ACT161GETINFOREQUESTACTIVITYIDFIELD.label = 1
slot2.ACT161GETINFOREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.ACT161GETINFOREQUESTACTIVITYIDFIELD.default_value = 0
slot2.ACT161GETINFOREQUESTACTIVITYIDFIELD.type = 5
slot2.ACT161GETINFOREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.ACT161GETINFOREQUEST_MSG.name = "Act161GetInfoRequest"
slot2.ACT161GETINFOREQUEST_MSG.full_name = ".Act161GetInfoRequest"
slot2.ACT161GETINFOREQUEST_MSG.nested_types = {}
slot2.ACT161GETINFOREQUEST_MSG.enum_types = {}
slot2.ACT161GETINFOREQUEST_MSG.fields = {
	slot2.ACT161GETINFOREQUESTACTIVITYIDFIELD
}
slot2.ACT161GETINFOREQUEST_MSG.is_extendable = false
slot2.ACT161GETINFOREQUEST_MSG.extensions = {}
slot2.ACT161GAINMILESTONEREWARDREPLYACTIVITYIDFIELD.name = "activityId"
slot2.ACT161GAINMILESTONEREWARDREPLYACTIVITYIDFIELD.full_name = ".Act161GainMilestoneRewardReply.activityId"
slot2.ACT161GAINMILESTONEREWARDREPLYACTIVITYIDFIELD.number = 1
slot2.ACT161GAINMILESTONEREWARDREPLYACTIVITYIDFIELD.index = 0
slot2.ACT161GAINMILESTONEREWARDREPLYACTIVITYIDFIELD.label = 1
slot2.ACT161GAINMILESTONEREWARDREPLYACTIVITYIDFIELD.has_default_value = false
slot2.ACT161GAINMILESTONEREWARDREPLYACTIVITYIDFIELD.default_value = 0
slot2.ACT161GAINMILESTONEREWARDREPLYACTIVITYIDFIELD.type = 5
slot2.ACT161GAINMILESTONEREWARDREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.ACT161GAINMILESTONEREWARDREPLYREWARDIDSFIELD.name = "rewardIds"
slot2.ACT161GAINMILESTONEREWARDREPLYREWARDIDSFIELD.full_name = ".Act161GainMilestoneRewardReply.rewardIds"
slot2.ACT161GAINMILESTONEREWARDREPLYREWARDIDSFIELD.number = 2
slot2.ACT161GAINMILESTONEREWARDREPLYREWARDIDSFIELD.index = 1
slot2.ACT161GAINMILESTONEREWARDREPLYREWARDIDSFIELD.label = 3
slot2.ACT161GAINMILESTONEREWARDREPLYREWARDIDSFIELD.has_default_value = false
slot2.ACT161GAINMILESTONEREWARDREPLYREWARDIDSFIELD.default_value = {}
slot2.ACT161GAINMILESTONEREWARDREPLYREWARDIDSFIELD.type = 5
slot2.ACT161GAINMILESTONEREWARDREPLYREWARDIDSFIELD.cpp_type = 1
slot2.ACT161GAINMILESTONEREWARDREPLY_MSG.name = "Act161GainMilestoneRewardReply"
slot2.ACT161GAINMILESTONEREWARDREPLY_MSG.full_name = ".Act161GainMilestoneRewardReply"
slot2.ACT161GAINMILESTONEREWARDREPLY_MSG.nested_types = {}
slot2.ACT161GAINMILESTONEREWARDREPLY_MSG.enum_types = {}
slot2.ACT161GAINMILESTONEREWARDREPLY_MSG.fields = {
	slot2.ACT161GAINMILESTONEREWARDREPLYACTIVITYIDFIELD,
	slot2.ACT161GAINMILESTONEREWARDREPLYREWARDIDSFIELD
}
slot2.ACT161GAINMILESTONEREWARDREPLY_MSG.is_extendable = false
slot2.ACT161GAINMILESTONEREWARDREPLY_MSG.extensions = {}
slot2.ACT161GETINFOREPLYACTIVITYIDFIELD.name = "activityId"
slot2.ACT161GETINFOREPLYACTIVITYIDFIELD.full_name = ".Act161GetInfoReply.activityId"
slot2.ACT161GETINFOREPLYACTIVITYIDFIELD.number = 1
slot2.ACT161GETINFOREPLYACTIVITYIDFIELD.index = 0
slot2.ACT161GETINFOREPLYACTIVITYIDFIELD.label = 1
slot2.ACT161GETINFOREPLYACTIVITYIDFIELD.has_default_value = false
slot2.ACT161GETINFOREPLYACTIVITYIDFIELD.default_value = 0
slot2.ACT161GETINFOREPLYACTIVITYIDFIELD.type = 5
slot2.ACT161GETINFOREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.ACT161GETINFOREPLYGRAFFITIINFOSFIELD.name = "graffitiInfos"
slot2.ACT161GETINFOREPLYGRAFFITIINFOSFIELD.full_name = ".Act161GetInfoReply.graffitiInfos"
slot2.ACT161GETINFOREPLYGRAFFITIINFOSFIELD.number = 2
slot2.ACT161GETINFOREPLYGRAFFITIINFOSFIELD.index = 1
slot2.ACT161GETINFOREPLYGRAFFITIINFOSFIELD.label = 3
slot2.ACT161GETINFOREPLYGRAFFITIINFOSFIELD.has_default_value = false
slot2.ACT161GETINFOREPLYGRAFFITIINFOSFIELD.default_value = {}
slot2.ACT161GETINFOREPLYGRAFFITIINFOSFIELD.message_type = slot2.ACT161GRAFFITIINFO_MSG
slot2.ACT161GETINFOREPLYGRAFFITIINFOSFIELD.type = 11
slot2.ACT161GETINFOREPLYGRAFFITIINFOSFIELD.cpp_type = 10
slot2.ACT161GETINFOREPLYGAINEDREWARDIDSFIELD.name = "gainedRewardIds"
slot2.ACT161GETINFOREPLYGAINEDREWARDIDSFIELD.full_name = ".Act161GetInfoReply.gainedRewardIds"
slot2.ACT161GETINFOREPLYGAINEDREWARDIDSFIELD.number = 3
slot2.ACT161GETINFOREPLYGAINEDREWARDIDSFIELD.index = 2
slot2.ACT161GETINFOREPLYGAINEDREWARDIDSFIELD.label = 3
slot2.ACT161GETINFOREPLYGAINEDREWARDIDSFIELD.has_default_value = false
slot2.ACT161GETINFOREPLYGAINEDREWARDIDSFIELD.default_value = {}
slot2.ACT161GETINFOREPLYGAINEDREWARDIDSFIELD.type = 5
slot2.ACT161GETINFOREPLYGAINEDREWARDIDSFIELD.cpp_type = 1
slot2.ACT161GETINFOREPLY_MSG.name = "Act161GetInfoReply"
slot2.ACT161GETINFOREPLY_MSG.full_name = ".Act161GetInfoReply"
slot2.ACT161GETINFOREPLY_MSG.nested_types = {}
slot2.ACT161GETINFOREPLY_MSG.enum_types = {}
slot2.ACT161GETINFOREPLY_MSG.fields = {
	slot2.ACT161GETINFOREPLYACTIVITYIDFIELD,
	slot2.ACT161GETINFOREPLYGRAFFITIINFOSFIELD,
	slot2.ACT161GETINFOREPLYGAINEDREWARDIDSFIELD
}
slot2.ACT161GETINFOREPLY_MSG.is_extendable = false
slot2.ACT161GETINFOREPLY_MSG.extensions = {}
slot2.ACT161REFRESHELEMENTSREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.ACT161REFRESHELEMENTSREQUESTACTIVITYIDFIELD.full_name = ".Act161RefreshElementsRequest.activityId"
slot2.ACT161REFRESHELEMENTSREQUESTACTIVITYIDFIELD.number = 1
slot2.ACT161REFRESHELEMENTSREQUESTACTIVITYIDFIELD.index = 0
slot2.ACT161REFRESHELEMENTSREQUESTACTIVITYIDFIELD.label = 1
slot2.ACT161REFRESHELEMENTSREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.ACT161REFRESHELEMENTSREQUESTACTIVITYIDFIELD.default_value = 0
slot2.ACT161REFRESHELEMENTSREQUESTACTIVITYIDFIELD.type = 5
slot2.ACT161REFRESHELEMENTSREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.ACT161REFRESHELEMENTSREQUEST_MSG.name = "Act161RefreshElementsRequest"
slot2.ACT161REFRESHELEMENTSREQUEST_MSG.full_name = ".Act161RefreshElementsRequest"
slot2.ACT161REFRESHELEMENTSREQUEST_MSG.nested_types = {}
slot2.ACT161REFRESHELEMENTSREQUEST_MSG.enum_types = {}
slot2.ACT161REFRESHELEMENTSREQUEST_MSG.fields = {
	slot2.ACT161REFRESHELEMENTSREQUESTACTIVITYIDFIELD
}
slot2.ACT161REFRESHELEMENTSREQUEST_MSG.is_extendable = false
slot2.ACT161REFRESHELEMENTSREQUEST_MSG.extensions = {}
slot2.ACT161GRAFFITIINFOIDFIELD.name = "id"
slot2.ACT161GRAFFITIINFOIDFIELD.full_name = ".Act161GraffitiInfo.id"
slot2.ACT161GRAFFITIINFOIDFIELD.number = 1
slot2.ACT161GRAFFITIINFOIDFIELD.index = 0
slot2.ACT161GRAFFITIINFOIDFIELD.label = 1
slot2.ACT161GRAFFITIINFOIDFIELD.has_default_value = false
slot2.ACT161GRAFFITIINFOIDFIELD.default_value = 0
slot2.ACT161GRAFFITIINFOIDFIELD.type = 5
slot2.ACT161GRAFFITIINFOIDFIELD.cpp_type = 1
slot2.ACT161GRAFFITIINFOSTATEFIELD.name = "state"
slot2.ACT161GRAFFITIINFOSTATEFIELD.full_name = ".Act161GraffitiInfo.state"
slot2.ACT161GRAFFITIINFOSTATEFIELD.number = 2
slot2.ACT161GRAFFITIINFOSTATEFIELD.index = 1
slot2.ACT161GRAFFITIINFOSTATEFIELD.label = 1
slot2.ACT161GRAFFITIINFOSTATEFIELD.has_default_value = false
slot2.ACT161GRAFFITIINFOSTATEFIELD.default_value = 0
slot2.ACT161GRAFFITIINFOSTATEFIELD.type = 5
slot2.ACT161GRAFFITIINFOSTATEFIELD.cpp_type = 1
slot2.ACT161GRAFFITIINFOMAINELEMENTCDBEGINTIMEFIELD.name = "mainElementCdBeginTime"
slot2.ACT161GRAFFITIINFOMAINELEMENTCDBEGINTIMEFIELD.full_name = ".Act161GraffitiInfo.mainElementCdBeginTime"
slot2.ACT161GRAFFITIINFOMAINELEMENTCDBEGINTIMEFIELD.number = 3
slot2.ACT161GRAFFITIINFOMAINELEMENTCDBEGINTIMEFIELD.index = 2
slot2.ACT161GRAFFITIINFOMAINELEMENTCDBEGINTIMEFIELD.label = 1
slot2.ACT161GRAFFITIINFOMAINELEMENTCDBEGINTIMEFIELD.has_default_value = false
slot2.ACT161GRAFFITIINFOMAINELEMENTCDBEGINTIMEFIELD.default_value = 0
slot2.ACT161GRAFFITIINFOMAINELEMENTCDBEGINTIMEFIELD.type = 4
slot2.ACT161GRAFFITIINFOMAINELEMENTCDBEGINTIMEFIELD.cpp_type = 4
slot2.ACT161GRAFFITIINFO_MSG.name = "Act161GraffitiInfo"
slot2.ACT161GRAFFITIINFO_MSG.full_name = ".Act161GraffitiInfo"
slot2.ACT161GRAFFITIINFO_MSG.nested_types = {}
slot2.ACT161GRAFFITIINFO_MSG.enum_types = {}
slot2.ACT161GRAFFITIINFO_MSG.fields = {
	slot2.ACT161GRAFFITIINFOIDFIELD,
	slot2.ACT161GRAFFITIINFOSTATEFIELD,
	slot2.ACT161GRAFFITIINFOMAINELEMENTCDBEGINTIMEFIELD
}
slot2.ACT161GRAFFITIINFO_MSG.is_extendable = false
slot2.ACT161GRAFFITIINFO_MSG.extensions = {}
slot2.ACT161GAINMILESTONEREWARDREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.ACT161GAINMILESTONEREWARDREQUESTACTIVITYIDFIELD.full_name = ".Act161GainMilestoneRewardRequest.activityId"
slot2.ACT161GAINMILESTONEREWARDREQUESTACTIVITYIDFIELD.number = 1
slot2.ACT161GAINMILESTONEREWARDREQUESTACTIVITYIDFIELD.index = 0
slot2.ACT161GAINMILESTONEREWARDREQUESTACTIVITYIDFIELD.label = 1
slot2.ACT161GAINMILESTONEREWARDREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.ACT161GAINMILESTONEREWARDREQUESTACTIVITYIDFIELD.default_value = 0
slot2.ACT161GAINMILESTONEREWARDREQUESTACTIVITYIDFIELD.type = 5
slot2.ACT161GAINMILESTONEREWARDREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.ACT161GAINMILESTONEREWARDREQUEST_MSG.name = "Act161GainMilestoneRewardRequest"
slot2.ACT161GAINMILESTONEREWARDREQUEST_MSG.full_name = ".Act161GainMilestoneRewardRequest"
slot2.ACT161GAINMILESTONEREWARDREQUEST_MSG.nested_types = {}
slot2.ACT161GAINMILESTONEREWARDREQUEST_MSG.enum_types = {}
slot2.ACT161GAINMILESTONEREWARDREQUEST_MSG.fields = {
	slot2.ACT161GAINMILESTONEREWARDREQUESTACTIVITYIDFIELD
}
slot2.ACT161GAINMILESTONEREWARDREQUEST_MSG.is_extendable = false
slot2.ACT161GAINMILESTONEREWARDREQUEST_MSG.extensions = {}
slot2.ACT161REFRESHELEMENTSREPLYACTIVITYIDFIELD.name = "activityId"
slot2.ACT161REFRESHELEMENTSREPLYACTIVITYIDFIELD.full_name = ".Act161RefreshElementsReply.activityId"
slot2.ACT161REFRESHELEMENTSREPLYACTIVITYIDFIELD.number = 1
slot2.ACT161REFRESHELEMENTSREPLYACTIVITYIDFIELD.index = 0
slot2.ACT161REFRESHELEMENTSREPLYACTIVITYIDFIELD.label = 1
slot2.ACT161REFRESHELEMENTSREPLYACTIVITYIDFIELD.has_default_value = false
slot2.ACT161REFRESHELEMENTSREPLYACTIVITYIDFIELD.default_value = 0
slot2.ACT161REFRESHELEMENTSREPLYACTIVITYIDFIELD.type = 5
slot2.ACT161REFRESHELEMENTSREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.ACT161REFRESHELEMENTSREPLY_MSG.name = "Act161RefreshElementsReply"
slot2.ACT161REFRESHELEMENTSREPLY_MSG.full_name = ".Act161RefreshElementsReply"
slot2.ACT161REFRESHELEMENTSREPLY_MSG.nested_types = {}
slot2.ACT161REFRESHELEMENTSREPLY_MSG.enum_types = {}
slot2.ACT161REFRESHELEMENTSREPLY_MSG.fields = {
	slot2.ACT161REFRESHELEMENTSREPLYACTIVITYIDFIELD
}
slot2.ACT161REFRESHELEMENTSREPLY_MSG.is_extendable = false
slot2.ACT161REFRESHELEMENTSREPLY_MSG.extensions = {}
slot2.ACT161CDBEGINPUSHACTIVITYIDFIELD.name = "activityId"
slot2.ACT161CDBEGINPUSHACTIVITYIDFIELD.full_name = ".Act161CdBeginPush.activityId"
slot2.ACT161CDBEGINPUSHACTIVITYIDFIELD.number = 1
slot2.ACT161CDBEGINPUSHACTIVITYIDFIELD.index = 0
slot2.ACT161CDBEGINPUSHACTIVITYIDFIELD.label = 1
slot2.ACT161CDBEGINPUSHACTIVITYIDFIELD.has_default_value = false
slot2.ACT161CDBEGINPUSHACTIVITYIDFIELD.default_value = 0
slot2.ACT161CDBEGINPUSHACTIVITYIDFIELD.type = 5
slot2.ACT161CDBEGINPUSHACTIVITYIDFIELD.cpp_type = 1
slot2.ACT161CDBEGINPUSHGRAFFITIINFOSFIELD.name = "graffitiInfos"
slot2.ACT161CDBEGINPUSHGRAFFITIINFOSFIELD.full_name = ".Act161CdBeginPush.graffitiInfos"
slot2.ACT161CDBEGINPUSHGRAFFITIINFOSFIELD.number = 2
slot2.ACT161CDBEGINPUSHGRAFFITIINFOSFIELD.index = 1
slot2.ACT161CDBEGINPUSHGRAFFITIINFOSFIELD.label = 3
slot2.ACT161CDBEGINPUSHGRAFFITIINFOSFIELD.has_default_value = false
slot2.ACT161CDBEGINPUSHGRAFFITIINFOSFIELD.default_value = {}
slot2.ACT161CDBEGINPUSHGRAFFITIINFOSFIELD.message_type = slot2.ACT161GRAFFITIINFO_MSG
slot2.ACT161CDBEGINPUSHGRAFFITIINFOSFIELD.type = 11
slot2.ACT161CDBEGINPUSHGRAFFITIINFOSFIELD.cpp_type = 10
slot2.ACT161CDBEGINPUSH_MSG.name = "Act161CdBeginPush"
slot2.ACT161CDBEGINPUSH_MSG.full_name = ".Act161CdBeginPush"
slot2.ACT161CDBEGINPUSH_MSG.nested_types = {}
slot2.ACT161CDBEGINPUSH_MSG.enum_types = {}
slot2.ACT161CDBEGINPUSH_MSG.fields = {
	slot2.ACT161CDBEGINPUSHACTIVITYIDFIELD,
	slot2.ACT161CDBEGINPUSHGRAFFITIINFOSFIELD
}
slot2.ACT161CDBEGINPUSH_MSG.is_extendable = false
slot2.ACT161CDBEGINPUSH_MSG.extensions = {}
slot2.Act161CdBeginPush = slot1.Message(slot2.ACT161CDBEGINPUSH_MSG)
slot2.Act161GainMilestoneRewardReply = slot1.Message(slot2.ACT161GAINMILESTONEREWARDREPLY_MSG)
slot2.Act161GainMilestoneRewardRequest = slot1.Message(slot2.ACT161GAINMILESTONEREWARDREQUEST_MSG)
slot2.Act161GetInfoReply = slot1.Message(slot2.ACT161GETINFOREPLY_MSG)
slot2.Act161GetInfoRequest = slot1.Message(slot2.ACT161GETINFOREQUEST_MSG)
slot2.Act161GraffitiInfo = slot1.Message(slot2.ACT161GRAFFITIINFO_MSG)
slot2.Act161RefreshElementsReply = slot1.Message(slot2.ACT161REFRESHELEMENTSREPLY_MSG)
slot2.Act161RefreshElementsRequest = slot1.Message(slot2.ACT161REFRESHELEMENTSREQUEST_MSG)

return slot2
