﻿local var_0_0 = require("protobuf.protobuf")

module("modules.proto.ChatModule_pb", package.seeall)

local var_0_1 = {
	DELETEOFFLINEMSGREPLY_MSG = var_0_0.Descriptor(),
	REPORTREQUEST_MSG = var_0_0.Descriptor(),
	REPORTREQUESTREPORTEDUSERIDFIELD = var_0_0.FieldDescriptor(),
	REPORTREQUESTREPORTTYPEIDFIELD = var_0_0.FieldDescriptor(),
	REPORTREQUESTCONTENTFIELD = var_0_0.FieldDescriptor(),
	SENDMSGREPLY_MSG = var_0_0.Descriptor(),
	SENDMSGREPLYMESSAGEFIELD = var_0_0.FieldDescriptor(),
	SENDMSGREPLYCONTENTFIELD = var_0_0.FieldDescriptor(),
	SENDMSGREPLYCHANNELTYPEFIELD = var_0_0.FieldDescriptor(),
	SENDMSGREPLYMSGTYPEFIELD = var_0_0.FieldDescriptor(),
	SENDMSGREPLYEXTDATAFIELD = var_0_0.FieldDescriptor(),
	SENDMSGREQUEST_MSG = var_0_0.Descriptor(),
	SENDMSGREQUESTCHANNELTYPEFIELD = var_0_0.FieldDescriptor(),
	SENDMSGREQUESTRECIPIENTIDFIELD = var_0_0.FieldDescriptor(),
	SENDMSGREQUESTCONTENTFIELD = var_0_0.FieldDescriptor(),
	SENDMSGREQUESTMSGTYPEFIELD = var_0_0.FieldDescriptor(),
	SENDMSGREQUESTEXTDATAFIELD = var_0_0.FieldDescriptor(),
	CHATMSG_MSG = var_0_0.Descriptor(),
	CHATMSGMSGIDFIELD = var_0_0.FieldDescriptor(),
	CHATMSGCHANNELTYPEFIELD = var_0_0.FieldDescriptor(),
	CHATMSGSENDERIDFIELD = var_0_0.FieldDescriptor(),
	CHATMSGSENDERNAMEFIELD = var_0_0.FieldDescriptor(),
	CHATMSGPORTRAITFIELD = var_0_0.FieldDescriptor(),
	CHATMSGCONTENTFIELD = var_0_0.FieldDescriptor(),
	CHATMSGSENDTIMEFIELD = var_0_0.FieldDescriptor(),
	CHATMSGLEVELFIELD = var_0_0.FieldDescriptor(),
	CHATMSGRECIPIENTIDFIELD = var_0_0.FieldDescriptor(),
	CHATMSGMSGTYPEFIELD = var_0_0.FieldDescriptor(),
	CHATMSGEXTDATAFIELD = var_0_0.FieldDescriptor(),
	REPORTREPLY_MSG = var_0_0.Descriptor(),
	GETREPORTTYPEREQUEST_MSG = var_0_0.Descriptor(),
	CHATMSGPUSH_MSG = var_0_0.Descriptor(),
	CHATMSGPUSHMSGFIELD = var_0_0.FieldDescriptor(),
	WORDTESTREQUEST_MSG = var_0_0.Descriptor(),
	WORDTESTREQUESTCONTENTFIELD = var_0_0.FieldDescriptor(),
	GETREPORTTYPEREPLY_MSG = var_0_0.Descriptor(),
	GETREPORTTYPEREPLYREPORTTYPESFIELD = var_0_0.FieldDescriptor(),
	DELETEOFFLINEMSGREQUEST_MSG = var_0_0.Descriptor(),
	WORDTESTREPLY_MSG = var_0_0.Descriptor(),
	REPORTTYPE_MSG = var_0_0.Descriptor(),
	REPORTTYPEIDFIELD = var_0_0.FieldDescriptor(),
	REPORTTYPEDESCFIELD = var_0_0.FieldDescriptor()
}

