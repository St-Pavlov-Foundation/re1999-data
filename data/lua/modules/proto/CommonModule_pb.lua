slot1 = require("protobuf.protobuf")

module("modules.proto.CommonModule_pb", package.seeall)

slot2 = {
	GETSERVERTIMEREPLY_MSG = slot1.Descriptor(),
	GETSERVERTIMEREPLYSERVERTIMEFIELD = slot1.FieldDescriptor(),
	GETSERVERTIMEREPLYOFFSETTIMEFIELD = slot1.FieldDescriptor(),
	GETSERVERTIMEREQUEST_MSG = slot1.Descriptor()
}
slot2.GETSERVERTIMEREPLYSERVERTIMEFIELD.name = "serverTime"
slot2.GETSERVERTIMEREPLYSERVERTIMEFIELD.full_name = ".GetServerTimeReply.serverTime"
slot2.GETSERVERTIMEREPLYSERVERTIMEFIELD.number = 1
slot2.GETSERVERTIMEREPLYSERVERTIMEFIELD.index = 0
slot2.GETSERVERTIMEREPLYSERVERTIMEFIELD.label = 1
slot2.GETSERVERTIMEREPLYSERVERTIMEFIELD.has_default_value = false
slot2.GETSERVERTIMEREPLYSERVERTIMEFIELD.default_value = 0
slot2.GETSERVERTIMEREPLYSERVERTIMEFIELD.type = 4
slot2.GETSERVERTIMEREPLYSERVERTIMEFIELD.cpp_type = 4
slot2.GETSERVERTIMEREPLYOFFSETTIMEFIELD.name = "offsetTime"
slot2.GETSERVERTIMEREPLYOFFSETTIMEFIELD.full_name = ".GetServerTimeReply.offsetTime"
slot2.GETSERVERTIMEREPLYOFFSETTIMEFIELD.number = 2
slot2.GETSERVERTIMEREPLYOFFSETTIMEFIELD.index = 1
slot2.GETSERVERTIMEREPLYOFFSETTIMEFIELD.label = 1
slot2.GETSERVERTIMEREPLYOFFSETTIMEFIELD.has_default_value = false
slot2.GETSERVERTIMEREPLYOFFSETTIMEFIELD.default_value = 0
slot2.GETSERVERTIMEREPLYOFFSETTIMEFIELD.type = 3
slot2.GETSERVERTIMEREPLYOFFSETTIMEFIELD.cpp_type = 2
slot2.GETSERVERTIMEREPLY_MSG.name = "GetServerTimeReply"
slot2.GETSERVERTIMEREPLY_MSG.full_name = ".GetServerTimeReply"
slot2.GETSERVERTIMEREPLY_MSG.nested_types = {}
slot2.GETSERVERTIMEREPLY_MSG.enum_types = {}
slot2.GETSERVERTIMEREPLY_MSG.fields = {
	slot2.GETSERVERTIMEREPLYSERVERTIMEFIELD,
	slot2.GETSERVERTIMEREPLYOFFSETTIMEFIELD
}
slot2.GETSERVERTIMEREPLY_MSG.is_extendable = false
slot2.GETSERVERTIMEREPLY_MSG.extensions = {}
slot2.GETSERVERTIMEREQUEST_MSG.name = "GetServerTimeRequest"
slot2.GETSERVERTIMEREQUEST_MSG.full_name = ".GetServerTimeRequest"
slot2.GETSERVERTIMEREQUEST_MSG.nested_types = {}
slot2.GETSERVERTIMEREQUEST_MSG.enum_types = {}
slot2.GETSERVERTIMEREQUEST_MSG.fields = {}
slot2.GETSERVERTIMEREQUEST_MSG.is_extendable = false
slot2.GETSERVERTIMEREQUEST_MSG.extensions = {}
slot2.GetServerTimeReply = slot1.Message(slot2.GETSERVERTIMEREPLY_MSG)
slot2.GetServerTimeRequest = slot1.Message(slot2.GETSERVERTIMEREQUEST_MSG)

return slot2
