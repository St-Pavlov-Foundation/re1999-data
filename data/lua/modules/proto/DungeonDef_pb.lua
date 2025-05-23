﻿local var_0_0 = require("protobuf.protobuf")

module("modules.proto.DungeonDef_pb", package.seeall)

local var_0_1 = {
	USERCHAPTERTYPENUM_MSG = var_0_0.Descriptor(),
	USERCHAPTERTYPENUMCHAPTERTYPEFIELD = var_0_0.FieldDescriptor(),
	USERCHAPTERTYPENUMTODAYPASSNUMFIELD = var_0_0.FieldDescriptor(),
	USERCHAPTERTYPENUMTODAYTOTALNUMFIELD = var_0_0.FieldDescriptor(),
	USERDUNGEONSPSTATUS_MSG = var_0_0.Descriptor(),
	USERDUNGEONSPSTATUSCHAPTERIDFIELD = var_0_0.FieldDescriptor(),
	USERDUNGEONSPSTATUSEPISODEIDFIELD = var_0_0.FieldDescriptor(),
	USERDUNGEONSPSTATUSSTATUSFIELD = var_0_0.FieldDescriptor(),
	USERDUNGEONSPSTATUSREFRESHTIMEFIELD = var_0_0.FieldDescriptor(),
	USERDUNGEON_MSG = var_0_0.Descriptor(),
	USERDUNGEONCHAPTERIDFIELD = var_0_0.FieldDescriptor(),
	USERDUNGEONEPISODEIDFIELD = var_0_0.FieldDescriptor(),
	USERDUNGEONSTARFIELD = var_0_0.FieldDescriptor(),
	USERDUNGEONCHALLENGECOUNTFIELD = var_0_0.FieldDescriptor(),
	USERDUNGEONHASRECORDFIELD = var_0_0.FieldDescriptor(),
	USERDUNGEONLEFTRETURNALLNUMFIELD = var_0_0.FieldDescriptor(),
	USERDUNGEONTODAYPASSNUMFIELD = var_0_0.FieldDescriptor(),
	USERDUNGEONTODAYTOTALNUMFIELD = var_0_0.FieldDescriptor()
}