var_0_1.DELETEOFFLINEMSGREPLY_MSG.name = "DeleteOfflineMsgReply"
var_0_1.DELETEOFFLINEMSGREPLY_MSG.full_name = ".DeleteOfflineMsgReply"
var_0_1.DELETEOFFLINEMSGREPLY_MSG.nested_types = {}
var_0_1.DELETEOFFLINEMSGREPLY_MSG.enum_types = {}
var_0_1.DELETEOFFLINEMSGREPLY_MSG.fields = {}
var_0_1.DELETEOFFLINEMSGREPLY_MSG.is_extendable = false
var_0_1.DELETEOFFLINEMSGREPLY_MSG.extensions = {}
var_0_1.REPORTREQUESTREPORTEDUSERIDFIELD.name = "reportedUserId"
var_0_1.REPORTREQUESTREPORTEDUSERIDFIELD.full_name = ".ReportRequest.reportedUserId"
var_0_1.REPORTREQUESTREPORTEDUSERIDFIELD.number = 1
var_0_1.REPORTREQUESTREPORTEDUSERIDFIELD.index = 0
var_0_1.REPORTREQUESTREPORTEDUSERIDFIELD.label = 1
var_0_1.REPORTREQUESTREPORTEDUSERIDFIELD.has_default_value = false
var_0_1.REPORTREQUESTREPORTEDUSERIDFIELD.default_value = 0
var_0_1.REPORTREQUESTREPORTEDUSERIDFIELD.type = 4
var_0_1.REPORTREQUESTREPORTEDUSERIDFIELD.cpp_type = 4
var_0_1.REPORTREQUESTREPORTTYPEIDFIELD.name = "reportTypeId"
var_0_1.REPORTREQUESTREPORTTYPEIDFIELD.full_name = ".ReportRequest.reportTypeId"
var_0_1.REPORTREQUESTREPORTTYPEIDFIELD.number = 2
var_0_1.REPORTREQUESTREPORTTYPEIDFIELD.index = 1
var_0_1.REPORTREQUESTREPORTTYPEIDFIELD.label = 1
var_0_1.REPORTREQUESTREPORTTYPEIDFIELD.has_default_value = false
var_0_1.REPORTREQUESTREPORTTYPEIDFIELD.default_value = 0
var_0_1.REPORTREQUESTREPORTTYPEIDFIELD.type = 5
var_0_1.REPORTREQUESTREPORTTYPEIDFIELD.cpp_type = 1
var_0_1.REPORTREQUESTCONTENTFIELD.name = "content"
var_0_1.REPORTREQUESTCONTENTFIELD.full_name = ".ReportRequest.content"
var_0_1.REPORTREQUESTCONTENTFIELD.number = 3
var_0_1.REPORTREQUESTCONTENTFIELD.index = 2
var_0_1.REPORTREQUESTCONTENTFIELD.label = 1
var_0_1.REPORTREQUESTCONTENTFIELD.has_default_value = false
var_0_1.REPORTREQUESTCONTENTFIELD.default_value = ""
var_0_1.REPORTREQUESTCONTENTFIELD.type = 9
var_0_1.REPORTREQUESTCONTENTFIELD.cpp_type = 9
var_0_1.REPORTREQUEST_MSG.name = "ReportRequest"
var_0_1.REPORTREQUEST_MSG.full_name = ".ReportRequest"
var_0_1.REPORTREQUEST_MSG.nested_types = {}
var_0_1.REPORTREQUEST_MSG.enum_types = {}
var_0_1.REPORTREQUEST_MSG.fields = {
	var_0_1.REPORTREQUESTREPORTEDUSERIDFIELD,
	var_0_1.REPORTREQUESTREPORTTYPEIDFIELD,
	var_0_1.REPORTREQUESTCONTENTFIELD
}
var_0_1.REPORTREQUEST_MSG.is_extendable = false
var_0_1.REPORTREQUEST_MSG.extensions = {}
var_0_1.SENDMSGREPLYMESSAGEFIELD.name = "message"
var_0_1.SENDMSGREPLYMESSAGEFIELD.full_name = ".SendMsgReply.message"
var_0_1.SENDMSGREPLYMESSAGEFIELD.number = 1
var_0_1.SENDMSGREPLYMESSAGEFIELD.index = 0
var_0_1.SENDMSGREPLYMESSAGEFIELD.label = 1
var_0_1.SENDMSGREPLYMESSAGEFIELD.has_default_value = false
var_0_1.SENDMSGREPLYMESSAGEFIELD.default_value = ""
var_0_1.SENDMSGREPLYMESSAGEFIELD.type = 9
var_0_1.SENDMSGREPLYMESSAGEFIELD.cpp_type = 9
var_0_1.SENDMSGREPLYCONTENTFIELD.name = "content"
var_0_1.SENDMSGREPLYCONTENTFIELD.full_name = ".SendMsgReply.content"
var_0_1.SENDMSGREPLYCONTENTFIELD.number = 2
var_0_1.SENDMSGREPLYCONTENTFIELD.index = 1
var_0_1.SENDMSGREPLYCONTENTFIELD.label = 1
var_0_1.SENDMSGREPLYCONTENTFIELD.has_default_value = false
var_0_1.SENDMSGREPLYCONTENTFIELD.default_value = ""
var_0_1.SENDMSGREPLYCONTENTFIELD.type = 9
var_0_1.SENDMSGREPLYCONTENTFIELD.cpp_type = 9
var_0_1.SENDMSGREPLYCHANNELTYPEFIELD.name = "channelType"
var_0_1.SENDMSGREPLYCHANNELTYPEFIELD.full_name = ".SendMsgReply.channelType"
var_0_1.SENDMSGREPLYCHANNELTYPEFIELD.number = 3
var_0_1.SENDMSGREPLYCHANNELTYPEFIELD.index = 2
var_0_1.SENDMSGREPLYCHANNELTYPEFIELD.label = 1
var_0_1.SENDMSGREPLYCHANNELTYPEFIELD.has_default_value = false
var_0_1.SENDMSGREPLYCHANNELTYPEFIELD.default_value = 0
var_0_1.SENDMSGREPLYCHANNELTYPEFIELD.type = 13
var_0_1.SENDMSGREPLYCHANNELTYPEFIELD.cpp_type = 3
var_0_1.SENDMSGREPLYMSGTYPEFIELD.name = "msgType"
var_0_1.SENDMSGREPLYMSGTYPEFIELD.full_name = ".SendMsgReply.msgType"
var_0_1.SENDMSGREPLYMSGTYPEFIELD.number = 4
var_0_1.SENDMSGREPLYMSGTYPEFIELD.index = 3
var_0_1.SENDMSGREPLYMSGTYPEFIELD.label = 1
var_0_1.SENDMSGREPLYMSGTYPEFIELD.has_default_value = false
var_0_1.SENDMSGREPLYMSGTYPEFIELD.default_value = 0
var_0_1.SENDMSGREPLYMSGTYPEFIELD.type = 5
var_0_1.SENDMSGREPLYMSGTYPEFIELD.cpp_type = 1
var_0_1.SENDMSGREPLYEXTDATAFIELD.name = "extData"
var_0_1.SENDMSGREPLYEXTDATAFIELD.full_name = ".SendMsgReply.extData"
var_0_1.SENDMSGREPLYEXTDATAFIELD.number = 5
var_0_1.SENDMSGREPLYEXTDATAFIELD.index = 4
var_0_1.SENDMSGREPLYEXTDATAFIELD.label = 1
var_0_1.SENDMSGREPLYEXTDATAFIELD.has_default_value = false
var_0_1.SENDMSGREPLYEXTDATAFIELD.default_value = ""
var_0_1.SENDMSGREPLYEXTDATAFIELD.type = 9
var_0_1.SENDMSGREPLYEXTDATAFIELD.cpp_type = 9
var_0_1.SENDMSGREPLY_MSG.name = "SendMsgReply"
var_0_1.SENDMSGREPLY_MSG.full_name = ".SendMsgReply"
var_0_1.SENDMSGREPLY_MSG.nested_types = {}
var_0_1.SENDMSGREPLY_MSG.enum_types = {}
var_0_1.SENDMSGREPLY_MSG.fields = {
	var_0_1.SENDMSGREPLYMESSAGEFIELD,
	var_0_1.SENDMSGREPLYCONTENTFIELD,
	var_0_1.SENDMSGREPLYCHANNELTYPEFIELD,
	var_0_1.SENDMSGREPLYMSGTYPEFIELD,
	var_0_1.SENDMSGREPLYEXTDATAFIELD
}
var_0_1.SENDMSGREPLY_MSG.is_extendable = false
var_0_1.SENDMSGREPLY_MSG.extensions = {}
var_0_1.SENDMSGREQUESTCHANNELTYPEFIELD.name = "channelType"
var_0_1.SENDMSGREQUESTCHANNELTYPEFIELD.full_name = ".SendMsgRequest.channelType"
var_0_1.SENDMSGREQUESTCHANNELTYPEFIELD.number = 1
var_0_1.SENDMSGREQUESTCHANNELTYPEFIELD.index = 0
var_0_1.SENDMSGREQUESTCHANNELTYPEFIELD.label = 1
var_0_1.SENDMSGREQUESTCHANNELTYPEFIELD.has_default_value = false
var_0_1.SENDMSGREQUESTCHANNELTYPEFIELD.default_value = 0
var_0_1.SENDMSGREQUESTCHANNELTYPEFIELD.type = 13
var_0_1.SENDMSGREQUESTCHANNELTYPEFIELD.cpp_type = 3
var_0_1.SENDMSGREQUESTRECIPIENTIDFIELD.name = "recipientId"
var_0_1.SENDMSGREQUESTRECIPIENTIDFIELD.full_name = ".SendMsgRequest.recipientId"
var_0_1.SENDMSGREQUESTRECIPIENTIDFIELD.number = 2
var_0_1.SENDMSGREQUESTRECIPIENTIDFIELD.index = 1
var_0_1.SENDMSGREQUESTRECIPIENTIDFIELD.label = 1
var_0_1.SENDMSGREQUESTRECIPIENTIDFIELD.has_default_value = false
var_0_1.SENDMSGREQUESTRECIPIENTIDFIELD.default_value = 0
var_0_1.SENDMSGREQUESTRECIPIENTIDFIELD.type = 4
var_0_1.SENDMSGREQUESTRECIPIENTIDFIELD.cpp_type = 4
var_0_1.SENDMSGREQUESTCONTENTFIELD.name = "content"
var_0_1.SENDMSGREQUESTCONTENTFIELD.full_name = ".SendMsgRequest.content"
var_0_1.SENDMSGREQUESTCONTENTFIELD.number = 3
var_0_1.SENDMSGREQUESTCONTENTFIELD.index = 2
var_0_1.SENDMSGREQUESTCONTENTFIELD.label = 1
var_0_1.SENDMSGREQUESTCONTENTFIELD.has_default_value = false
var_0_1.SENDMSGREQUESTCONTENTFIELD.default_value = ""
var_0_1.SENDMSGREQUESTCONTENTFIELD.type = 9
var_0_1.SENDMSGREQUESTCONTENTFIELD.cpp_type = 9
var_0_1.SENDMSGREQUESTMSGTYPEFIELD.name = "msgType"
var_0_1.SENDMSGREQUESTMSGTYPEFIELD.full_name = ".SendMsgRequest.msgType"
var_0_1.SENDMSGREQUESTMSGTYPEFIELD.number = 4
var_0_1.SENDMSGREQUESTMSGTYPEFIELD.index = 3
var_0_1.SENDMSGREQUESTMSGTYPEFIELD.label = 1
var_0_1.SENDMSGREQUESTMSGTYPEFIELD.has_default_value = false
var_0_1.SENDMSGREQUESTMSGTYPEFIELD.default_value = 0
var_0_1.SENDMSGREQUESTMSGTYPEFIELD.type = 5
var_0_1.SENDMSGREQUESTMSGTYPEFIELD.cpp_type = 1
var_0_1.SENDMSGREQUESTEXTDATAFIELD.name = "extData"
var_0_1.SENDMSGREQUESTEXTDATAFIELD.full_name = ".SendMsgRequest.extData"
var_0_1.SENDMSGREQUESTEXTDATAFIELD.number = 5
var_0_1.SENDMSGREQUESTEXTDATAFIELD.index = 4
var_0_1.SENDMSGREQUESTEXTDATAFIELD.label = 1
var_0_1.SENDMSGREQUESTEXTDATAFIELD.has_default_value = false
var_0_1.SENDMSGREQUESTEXTDATAFIELD.default_value = ""
var_0_1.SENDMSGREQUESTEXTDATAFIELD.type = 9
var_0_1.SENDMSGREQUESTEXTDATAFIELD.cpp_type = 9
var_0_1.SENDMSGREQUEST_MSG.name = "SendMsgRequest"
var_0_1.SENDMSGREQUEST_MSG.full_name = ".SendMsgRequest"
var_0_1.SENDMSGREQUEST_MSG.nested_types = {}
var_0_1.SENDMSGREQUEST_MSG.enum_types = {}
var_0_1.SENDMSGREQUEST_MSG.fields = {
	var_0_1.SENDMSGREQUESTCHANNELTYPEFIELD,
	var_0_1.SENDMSGREQUESTRECIPIENTIDFIELD,
	var_0_1.SENDMSGREQUESTCONTENTFIELD,
	var_0_1.SENDMSGREQUESTMSGTYPEFIELD,
	var_0_1.SENDMSGREQUESTEXTDATAFIELD
}
var_0_1.SENDMSGREQUEST_MSG.is_extendable = false
var_0_1.SENDMSGREQUEST_MSG.extensions = {}
var_0_1.CHATMSGMSGIDFIELD.name = "msgId"
var_0_1.CHATMSGMSGIDFIELD.full_name = ".ChatMsg.msgId"
var_0_1.CHATMSGMSGIDFIELD.number = 1
var_0_1.CHATMSGMSGIDFIELD.index = 0
var_0_1.CHATMSGMSGIDFIELD.label = 1
var_0_1.CHATMSGMSGIDFIELD.has_default_value = false
var_0_1.CHATMSGMSGIDFIELD.default_value = 0
var_0_1.CHATMSGMSGIDFIELD.type = 4
var_0_1.CHATMSGMSGIDFIELD.cpp_type = 4
var_0_1.CHATMSGCHANNELTYPEFIELD.name = "channelType"
var_0_1.CHATMSGCHANNELTYPEFIELD.full_name = ".ChatMsg.channelType"
var_0_1.CHATMSGCHANNELTYPEFIELD.number = 2
var_0_1.CHATMSGCHANNELTYPEFIELD.index = 1
var_0_1.CHATMSGCHANNELTYPEFIELD.label = 1
var_0_1.CHATMSGCHANNELTYPEFIELD.has_default_value = false
var_0_1.CHATMSGCHANNELTYPEFIELD.default_value = 0
var_0_1.CHATMSGCHANNELTYPEFIELD.type = 13
var_0_1.CHATMSGCHANNELTYPEFIELD.cpp_type = 3
var_0_1.CHATMSGSENDERIDFIELD.name = "senderId"
var_0_1.CHATMSGSENDERIDFIELD.full_name = ".ChatMsg.senderId"
var_0_1.CHATMSGSENDERIDFIELD.number = 3
var_0_1.CHATMSGSENDERIDFIELD.index = 2
var_0_1.CHATMSGSENDERIDFIELD.label = 1
var_0_1.CHATMSGSENDERIDFIELD.has_default_value = false
var_0_1.CHATMSGSENDERIDFIELD.default_value = 0
var_0_1.CHATMSGSENDERIDFIELD.type = 4
var_0_1.CHATMSGSENDERIDFIELD.cpp_type = 4
var_0_1.CHATMSGSENDERNAMEFIELD.name = "senderName"
var_0_1.CHATMSGSENDERNAMEFIELD.full_name = ".ChatMsg.senderName"
var_0_1.CHATMSGSENDERNAMEFIELD.number = 4
var_0_1.CHATMSGSENDERNAMEFIELD.index = 3
var_0_1.CHATMSGSENDERNAMEFIELD.label = 1
var_0_1.CHATMSGSENDERNAMEFIELD.has_default_value = false
var_0_1.CHATMSGSENDERNAMEFIELD.default_value = ""
var_0_1.CHATMSGSENDERNAMEFIELD.type = 9
var_0_1.CHATMSGSENDERNAMEFIELD.cpp_type = 9
var_0_1.CHATMSGPORTRAITFIELD.name = "portrait"
var_0_1.CHATMSGPORTRAITFIELD.full_name = ".ChatMsg.portrait"
var_0_1.CHATMSGPORTRAITFIELD.number = 5
var_0_1.CHATMSGPORTRAITFIELD.index = 4
var_0_1.CHATMSGPORTRAITFIELD.label = 1
var_0_1.CHATMSGPORTRAITFIELD.has_default_value = false
var_0_1.CHATMSGPORTRAITFIELD.default_value = 0
var_0_1.CHATMSGPORTRAITFIELD.type = 13
var_0_1.CHATMSGPORTRAITFIELD.cpp_type = 3
var_0_1.CHATMSGCONTENTFIELD.name = "content"
var_0_1.CHATMSGCONTENTFIELD.full_name = ".ChatMsg.content"
var_0_1.CHATMSGCONTENTFIELD.number = 6
var_0_1.CHATMSGCONTENTFIELD.index = 5
var_0_1.CHATMSGCONTENTFIELD.label = 1
var_0_1.CHATMSGCONTENTFIELD.has_default_value = false
var_0_1.CHATMSGCONTENTFIELD.default_value = ""
var_0_1.CHATMSGCONTENTFIELD.type = 9
var_0_1.CHATMSGCONTENTFIELD.cpp_type = 9
var_0_1.CHATMSGSENDTIMEFIELD.name = "sendTime"
var_0_1.CHATMSGSENDTIMEFIELD.full_name = ".ChatMsg.sendTime"
var_0_1.CHATMSGSENDTIMEFIELD.number = 7
var_0_1.CHATMSGSENDTIMEFIELD.index = 6
var_0_1.CHATMSGSENDTIMEFIELD.label = 1
var_0_1.CHATMSGSENDTIMEFIELD.has_default_value = false
var_0_1.CHATMSGSENDTIMEFIELD.default_value = 0
var_0_1.CHATMSGSENDTIMEFIELD.type = 4
var_0_1.CHATMSGSENDTIMEFIELD.cpp_type = 4
var_0_1.CHATMSGLEVELFIELD.name = "level"
var_0_1.CHATMSGLEVELFIELD.full_name = ".ChatMsg.level"
var_0_1.CHATMSGLEVELFIELD.number = 8
var_0_1.CHATMSGLEVELFIELD.index = 7
var_0_1.CHATMSGLEVELFIELD.label = 1
var_0_1.CHATMSGLEVELFIELD.has_default_value = false
var_0_1.CHATMSGLEVELFIELD.default_value = 0
var_0_1.CHATMSGLEVELFIELD.type = 13
var_0_1.CHATMSGLEVELFIELD.cpp_type = 3
var_0_1.CHATMSGRECIPIENTIDFIELD.name = "recipientId"
var_0_1.CHATMSGRECIPIENTIDFIELD.full_name = ".ChatMsg.recipientId"
var_0_1.CHATMSGRECIPIENTIDFIELD.number = 9
var_0_1.CHATMSGRECIPIENTIDFIELD.index = 8
var_0_1.CHATMSGRECIPIENTIDFIELD.label = 1
var_0_1.CHATMSGRECIPIENTIDFIELD.has_default_value = false
var_0_1.CHATMSGRECIPIENTIDFIELD.default_value = 0
var_0_1.CHATMSGRECIPIENTIDFIELD.type = 4
var_0_1.CHATMSGRECIPIENTIDFIELD.cpp_type = 4
var_0_1.CHATMSGMSGTYPEFIELD.name = "msgType"
var_0_1.CHATMSGMSGTYPEFIELD.full_name = ".ChatMsg.msgType"
var_0_1.CHATMSGMSGTYPEFIELD.number = 10
var_0_1.CHATMSGMSGTYPEFIELD.index = 9
var_0_1.CHATMSGMSGTYPEFIELD.label = 1
var_0_1.CHATMSGMSGTYPEFIELD.has_default_value = false
var_0_1.CHATMSGMSGTYPEFIELD.default_value = 0
var_0_1.CHATMSGMSGTYPEFIELD.type = 5
var_0_1.CHATMSGMSGTYPEFIELD.cpp_type = 1
var_0_1.CHATMSGEXTDATAFIELD.name = "extData"
var_0_1.CHATMSGEXTDATAFIELD.full_name = ".ChatMsg.extData"
var_0_1.CHATMSGEXTDATAFIELD.number = 11
var_0_1.CHATMSGEXTDATAFIELD.index = 10
var_0_1.CHATMSGEXTDATAFIELD.label = 1
var_0_1.CHATMSGEXTDATAFIELD.has_default_value = false
var_0_1.CHATMSGEXTDATAFIELD.default_value = ""
var_0_1.CHATMSGEXTDATAFIELD.type = 9
var_0_1.CHATMSGEXTDATAFIELD.cpp_type = 9
var_0_1.CHATMSG_MSG.name = "ChatMsg"
var_0_1.CHATMSG_MSG.full_name = ".ChatMsg"
var_0_1.CHATMSG_MSG.nested_types = {}
var_0_1.CHATMSG_MSG.enum_types = {}
var_0_1.CHATMSG_MSG.fields = {
	var_0_1.CHATMSGMSGIDFIELD,
	var_0_1.CHATMSGCHANNELTYPEFIELD,
	var_0_1.CHATMSGSENDERIDFIELD,
	var_0_1.CHATMSGSENDERNAMEFIELD,
	var_0_1.CHATMSGPORTRAITFIELD,
	var_0_1.CHATMSGCONTENTFIELD,
	var_0_1.CHATMSGSENDTIMEFIELD,
	var_0_1.CHATMSGLEVELFIELD,
	var_0_1.CHATMSGRECIPIENTIDFIELD,
	var_0_1.CHATMSGMSGTYPEFIELD,
	var_0_1.CHATMSGEXTDATAFIELD
}
var_0_1.CHATMSG_MSG.is_extendable = false
var_0_1.CHATMSG_MSG.extensions = {}
var_0_1.REPORTREPLY_MSG.name = "ReportReply"
var_0_1.REPORTREPLY_MSG.full_name = ".ReportReply"
var_0_1.REPORTREPLY_MSG.nested_types = {}
var_0_1.REPORTREPLY_MSG.enum_types = {}
var_0_1.REPORTREPLY_MSG.fields = {}
var_0_1.REPORTREPLY_MSG.is_extendable = false
var_0_1.REPORTREPLY_MSG.extensions = {}
var_0_1.GETREPORTTYPEREQUEST_MSG.name = "GetReportTypeRequest"
var_0_1.GETREPORTTYPEREQUEST_MSG.full_name = ".GetReportTypeRequest"
var_0_1.GETREPORTTYPEREQUEST_MSG.nested_types = {}
var_0_1.GETREPORTTYPEREQUEST_MSG.enum_types = {}
var_0_1.GETREPORTTYPEREQUEST_MSG.fields = {}
var_0_1.GETREPORTTYPEREQUEST_MSG.is_extendable = false
var_0_1.GETREPORTTYPEREQUEST_MSG.extensions = {}
var_0_1.CHATMSGPUSHMSGFIELD.name = "msg"
var_0_1.CHATMSGPUSHMSGFIELD.full_name = ".ChatMsgPush.msg"
var_0_1.CHATMSGPUSHMSGFIELD.number = 1
var_0_1.CHATMSGPUSHMSGFIELD.index = 0
var_0_1.CHATMSGPUSHMSGFIELD.label = 3
var_0_1.CHATMSGPUSHMSGFIELD.has_default_value = false
var_0_1.CHATMSGPUSHMSGFIELD.default_value = {}
var_0_1.CHATMSGPUSHMSGFIELD.message_type = var_0_1.CHATMSG_MSG
var_0_1.CHATMSGPUSHMSGFIELD.type = 11
var_0_1.CHATMSGPUSHMSGFIELD.cpp_type = 10
var_0_1.CHATMSGPUSH_MSG.name = "ChatMsgPush"
var_0_1.CHATMSGPUSH_MSG.full_name = ".ChatMsgPush"
var_0_1.CHATMSGPUSH_MSG.nested_types = {}
var_0_1.CHATMSGPUSH_MSG.enum_types = {}
var_0_1.CHATMSGPUSH_MSG.fields = {
	var_0_1.CHATMSGPUSHMSGFIELD
}
var_0_1.CHATMSGPUSH_MSG.is_extendable = false
var_0_1.CHATMSGPUSH_MSG.extensions = {}
var_0_1.WORDTESTREQUESTCONTENTFIELD.name = "content"
var_0_1.WORDTESTREQUESTCONTENTFIELD.full_name = ".WordTestRequest.content"
var_0_1.WORDTESTREQUESTCONTENTFIELD.number = 1
var_0_1.WORDTESTREQUESTCONTENTFIELD.index = 0
var_0_1.WORDTESTREQUESTCONTENTFIELD.label = 1
var_0_1.WORDTESTREQUESTCONTENTFIELD.has_default_value = false
var_0_1.WORDTESTREQUESTCONTENTFIELD.default_value = ""
var_0_1.WORDTESTREQUESTCONTENTFIELD.type = 9
var_0_1.WORDTESTREQUESTCONTENTFIELD.cpp_type = 9
var_0_1.WORDTESTREQUEST_MSG.name = "WordTestRequest"
var_0_1.WORDTESTREQUEST_MSG.full_name = ".WordTestRequest"
var_0_1.WORDTESTREQUEST_MSG.nested_types = {}
var_0_1.WORDTESTREQUEST_MSG.enum_types = {}
var_0_1.WORDTESTREQUEST_MSG.fields = {
	var_0_1.WORDTESTREQUESTCONTENTFIELD
}
var_0_1.WORDTESTREQUEST_MSG.is_extendable = false
var_0_1.WORDTESTREQUEST_MSG.extensions = {}
var_0_1.GETREPORTTYPEREPLYREPORTTYPESFIELD.name = "reportTypes"
var_0_1.GETREPORTTYPEREPLYREPORTTYPESFIELD.full_name = ".GetReportTypeReply.reportTypes"
var_0_1.GETREPORTTYPEREPLYREPORTTYPESFIELD.number = 1
var_0_1.GETREPORTTYPEREPLYREPORTTYPESFIELD.index = 0
var_0_1.GETREPORTTYPEREPLYREPORTTYPESFIELD.label = 3
var_0_1.GETREPORTTYPEREPLYREPORTTYPESFIELD.has_default_value = false
var_0_1.GETREPORTTYPEREPLYREPORTTYPESFIELD.default_value = {}
var_0_1.GETREPORTTYPEREPLYREPORTTYPESFIELD.message_type = var_0_1.REPORTTYPE_MSG
var_0_1.GETREPORTTYPEREPLYREPORTTYPESFIELD.type = 11
var_0_1.GETREPORTTYPEREPLYREPORTTYPESFIELD.cpp_type = 10
var_0_1.GETREPORTTYPEREPLY_MSG.name = "GetReportTypeReply"
var_0_1.GETREPORTTYPEREPLY_MSG.full_name = ".GetReportTypeReply"
var_0_1.GETREPORTTYPEREPLY_MSG.nested_types = {}
var_0_1.GETREPORTTYPEREPLY_MSG.enum_types = {}
var_0_1.GETREPORTTYPEREPLY_MSG.fields = {
	var_0_1.GETREPORTTYPEREPLYREPORTTYPESFIELD
}
var_0_1.GETREPORTTYPEREPLY_MSG.is_extendable = false
var_0_1.GETREPORTTYPEREPLY_MSG.extensions = {}
var_0_1.DELETEOFFLINEMSGREQUEST_MSG.name = "DeleteOfflineMsgRequest"
var_0_1.DELETEOFFLINEMSGREQUEST_MSG.full_name = ".DeleteOfflineMsgRequest"
var_0_1.DELETEOFFLINEMSGREQUEST_MSG.nested_types = {}
var_0_1.DELETEOFFLINEMSGREQUEST_MSG.enum_types = {}
var_0_1.DELETEOFFLINEMSGREQUEST_MSG.fields = {}
var_0_1.DELETEOFFLINEMSGREQUEST_MSG.is_extendable = false
var_0_1.DELETEOFFLINEMSGREQUEST_MSG.extensions = {}
var_0_1.WORDTESTREPLY_MSG.name = "WordTestReply"
var_0_1.WORDTESTREPLY_MSG.full_name = ".WordTestReply"
var_0_1.WORDTESTREPLY_MSG.nested_types = {}
var_0_1.WORDTESTREPLY_MSG.enum_types = {}
var_0_1.WORDTESTREPLY_MSG.fields = {}
var_0_1.WORDTESTREPLY_MSG.is_extendable = false
var_0_1.WORDTESTREPLY_MSG.extensions = {}
var_0_1.REPORTTYPEIDFIELD.name = "id"
var_0_1.REPORTTYPEIDFIELD.full_name = ".ReportType.id"
var_0_1.REPORTTYPEIDFIELD.number = 1
var_0_1.REPORTTYPEIDFIELD.index = 0
var_0_1.REPORTTYPEIDFIELD.label = 1
var_0_1.REPORTTYPEIDFIELD.has_default_value = false
var_0_1.REPORTTYPEIDFIELD.default_value = 0
var_0_1.REPORTTYPEIDFIELD.type = 5
var_0_1.REPORTTYPEIDFIELD.cpp_type = 1
var_0_1.REPORTTYPEDESCFIELD.name = "desc"
var_0_1.REPORTTYPEDESCFIELD.full_name = ".ReportType.desc"
var_0_1.REPORTTYPEDESCFIELD.number = 2
var_0_1.REPORTTYPEDESCFIELD.index = 1
var_0_1.REPORTTYPEDESCFIELD.label = 1
var_0_1.REPORTTYPEDESCFIELD.has_default_value = false
var_0_1.REPORTTYPEDESCFIELD.default_value = ""
var_0_1.REPORTTYPEDESCFIELD.type = 9
var_0_1.REPORTTYPEDESCFIELD.cpp_type = 9
var_0_1.REPORTTYPE_MSG.name = "ReportType"
var_0_1.REPORTTYPE_MSG.full_name = ".ReportType"
var_0_1.REPORTTYPE_MSG.nested_types = {}
var_0_1.REPORTTYPE_MSG.enum_types = {}
var_0_1.REPORTTYPE_MSG.fields = {
	var_0_1.REPORTTYPEIDFIELD,
	var_0_1.REPORTTYPEDESCFIELD
}
var_0_1.REPORTTYPE_MSG.is_extendable = false
var_0_1.REPORTTYPE_MSG.extensions = {}
var_0_1.ChatMsg = var_0_0.Message(var_0_1.CHATMSG_MSG)
var_0_1.ChatMsgPush = var_0_0.Message(var_0_1.CHATMSGPUSH_MSG)
var_0_1.DeleteOfflineMsgReply = var_0_0.Message(var_0_1.DELETEOFFLINEMSGREPLY_MSG)
var_0_1.DeleteOfflineMsgRequest = var_0_0.Message(var_0_1.DELETEOFFLINEMSGREQUEST_MSG)
var_0_1.GetReportTypeReply = var_0_0.Message(var_0_1.GETREPORTTYPEREPLY_MSG)
var_0_1.GetReportTypeRequest = var_0_0.Message(var_0_1.GETREPORTTYPEREQUEST_MSG)
var_0_1.ReportReply = var_0_0.Message(var_0_1.REPORTREPLY_MSG)
var_0_1.ReportRequest = var_0_0.Message(var_0_1.REPORTREQUEST_MSG)
var_0_1.ReportType = var_0_0.Message(var_0_1.REPORTTYPE_MSG)
var_0_1.SendMsgReply = var_0_0.Message(var_0_1.SENDMSGREPLY_MSG)
var_0_1.SendMsgRequest = var_0_0.Message(var_0_1.SENDMSGREQUEST_MSG)
var_0_1.WordTestReply = var_0_0.Message(var_0_1.WORDTESTREPLY_MSG)
var_0_1.WordTestRequest = var_0_0.Message(var_0_1.WORDTESTREQUEST_MSG)

return var_0_1
