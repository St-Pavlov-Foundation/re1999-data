﻿local var_0_0 = require("protobuf.protobuf")

module("modules.proto.RedDotModule_pb", package.seeall)

local var_0_1 = {
	REDDOTINFO_MSG = var_0_0.Descriptor(),
	REDDOTINFOIDFIELD = var_0_0.FieldDescriptor(),
	REDDOTINFOVALUEFIELD = var_0_0.FieldDescriptor(),
	REDDOTINFOTIMEFIELD = var_0_0.FieldDescriptor(),
	REDDOTINFOEXTFIELD = var_0_0.FieldDescriptor(),
	SHOWREDDOTREPLY_MSG = var_0_0.Descriptor(),
	GETREDDOTINFOSREQUEST_MSG = var_0_0.Descriptor(),
	GETREDDOTINFOSREQUESTIDSFIELD = var_0_0.FieldDescriptor(),
	SHOWREDDOTREQUEST_MSG = var_0_0.Descriptor(),
	SHOWREDDOTREQUESTDEFINEIDFIELD = var_0_0.FieldDescriptor(),
	SHOWREDDOTREQUESTISVISIBLEFIELD = var_0_0.FieldDescriptor(),
	GETREDDOTINFOSREPLY_MSG = var_0_0.Descriptor(),
	GETREDDOTINFOSREPLYREDDOTINFOSFIELD = var_0_0.FieldDescriptor(),
	REDDOTGROUP_MSG = var_0_0.Descriptor(),
	REDDOTGROUPDEFINEIDFIELD = var_0_0.FieldDescriptor(),
	REDDOTGROUPINFOSFIELD = var_0_0.FieldDescriptor(),
	REDDOTGROUPREPLACEALLFIELD = var_0_0.FieldDescriptor(),
	UPDATEREDDOTPUSH_MSG = var_0_0.Descriptor(),
	UPDATEREDDOTPUSHREDDOTINFOSFIELD = var_0_0.FieldDescriptor(),
	UPDATEREDDOTPUSHREPLACEALLFIELD = var_0_0.FieldDescriptor()
}