var_0_1.USERCHAPTERTYPENUMCHAPTERTYPEFIELD.name = "chapterType"
var_0_1.USERCHAPTERTYPENUMCHAPTERTYPEFIELD.full_name = ".UserChapterTypeNum.chapterType"
var_0_1.USERCHAPTERTYPENUMCHAPTERTYPEFIELD.number = 1
var_0_1.USERCHAPTERTYPENUMCHAPTERTYPEFIELD.index = 0
var_0_1.USERCHAPTERTYPENUMCHAPTERTYPEFIELD.label = 1
var_0_1.USERCHAPTERTYPENUMCHAPTERTYPEFIELD.has_default_value = false
var_0_1.USERCHAPTERTYPENUMCHAPTERTYPEFIELD.default_value = 0
var_0_1.USERCHAPTERTYPENUMCHAPTERTYPEFIELD.type = 5
var_0_1.USERCHAPTERTYPENUMCHAPTERTYPEFIELD.cpp_type = 1
var_0_1.USERCHAPTERTYPENUMTODAYPASSNUMFIELD.name = "todayPassNum"
var_0_1.USERCHAPTERTYPENUMTODAYPASSNUMFIELD.full_name = ".UserChapterTypeNum.todayPassNum"
var_0_1.USERCHAPTERTYPENUMTODAYPASSNUMFIELD.number = 2
var_0_1.USERCHAPTERTYPENUMTODAYPASSNUMFIELD.index = 1
var_0_1.USERCHAPTERTYPENUMTODAYPASSNUMFIELD.label = 1
var_0_1.USERCHAPTERTYPENUMTODAYPASSNUMFIELD.has_default_value = false
var_0_1.USERCHAPTERTYPENUMTODAYPASSNUMFIELD.default_value = 0
var_0_1.USERCHAPTERTYPENUMTODAYPASSNUMFIELD.type = 5
var_0_1.USERCHAPTERTYPENUMTODAYPASSNUMFIELD.cpp_type = 1
var_0_1.USERCHAPTERTYPENUMTODAYTOTALNUMFIELD.name = "todayTotalNum"
var_0_1.USERCHAPTERTYPENUMTODAYTOTALNUMFIELD.full_name = ".UserChapterTypeNum.todayTotalNum"
var_0_1.USERCHAPTERTYPENUMTODAYTOTALNUMFIELD.number = 3
var_0_1.USERCHAPTERTYPENUMTODAYTOTALNUMFIELD.index = 2
var_0_1.USERCHAPTERTYPENUMTODAYTOTALNUMFIELD.label = 1
var_0_1.USERCHAPTERTYPENUMTODAYTOTALNUMFIELD.has_default_value = false
var_0_1.USERCHAPTERTYPENUMTODAYTOTALNUMFIELD.default_value = 0
var_0_1.USERCHAPTERTYPENUMTODAYTOTALNUMFIELD.type = 5
var_0_1.USERCHAPTERTYPENUMTODAYTOTALNUMFIELD.cpp_type = 1
var_0_1.USERCHAPTERTYPENUM_MSG.name = "UserChapterTypeNum"
var_0_1.USERCHAPTERTYPENUM_MSG.full_name = ".UserChapterTypeNum"
var_0_1.USERCHAPTERTYPENUM_MSG.nested_types = {}
var_0_1.USERCHAPTERTYPENUM_MSG.enum_types = {}
var_0_1.USERCHAPTERTYPENUM_MSG.fields = {
	var_0_1.USERCHAPTERTYPENUMCHAPTERTYPEFIELD,
	var_0_1.USERCHAPTERTYPENUMTODAYPASSNUMFIELD,
	var_0_1.USERCHAPTERTYPENUMTODAYTOTALNUMFIELD
}
var_0_1.USERCHAPTERTYPENUM_MSG.is_extendable = false
var_0_1.USERCHAPTERTYPENUM_MSG.extensions = {}
var_0_1.USERDUNGEONSPSTATUSCHAPTERIDFIELD.name = "chapterId"
var_0_1.USERDUNGEONSPSTATUSCHAPTERIDFIELD.full_name = ".UserDungeonSpStatus.chapterId"
var_0_1.USERDUNGEONSPSTATUSCHAPTERIDFIELD.number = 1
var_0_1.USERDUNGEONSPSTATUSCHAPTERIDFIELD.index = 0
var_0_1.USERDUNGEONSPSTATUSCHAPTERIDFIELD.label = 1
var_0_1.USERDUNGEONSPSTATUSCHAPTERIDFIELD.has_default_value = false
var_0_1.USERDUNGEONSPSTATUSCHAPTERIDFIELD.default_value = 0
var_0_1.USERDUNGEONSPSTATUSCHAPTERIDFIELD.type = 5
var_0_1.USERDUNGEONSPSTATUSCHAPTERIDFIELD.cpp_type = 1
var_0_1.USERDUNGEONSPSTATUSEPISODEIDFIELD.name = "episodeId"
var_0_1.USERDUNGEONSPSTATUSEPISODEIDFIELD.full_name = ".UserDungeonSpStatus.episodeId"
var_0_1.USERDUNGEONSPSTATUSEPISODEIDFIELD.number = 2
var_0_1.USERDUNGEONSPSTATUSEPISODEIDFIELD.index = 1
var_0_1.USERDUNGEONSPSTATUSEPISODEIDFIELD.label = 1
var_0_1.USERDUNGEONSPSTATUSEPISODEIDFIELD.has_default_value = false
var_0_1.USERDUNGEONSPSTATUSEPISODEIDFIELD.default_value = 0
var_0_1.USERDUNGEONSPSTATUSEPISODEIDFIELD.type = 5
var_0_1.USERDUNGEONSPSTATUSEPISODEIDFIELD.cpp_type = 1
var_0_1.USERDUNGEONSPSTATUSSTATUSFIELD.name = "status"
var_0_1.USERDUNGEONSPSTATUSSTATUSFIELD.full_name = ".UserDungeonSpStatus.status"
var_0_1.USERDUNGEONSPSTATUSSTATUSFIELD.number = 3
var_0_1.USERDUNGEONSPSTATUSSTATUSFIELD.index = 2
var_0_1.USERDUNGEONSPSTATUSSTATUSFIELD.label = 1
var_0_1.USERDUNGEONSPSTATUSSTATUSFIELD.has_default_value = false
var_0_1.USERDUNGEONSPSTATUSSTATUSFIELD.default_value = 0
var_0_1.USERDUNGEONSPSTATUSSTATUSFIELD.type = 5
var_0_1.USERDUNGEONSPSTATUSSTATUSFIELD.cpp_type = 1
var_0_1.USERDUNGEONSPSTATUSREFRESHTIMEFIELD.name = "refreshTime"
var_0_1.USERDUNGEONSPSTATUSREFRESHTIMEFIELD.full_name = ".UserDungeonSpStatus.refreshTime"
var_0_1.USERDUNGEONSPSTATUSREFRESHTIMEFIELD.number = 4
var_0_1.USERDUNGEONSPSTATUSREFRESHTIMEFIELD.index = 3
var_0_1.USERDUNGEONSPSTATUSREFRESHTIMEFIELD.label = 1
var_0_1.USERDUNGEONSPSTATUSREFRESHTIMEFIELD.has_default_value = false
var_0_1.USERDUNGEONSPSTATUSREFRESHTIMEFIELD.default_value = 0
var_0_1.USERDUNGEONSPSTATUSREFRESHTIMEFIELD.type = 4
var_0_1.USERDUNGEONSPSTATUSREFRESHTIMEFIELD.cpp_type = 4
var_0_1.USERDUNGEONSPSTATUS_MSG.name = "UserDungeonSpStatus"
var_0_1.USERDUNGEONSPSTATUS_MSG.full_name = ".UserDungeonSpStatus"
var_0_1.USERDUNGEONSPSTATUS_MSG.nested_types = {}
var_0_1.USERDUNGEONSPSTATUS_MSG.enum_types = {}
var_0_1.USERDUNGEONSPSTATUS_MSG.fields = {
	var_0_1.USERDUNGEONSPSTATUSCHAPTERIDFIELD,
	var_0_1.USERDUNGEONSPSTATUSEPISODEIDFIELD,
	var_0_1.USERDUNGEONSPSTATUSSTATUSFIELD,
	var_0_1.USERDUNGEONSPSTATUSREFRESHTIMEFIELD
}
var_0_1.USERDUNGEONSPSTATUS_MSG.is_extendable = false
var_0_1.USERDUNGEONSPSTATUS_MSG.extensions = {}
var_0_1.USERDUNGEONCHAPTERIDFIELD.name = "chapterId"
var_0_1.USERDUNGEONCHAPTERIDFIELD.full_name = ".UserDungeon.chapterId"
var_0_1.USERDUNGEONCHAPTERIDFIELD.number = 1
var_0_1.USERDUNGEONCHAPTERIDFIELD.index = 0
var_0_1.USERDUNGEONCHAPTERIDFIELD.label = 1
var_0_1.USERDUNGEONCHAPTERIDFIELD.has_default_value = false
var_0_1.USERDUNGEONCHAPTERIDFIELD.default_value = 0
var_0_1.USERDUNGEONCHAPTERIDFIELD.type = 5
var_0_1.USERDUNGEONCHAPTERIDFIELD.cpp_type = 1
var_0_1.USERDUNGEONEPISODEIDFIELD.name = "episodeId"
var_0_1.USERDUNGEONEPISODEIDFIELD.full_name = ".UserDungeon.episodeId"
var_0_1.USERDUNGEONEPISODEIDFIELD.number = 2
var_0_1.USERDUNGEONEPISODEIDFIELD.index = 1
var_0_1.USERDUNGEONEPISODEIDFIELD.label = 1
var_0_1.USERDUNGEONEPISODEIDFIELD.has_default_value = false
var_0_1.USERDUNGEONEPISODEIDFIELD.default_value = 0
var_0_1.USERDUNGEONEPISODEIDFIELD.type = 5
var_0_1.USERDUNGEONEPISODEIDFIELD.cpp_type = 1
var_0_1.USERDUNGEONSTARFIELD.name = "star"
var_0_1.USERDUNGEONSTARFIELD.full_name = ".UserDungeon.star"
var_0_1.USERDUNGEONSTARFIELD.number = 3
var_0_1.USERDUNGEONSTARFIELD.index = 2
var_0_1.USERDUNGEONSTARFIELD.label = 1
var_0_1.USERDUNGEONSTARFIELD.has_default_value = false
var_0_1.USERDUNGEONSTARFIELD.default_value = 0
var_0_1.USERDUNGEONSTARFIELD.type = 5
var_0_1.USERDUNGEONSTARFIELD.cpp_type = 1
var_0_1.USERDUNGEONCHALLENGECOUNTFIELD.name = "challengeCount"
var_0_1.USERDUNGEONCHALLENGECOUNTFIELD.full_name = ".UserDungeon.challengeCount"
var_0_1.USERDUNGEONCHALLENGECOUNTFIELD.number = 4
var_0_1.USERDUNGEONCHALLENGECOUNTFIELD.index = 3
var_0_1.USERDUNGEONCHALLENGECOUNTFIELD.label = 1
var_0_1.USERDUNGEONCHALLENGECOUNTFIELD.has_default_value = false
var_0_1.USERDUNGEONCHALLENGECOUNTFIELD.default_value = 0
var_0_1.USERDUNGEONCHALLENGECOUNTFIELD.type = 5
var_0_1.USERDUNGEONCHALLENGECOUNTFIELD.cpp_type = 1
var_0_1.USERDUNGEONHASRECORDFIELD.name = "hasRecord"
var_0_1.USERDUNGEONHASRECORDFIELD.full_name = ".UserDungeon.hasRecord"
var_0_1.USERDUNGEONHASRECORDFIELD.number = 5
var_0_1.USERDUNGEONHASRECORDFIELD.index = 4
var_0_1.USERDUNGEONHASRECORDFIELD.label = 1
var_0_1.USERDUNGEONHASRECORDFIELD.has_default_value = false
var_0_1.USERDUNGEONHASRECORDFIELD.default_value = false
var_0_1.USERDUNGEONHASRECORDFIELD.type = 8
var_0_1.USERDUNGEONHASRECORDFIELD.cpp_type = 7
var_0_1.USERDUNGEONLEFTRETURNALLNUMFIELD.name = "leftReturnAllNum"
var_0_1.USERDUNGEONLEFTRETURNALLNUMFIELD.full_name = ".UserDungeon.leftReturnAllNum"
var_0_1.USERDUNGEONLEFTRETURNALLNUMFIELD.number = 6
var_0_1.USERDUNGEONLEFTRETURNALLNUMFIELD.index = 5
var_0_1.USERDUNGEONLEFTRETURNALLNUMFIELD.label = 1
var_0_1.USERDUNGEONLEFTRETURNALLNUMFIELD.has_default_value = false
var_0_1.USERDUNGEONLEFTRETURNALLNUMFIELD.default_value = 0
var_0_1.USERDUNGEONLEFTRETURNALLNUMFIELD.type = 5
var_0_1.USERDUNGEONLEFTRETURNALLNUMFIELD.cpp_type = 1
var_0_1.USERDUNGEONTODAYPASSNUMFIELD.name = "todayPassNum"
var_0_1.USERDUNGEONTODAYPASSNUMFIELD.full_name = ".UserDungeon.todayPassNum"
var_0_1.USERDUNGEONTODAYPASSNUMFIELD.number = 7
var_0_1.USERDUNGEONTODAYPASSNUMFIELD.index = 6
var_0_1.USERDUNGEONTODAYPASSNUMFIELD.label = 1
var_0_1.USERDUNGEONTODAYPASSNUMFIELD.has_default_value = false
var_0_1.USERDUNGEONTODAYPASSNUMFIELD.default_value = 0
var_0_1.USERDUNGEONTODAYPASSNUMFIELD.type = 5
var_0_1.USERDUNGEONTODAYPASSNUMFIELD.cpp_type = 1
var_0_1.USERDUNGEONTODAYTOTALNUMFIELD.name = "todayTotalNum"
var_0_1.USERDUNGEONTODAYTOTALNUMFIELD.full_name = ".UserDungeon.todayTotalNum"
var_0_1.USERDUNGEONTODAYTOTALNUMFIELD.number = 8
var_0_1.USERDUNGEONTODAYTOTALNUMFIELD.index = 7
var_0_1.USERDUNGEONTODAYTOTALNUMFIELD.label = 1
var_0_1.USERDUNGEONTODAYTOTALNUMFIELD.has_default_value = false
var_0_1.USERDUNGEONTODAYTOTALNUMFIELD.default_value = 0
var_0_1.USERDUNGEONTODAYTOTALNUMFIELD.type = 5
var_0_1.USERDUNGEONTODAYTOTALNUMFIELD.cpp_type = 1
var_0_1.USERDUNGEON_MSG.name = "UserDungeon"
var_0_1.USERDUNGEON_MSG.full_name = ".UserDungeon"
var_0_1.USERDUNGEON_MSG.nested_types = {}
var_0_1.USERDUNGEON_MSG.enum_types = {}
var_0_1.USERDUNGEON_MSG.fields = {
	var_0_1.USERDUNGEONCHAPTERIDFIELD,
	var_0_1.USERDUNGEONEPISODEIDFIELD,
	var_0_1.USERDUNGEONSTARFIELD,
	var_0_1.USERDUNGEONCHALLENGECOUNTFIELD,
	var_0_1.USERDUNGEONHASRECORDFIELD,
	var_0_1.USERDUNGEONLEFTRETURNALLNUMFIELD,
	var_0_1.USERDUNGEONTODAYPASSNUMFIELD,
	var_0_1.USERDUNGEONTODAYTOTALNUMFIELD
}
var_0_1.USERDUNGEON_MSG.is_extendable = false
var_0_1.USERDUNGEON_MSG.extensions = {}
var_0_1.UserChapterTypeNum = var_0_0.Message(var_0_1.USERCHAPTERTYPENUM_MSG)
var_0_1.UserDungeon = var_0_0.Message(var_0_1.USERDUNGEON_MSG)
var_0_1.UserDungeonSpStatus = var_0_0.Message(var_0_1.USERDUNGEONSPSTATUS_MSG)

return var_0_1