var_0_1.REDDOTINFOIDFIELD.name = "id"
var_0_1.REDDOTINFOIDFIELD.full_name = ".RedDotInfo.id"
var_0_1.REDDOTINFOIDFIELD.number = 1
var_0_1.REDDOTINFOIDFIELD.index = 0
var_0_1.REDDOTINFOIDFIELD.label = 2
var_0_1.REDDOTINFOIDFIELD.has_default_value = false
var_0_1.REDDOTINFOIDFIELD.default_value = 0
var_0_1.REDDOTINFOIDFIELD.type = 3
var_0_1.REDDOTINFOIDFIELD.cpp_type = 2
var_0_1.REDDOTINFOVALUEFIELD.name = "value"
var_0_1.REDDOTINFOVALUEFIELD.full_name = ".RedDotInfo.value"
var_0_1.REDDOTINFOVALUEFIELD.number = 2
var_0_1.REDDOTINFOVALUEFIELD.index = 1
var_0_1.REDDOTINFOVALUEFIELD.label = 2
var_0_1.REDDOTINFOVALUEFIELD.has_default_value = false
var_0_1.REDDOTINFOVALUEFIELD.default_value = 0
var_0_1.REDDOTINFOVALUEFIELD.type = 5
var_0_1.REDDOTINFOVALUEFIELD.cpp_type = 1
var_0_1.REDDOTINFOTIMEFIELD.name = "time"
var_0_1.REDDOTINFOTIMEFIELD.full_name = ".RedDotInfo.time"
var_0_1.REDDOTINFOTIMEFIELD.number = 3
var_0_1.REDDOTINFOTIMEFIELD.index = 2
var_0_1.REDDOTINFOTIMEFIELD.label = 1
var_0_1.REDDOTINFOTIMEFIELD.has_default_value = false
var_0_1.REDDOTINFOTIMEFIELD.default_value = 0
var_0_1.REDDOTINFOTIMEFIELD.type = 5
var_0_1.REDDOTINFOTIMEFIELD.cpp_type = 1
var_0_1.REDDOTINFOEXTFIELD.name = "ext"
var_0_1.REDDOTINFOEXTFIELD.full_name = ".RedDotInfo.ext"
var_0_1.REDDOTINFOEXTFIELD.number = 4
var_0_1.REDDOTINFOEXTFIELD.index = 3
var_0_1.REDDOTINFOEXTFIELD.label = 1
var_0_1.REDDOTINFOEXTFIELD.has_default_value = false
var_0_1.REDDOTINFOEXTFIELD.default_value = ""
var_0_1.REDDOTINFOEXTFIELD.type = 9
var_0_1.REDDOTINFOEXTFIELD.cpp_type = 9
var_0_1.REDDOTINFO_MSG.name = "RedDotInfo"
var_0_1.REDDOTINFO_MSG.full_name = ".RedDotInfo"
var_0_1.REDDOTINFO_MSG.nested_types = {}
var_0_1.REDDOTINFO_MSG.enum_types = {}
var_0_1.REDDOTINFO_MSG.fields = {
	var_0_1.REDDOTINFOIDFIELD,
	var_0_1.REDDOTINFOVALUEFIELD,
	var_0_1.REDDOTINFOTIMEFIELD,
	var_0_1.REDDOTINFOEXTFIELD
}
var_0_1.REDDOTINFO_MSG.is_extendable = false
var_0_1.REDDOTINFO_MSG.extensions = {}
var_0_1.SHOWREDDOTREPLY_MSG.name = "ShowRedDotReply"
var_0_1.SHOWREDDOTREPLY_MSG.full_name = ".ShowRedDotReply"
var_0_1.SHOWREDDOTREPLY_MSG.nested_types = {}
var_0_1.SHOWREDDOTREPLY_MSG.enum_types = {}
var_0_1.SHOWREDDOTREPLY_MSG.fields = {}
var_0_1.SHOWREDDOTREPLY_MSG.is_extendable = false
var_0_1.SHOWREDDOTREPLY_MSG.extensions = {}
var_0_1.GETREDDOTINFOSREQUESTIDSFIELD.name = "ids"
var_0_1.GETREDDOTINFOSREQUESTIDSFIELD.full_name = ".GetRedDotInfosRequest.ids"
var_0_1.GETREDDOTINFOSREQUESTIDSFIELD.number = 1
var_0_1.GETREDDOTINFOSREQUESTIDSFIELD.index = 0
var_0_1.GETREDDOTINFOSREQUESTIDSFIELD.label = 3
var_0_1.GETREDDOTINFOSREQUESTIDSFIELD.has_default_value = false
var_0_1.GETREDDOTINFOSREQUESTIDSFIELD.default_value = {}
var_0_1.GETREDDOTINFOSREQUESTIDSFIELD.type = 5
var_0_1.GETREDDOTINFOSREQUESTIDSFIELD.cpp_type = 1
var_0_1.GETREDDOTINFOSREQUEST_MSG.name = "GetRedDotInfosRequest"
var_0_1.GETREDDOTINFOSREQUEST_MSG.full_name = ".GetRedDotInfosRequest"
var_0_1.GETREDDOTINFOSREQUEST_MSG.nested_types = {}
var_0_1.GETREDDOTINFOSREQUEST_MSG.enum_types = {}
var_0_1.GETREDDOTINFOSREQUEST_MSG.fields = {
	var_0_1.GETREDDOTINFOSREQUESTIDSFIELD
}
var_0_1.GETREDDOTINFOSREQUEST_MSG.is_extendable = false
var_0_1.GETREDDOTINFOSREQUEST_MSG.extensions = {}
var_0_1.SHOWREDDOTREQUESTDEFINEIDFIELD.name = "defineId"
var_0_1.SHOWREDDOTREQUESTDEFINEIDFIELD.full_name = ".ShowRedDotRequest.defineId"
var_0_1.SHOWREDDOTREQUESTDEFINEIDFIELD.number = 1
var_0_1.SHOWREDDOTREQUESTDEFINEIDFIELD.index = 0
var_0_1.SHOWREDDOTREQUESTDEFINEIDFIELD.label = 1
var_0_1.SHOWREDDOTREQUESTDEFINEIDFIELD.has_default_value = false
var_0_1.SHOWREDDOTREQUESTDEFINEIDFIELD.default_value = 0
var_0_1.SHOWREDDOTREQUESTDEFINEIDFIELD.type = 5
var_0_1.SHOWREDDOTREQUESTDEFINEIDFIELD.cpp_type = 1
var_0_1.SHOWREDDOTREQUESTISVISIBLEFIELD.name = "isVisible"
var_0_1.SHOWREDDOTREQUESTISVISIBLEFIELD.full_name = ".ShowRedDotRequest.isVisible"
var_0_1.SHOWREDDOTREQUESTISVISIBLEFIELD.number = 2
var_0_1.SHOWREDDOTREQUESTISVISIBLEFIELD.index = 1
var_0_1.SHOWREDDOTREQUESTISVISIBLEFIELD.label = 1
var_0_1.SHOWREDDOTREQUESTISVISIBLEFIELD.has_default_value = false
var_0_1.SHOWREDDOTREQUESTISVISIBLEFIELD.default_value = false
var_0_1.SHOWREDDOTREQUESTISVISIBLEFIELD.type = 8
var_0_1.SHOWREDDOTREQUESTISVISIBLEFIELD.cpp_type = 7
var_0_1.SHOWREDDOTREQUEST_MSG.name = "ShowRedDotRequest"
var_0_1.SHOWREDDOTREQUEST_MSG.full_name = ".ShowRedDotRequest"
var_0_1.SHOWREDDOTREQUEST_MSG.nested_types = {}
var_0_1.SHOWREDDOTREQUEST_MSG.enum_types = {}
var_0_1.SHOWREDDOTREQUEST_MSG.fields = {
	var_0_1.SHOWREDDOTREQUESTDEFINEIDFIELD,
	var_0_1.SHOWREDDOTREQUESTISVISIBLEFIELD
}
var_0_1.SHOWREDDOTREQUEST_MSG.is_extendable = false
var_0_1.SHOWREDDOTREQUEST_MSG.extensions = {}
var_0_1.GETREDDOTINFOSREPLYREDDOTINFOSFIELD.name = "redDotInfos"
var_0_1.GETREDDOTINFOSREPLYREDDOTINFOSFIELD.full_name = ".GetRedDotInfosReply.redDotInfos"
var_0_1.GETREDDOTINFOSREPLYREDDOTINFOSFIELD.number = 1
var_0_1.GETREDDOTINFOSREPLYREDDOTINFOSFIELD.index = 0
var_0_1.GETREDDOTINFOSREPLYREDDOTINFOSFIELD.label = 3
var_0_1.GETREDDOTINFOSREPLYREDDOTINFOSFIELD.has_default_value = false
var_0_1.GETREDDOTINFOSREPLYREDDOTINFOSFIELD.default_value = {}
var_0_1.GETREDDOTINFOSREPLYREDDOTINFOSFIELD.message_type = var_0_1.REDDOTGROUP_MSG
var_0_1.GETREDDOTINFOSREPLYREDDOTINFOSFIELD.type = 11
var_0_1.GETREDDOTINFOSREPLYREDDOTINFOSFIELD.cpp_type = 10
var_0_1.GETREDDOTINFOSREPLY_MSG.name = "GetRedDotInfosReply"
var_0_1.GETREDDOTINFOSREPLY_MSG.full_name = ".GetRedDotInfosReply"
var_0_1.GETREDDOTINFOSREPLY_MSG.nested_types = {}
var_0_1.GETREDDOTINFOSREPLY_MSG.enum_types = {}
var_0_1.GETREDDOTINFOSREPLY_MSG.fields = {
	var_0_1.GETREDDOTINFOSREPLYREDDOTINFOSFIELD
}
var_0_1.GETREDDOTINFOSREPLY_MSG.is_extendable = false
var_0_1.GETREDDOTINFOSREPLY_MSG.extensions = {}
var_0_1.REDDOTGROUPDEFINEIDFIELD.name = "defineId"
var_0_1.REDDOTGROUPDEFINEIDFIELD.full_name = ".RedDotGroup.defineId"
var_0_1.REDDOTGROUPDEFINEIDFIELD.number = 1
var_0_1.REDDOTGROUPDEFINEIDFIELD.index = 0
var_0_1.REDDOTGROUPDEFINEIDFIELD.label = 2
var_0_1.REDDOTGROUPDEFINEIDFIELD.has_default_value = false
var_0_1.REDDOTGROUPDEFINEIDFIELD.default_value = 0
var_0_1.REDDOTGROUPDEFINEIDFIELD.type = 5
var_0_1.REDDOTGROUPDEFINEIDFIELD.cpp_type = 1
var_0_1.REDDOTGROUPINFOSFIELD.name = "infos"
var_0_1.REDDOTGROUPINFOSFIELD.full_name = ".RedDotGroup.infos"
var_0_1.REDDOTGROUPINFOSFIELD.number = 2
var_0_1.REDDOTGROUPINFOSFIELD.index = 1
var_0_1.REDDOTGROUPINFOSFIELD.label = 3
var_0_1.REDDOTGROUPINFOSFIELD.has_default_value = false
var_0_1.REDDOTGROUPINFOSFIELD.default_value = {}
var_0_1.REDDOTGROUPINFOSFIELD.message_type = var_0_1.REDDOTINFO_MSG
var_0_1.REDDOTGROUPINFOSFIELD.type = 11
var_0_1.REDDOTGROUPINFOSFIELD.cpp_type = 10
var_0_1.REDDOTGROUPREPLACEALLFIELD.name = "replaceAll"
var_0_1.REDDOTGROUPREPLACEALLFIELD.full_name = ".RedDotGroup.replaceAll"
var_0_1.REDDOTGROUPREPLACEALLFIELD.number = 3
var_0_1.REDDOTGROUPREPLACEALLFIELD.index = 2
var_0_1.REDDOTGROUPREPLACEALLFIELD.label = 1
var_0_1.REDDOTGROUPREPLACEALLFIELD.has_default_value = false
var_0_1.REDDOTGROUPREPLACEALLFIELD.default_value = false
var_0_1.REDDOTGROUPREPLACEALLFIELD.type = 8
var_0_1.REDDOTGROUPREPLACEALLFIELD.cpp_type = 7
var_0_1.REDDOTGROUP_MSG.name = "RedDotGroup"
var_0_1.REDDOTGROUP_MSG.full_name = ".RedDotGroup"
var_0_1.REDDOTGROUP_MSG.nested_types = {}
var_0_1.REDDOTGROUP_MSG.enum_types = {}
var_0_1.REDDOTGROUP_MSG.fields = {
	var_0_1.REDDOTGROUPDEFINEIDFIELD,
	var_0_1.REDDOTGROUPINFOSFIELD,
	var_0_1.REDDOTGROUPREPLACEALLFIELD
}
var_0_1.REDDOTGROUP_MSG.is_extendable = false
var_0_1.REDDOTGROUP_MSG.extensions = {}
var_0_1.UPDATEREDDOTPUSHREDDOTINFOSFIELD.name = "redDotInfos"
var_0_1.UPDATEREDDOTPUSHREDDOTINFOSFIELD.full_name = ".UpdateRedDotPush.redDotInfos"
var_0_1.UPDATEREDDOTPUSHREDDOTINFOSFIELD.number = 1
var_0_1.UPDATEREDDOTPUSHREDDOTINFOSFIELD.index = 0
var_0_1.UPDATEREDDOTPUSHREDDOTINFOSFIELD.label = 3
var_0_1.UPDATEREDDOTPUSHREDDOTINFOSFIELD.has_default_value = false
var_0_1.UPDATEREDDOTPUSHREDDOTINFOSFIELD.default_value = {}
var_0_1.UPDATEREDDOTPUSHREDDOTINFOSFIELD.message_type = var_0_1.REDDOTGROUP_MSG
var_0_1.UPDATEREDDOTPUSHREDDOTINFOSFIELD.type = 11
var_0_1.UPDATEREDDOTPUSHREDDOTINFOSFIELD.cpp_type = 10
var_0_1.UPDATEREDDOTPUSHREPLACEALLFIELD.name = "replaceAll"
var_0_1.UPDATEREDDOTPUSHREPLACEALLFIELD.full_name = ".UpdateRedDotPush.replaceAll"
var_0_1.UPDATEREDDOTPUSHREPLACEALLFIELD.number = 2
var_0_1.UPDATEREDDOTPUSHREPLACEALLFIELD.index = 1
var_0_1.UPDATEREDDOTPUSHREPLACEALLFIELD.label = 1
var_0_1.UPDATEREDDOTPUSHREPLACEALLFIELD.has_default_value = false
var_0_1.UPDATEREDDOTPUSHREPLACEALLFIELD.default_value = false
var_0_1.UPDATEREDDOTPUSHREPLACEALLFIELD.type = 8
var_0_1.UPDATEREDDOTPUSHREPLACEALLFIELD.cpp_type = 7
var_0_1.UPDATEREDDOTPUSH_MSG.name = "UpdateRedDotPush"
var_0_1.UPDATEREDDOTPUSH_MSG.full_name = ".UpdateRedDotPush"
var_0_1.UPDATEREDDOTPUSH_MSG.nested_types = {}
var_0_1.UPDATEREDDOTPUSH_MSG.enum_types = {}
var_0_1.UPDATEREDDOTPUSH_MSG.fields = {
	var_0_1.UPDATEREDDOTPUSHREDDOTINFOSFIELD,
	var_0_1.UPDATEREDDOTPUSHREPLACEALLFIELD
}
var_0_1.UPDATEREDDOTPUSH_MSG.is_extendable = false
var_0_1.UPDATEREDDOTPUSH_MSG.extensions = {}
var_0_1.GetRedDotInfosReply = var_0_0.Message(var_0_1.GETREDDOTINFOSREPLY_MSG)
var_0_1.GetRedDotInfosRequest = var_0_0.Message(var_0_1.GETREDDOTINFOSREQUEST_MSG)
var_0_1.RedDotGroup = var_0_0.Message(var_0_1.REDDOTGROUP_MSG)
var_0_1.RedDotInfo = var_0_0.Message(var_0_1.REDDOTINFO_MSG)
var_0_1.ShowRedDotReply = var_0_0.Message(var_0_1.SHOWREDDOTREPLY_MSG)
var_0_1.ShowRedDotRequest = var_0_0.Message(var_0_1.SHOWREDDOTREQUEST_MSG)
var_0_1.UpdateRedDotPush = var_0_0.Message(var_0_1.UPDATEREDDOTPUSH_MSG)

return var_0_1
