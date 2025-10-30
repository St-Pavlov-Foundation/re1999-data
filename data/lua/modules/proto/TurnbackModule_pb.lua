﻿-- chunkname: @modules/proto/TurnbackModule_pb.lua

local require = require
local protobuf = require("protobuf.protobuf")

module("modules.proto.TurnbackModule_pb", package.seeall)

local TurnbackModule_pb = {}

TurnbackModule_pb.TASKMODULE_PB = require("modules.proto.TaskModule_pb")
TurnbackModule_pb.MATERIALMODULE_PB = require("modules.proto.MaterialModule_pb")
TurnbackModule_pb.TURNBACKINFO_MSG = protobuf.Descriptor()
TurnbackModule_pb.TURNBACKINFOIDFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKINFOTASKSFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKINFOBONUSPOINTFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKINFOFIRSTSHOWFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKINFOHASGETTASKBONUSFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKINFOSIGNINDAYFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKINFOSIGNININFOSFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKINFOONCEBONUSFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKINFOENDTIMEFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKINFOSTARTTIMEFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKINFOREMAINADDITIONCOUNTFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKINFOLEAVETIMEFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKINFOMONTHCARDADDEDBUYCOUNTFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKINFOVERSIONFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKINFOBUYDOUBLEBONUSFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKINFODROPINFOSFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKINFOGETDAILYBONUSFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKBONUSPOINTREPLY_MSG = protobuf.Descriptor()
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYIDFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYBONUSPOINTIDFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKONCEBONUSREPLY_MSG = protobuf.Descriptor()
TurnbackModule_pb.TURNBACKONCEBONUSREPLYIDFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKONCEBONUSREQUEST_MSG = protobuf.Descriptor()
TurnbackModule_pb.TURNBACKONCEBONUSREQUESTIDFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKSIGNININFO_MSG = protobuf.Descriptor()
TurnbackModule_pb.TURNBACKSIGNININFOIDFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKSIGNININFOSTATEFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKFIRSTSHOWREPLY_MSG = protobuf.Descriptor()
TurnbackModule_pb.TURNBACKFIRSTSHOWREPLYIDFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.GETTURNBACKDAILYBONUSREQUEST_MSG = protobuf.Descriptor()
TurnbackModule_pb.GETTURNBACKDAILYBONUSREQUESTIDFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKADDITIONPUSH_MSG = protobuf.Descriptor()
TurnbackModule_pb.TURNBACKADDITIONPUSHIDFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKADDITIONPUSHREMAINADDITIONCOUNTFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKSIGNINREQUEST_MSG = protobuf.Descriptor()
TurnbackModule_pb.TURNBACKSIGNINREQUESTIDFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKSIGNINREQUESTDAYFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.DROPINFO_MSG = protobuf.Descriptor()
TurnbackModule_pb.DROPINFOTYPEFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.DROPINFOTOTALNUMFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.DROPINFOCURRENTNUMFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKBONUSPOINTREQUEST_MSG = protobuf.Descriptor()
TurnbackModule_pb.TURNBACKBONUSPOINTREQUESTIDFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKBONUSPOINTREQUESTBONUSPOINTIDFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLY_MSG = protobuf.Descriptor()
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLYIDFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.GETTURNBACKINFOREQUEST_MSG = protobuf.Descriptor()
TurnbackModule_pb.GETTURNBACKINFOREPLY_MSG = protobuf.Descriptor()
TurnbackModule_pb.GETTURNBACKINFOREPLYINFOFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLY_MSG = protobuf.Descriptor()
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLYIDFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLYDAYFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.REFRESHONLINETASKREQUEST_MSG = protobuf.Descriptor()
TurnbackModule_pb.REFRESHONLINETASKREQUESTIDFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKFIRSTSHOWREQUEST_MSG = protobuf.Descriptor()
TurnbackModule_pb.TURNBACKFIRSTSHOWREQUESTIDFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREQUEST_MSG = protobuf.Descriptor()
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREQUESTIDFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKSIGNINREPLY_MSG = protobuf.Descriptor()
TurnbackModule_pb.TURNBACKSIGNINREPLYIDFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKSIGNINREPLYDAYFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.BUYDOUBLEBONUSREQUEST_MSG = protobuf.Descriptor()
TurnbackModule_pb.BUYDOUBLEBONUSREQUESTIDFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.REFRESHONLINETASKREPLY_MSG = protobuf.Descriptor()
TurnbackModule_pb.REFRESHONLINETASKREPLYIDFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.BUYDOUBLEBONUSREPLY_MSG = protobuf.Descriptor()
TurnbackModule_pb.BUYDOUBLEBONUSREPLYIDFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.BUYDOUBLEBONUSREPLYHASGETDOUBLETASKBONUSFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD = protobuf.FieldDescriptor()
TurnbackModule_pb.TURNBACKINFOIDFIELD.name = "id"
TurnbackModule_pb.TURNBACKINFOIDFIELD.full_name = ".TurnbackInfo.id"
TurnbackModule_pb.TURNBACKINFOIDFIELD.number = 1
TurnbackModule_pb.TURNBACKINFOIDFIELD.index = 0
TurnbackModule_pb.TURNBACKINFOIDFIELD.label = 1
TurnbackModule_pb.TURNBACKINFOIDFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKINFOIDFIELD.default_value = 0
TurnbackModule_pb.TURNBACKINFOIDFIELD.type = 5
TurnbackModule_pb.TURNBACKINFOIDFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKINFOTASKSFIELD.name = "tasks"
TurnbackModule_pb.TURNBACKINFOTASKSFIELD.full_name = ".TurnbackInfo.tasks"
TurnbackModule_pb.TURNBACKINFOTASKSFIELD.number = 2
TurnbackModule_pb.TURNBACKINFOTASKSFIELD.index = 1
TurnbackModule_pb.TURNBACKINFOTASKSFIELD.label = 3
TurnbackModule_pb.TURNBACKINFOTASKSFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKINFOTASKSFIELD.default_value = {}
TurnbackModule_pb.TURNBACKINFOTASKSFIELD.message_type = TurnbackModule_pb.TASKMODULE_PB.TASK_MSG
TurnbackModule_pb.TURNBACKINFOTASKSFIELD.type = 11
TurnbackModule_pb.TURNBACKINFOTASKSFIELD.cpp_type = 10
TurnbackModule_pb.TURNBACKINFOBONUSPOINTFIELD.name = "bonusPoint"
TurnbackModule_pb.TURNBACKINFOBONUSPOINTFIELD.full_name = ".TurnbackInfo.bonusPoint"
TurnbackModule_pb.TURNBACKINFOBONUSPOINTFIELD.number = 3
TurnbackModule_pb.TURNBACKINFOBONUSPOINTFIELD.index = 2
TurnbackModule_pb.TURNBACKINFOBONUSPOINTFIELD.label = 1
TurnbackModule_pb.TURNBACKINFOBONUSPOINTFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKINFOBONUSPOINTFIELD.default_value = 0
TurnbackModule_pb.TURNBACKINFOBONUSPOINTFIELD.type = 5
TurnbackModule_pb.TURNBACKINFOBONUSPOINTFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKINFOFIRSTSHOWFIELD.name = "firstShow"
TurnbackModule_pb.TURNBACKINFOFIRSTSHOWFIELD.full_name = ".TurnbackInfo.firstShow"
TurnbackModule_pb.TURNBACKINFOFIRSTSHOWFIELD.number = 4
TurnbackModule_pb.TURNBACKINFOFIRSTSHOWFIELD.index = 3
TurnbackModule_pb.TURNBACKINFOFIRSTSHOWFIELD.label = 1
TurnbackModule_pb.TURNBACKINFOFIRSTSHOWFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKINFOFIRSTSHOWFIELD.default_value = false
TurnbackModule_pb.TURNBACKINFOFIRSTSHOWFIELD.type = 8
TurnbackModule_pb.TURNBACKINFOFIRSTSHOWFIELD.cpp_type = 7
TurnbackModule_pb.TURNBACKINFOHASGETTASKBONUSFIELD.name = "hasGetTaskBonus"
TurnbackModule_pb.TURNBACKINFOHASGETTASKBONUSFIELD.full_name = ".TurnbackInfo.hasGetTaskBonus"
TurnbackModule_pb.TURNBACKINFOHASGETTASKBONUSFIELD.number = 5
TurnbackModule_pb.TURNBACKINFOHASGETTASKBONUSFIELD.index = 4
TurnbackModule_pb.TURNBACKINFOHASGETTASKBONUSFIELD.label = 3
TurnbackModule_pb.TURNBACKINFOHASGETTASKBONUSFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKINFOHASGETTASKBONUSFIELD.default_value = {}
TurnbackModule_pb.TURNBACKINFOHASGETTASKBONUSFIELD.type = 5
TurnbackModule_pb.TURNBACKINFOHASGETTASKBONUSFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKINFOSIGNINDAYFIELD.name = "signInDay"
TurnbackModule_pb.TURNBACKINFOSIGNINDAYFIELD.full_name = ".TurnbackInfo.signInDay"
TurnbackModule_pb.TURNBACKINFOSIGNINDAYFIELD.number = 6
TurnbackModule_pb.TURNBACKINFOSIGNINDAYFIELD.index = 5
TurnbackModule_pb.TURNBACKINFOSIGNINDAYFIELD.label = 1
TurnbackModule_pb.TURNBACKINFOSIGNINDAYFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKINFOSIGNINDAYFIELD.default_value = 0
TurnbackModule_pb.TURNBACKINFOSIGNINDAYFIELD.type = 5
TurnbackModule_pb.TURNBACKINFOSIGNINDAYFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKINFOSIGNININFOSFIELD.name = "signInInfos"
TurnbackModule_pb.TURNBACKINFOSIGNININFOSFIELD.full_name = ".TurnbackInfo.signInInfos"
TurnbackModule_pb.TURNBACKINFOSIGNININFOSFIELD.number = 7
TurnbackModule_pb.TURNBACKINFOSIGNININFOSFIELD.index = 6
TurnbackModule_pb.TURNBACKINFOSIGNININFOSFIELD.label = 3
TurnbackModule_pb.TURNBACKINFOSIGNININFOSFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKINFOSIGNININFOSFIELD.default_value = {}
TurnbackModule_pb.TURNBACKINFOSIGNININFOSFIELD.message_type = TurnbackModule_pb.TURNBACKSIGNININFO_MSG
TurnbackModule_pb.TURNBACKINFOSIGNININFOSFIELD.type = 11
TurnbackModule_pb.TURNBACKINFOSIGNININFOSFIELD.cpp_type = 10
TurnbackModule_pb.TURNBACKINFOONCEBONUSFIELD.name = "onceBonus"
TurnbackModule_pb.TURNBACKINFOONCEBONUSFIELD.full_name = ".TurnbackInfo.onceBonus"
TurnbackModule_pb.TURNBACKINFOONCEBONUSFIELD.number = 8
TurnbackModule_pb.TURNBACKINFOONCEBONUSFIELD.index = 7
TurnbackModule_pb.TURNBACKINFOONCEBONUSFIELD.label = 1
TurnbackModule_pb.TURNBACKINFOONCEBONUSFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKINFOONCEBONUSFIELD.default_value = false
TurnbackModule_pb.TURNBACKINFOONCEBONUSFIELD.type = 8
TurnbackModule_pb.TURNBACKINFOONCEBONUSFIELD.cpp_type = 7
TurnbackModule_pb.TURNBACKINFOENDTIMEFIELD.name = "endTime"
TurnbackModule_pb.TURNBACKINFOENDTIMEFIELD.full_name = ".TurnbackInfo.endTime"
TurnbackModule_pb.TURNBACKINFOENDTIMEFIELD.number = 9
TurnbackModule_pb.TURNBACKINFOENDTIMEFIELD.index = 8
TurnbackModule_pb.TURNBACKINFOENDTIMEFIELD.label = 1
TurnbackModule_pb.TURNBACKINFOENDTIMEFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKINFOENDTIMEFIELD.default_value = 0
TurnbackModule_pb.TURNBACKINFOENDTIMEFIELD.type = 5
TurnbackModule_pb.TURNBACKINFOENDTIMEFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKINFOSTARTTIMEFIELD.name = "startTime"
TurnbackModule_pb.TURNBACKINFOSTARTTIMEFIELD.full_name = ".TurnbackInfo.startTime"
TurnbackModule_pb.TURNBACKINFOSTARTTIMEFIELD.number = 10
TurnbackModule_pb.TURNBACKINFOSTARTTIMEFIELD.index = 9
TurnbackModule_pb.TURNBACKINFOSTARTTIMEFIELD.label = 1
TurnbackModule_pb.TURNBACKINFOSTARTTIMEFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKINFOSTARTTIMEFIELD.default_value = 0
TurnbackModule_pb.TURNBACKINFOSTARTTIMEFIELD.type = 5
TurnbackModule_pb.TURNBACKINFOSTARTTIMEFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKINFOREMAINADDITIONCOUNTFIELD.name = "remainAdditionCount"
TurnbackModule_pb.TURNBACKINFOREMAINADDITIONCOUNTFIELD.full_name = ".TurnbackInfo.remainAdditionCount"
TurnbackModule_pb.TURNBACKINFOREMAINADDITIONCOUNTFIELD.number = 11
TurnbackModule_pb.TURNBACKINFOREMAINADDITIONCOUNTFIELD.index = 10
TurnbackModule_pb.TURNBACKINFOREMAINADDITIONCOUNTFIELD.label = 1
TurnbackModule_pb.TURNBACKINFOREMAINADDITIONCOUNTFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKINFOREMAINADDITIONCOUNTFIELD.default_value = 0
TurnbackModule_pb.TURNBACKINFOREMAINADDITIONCOUNTFIELD.type = 5
TurnbackModule_pb.TURNBACKINFOREMAINADDITIONCOUNTFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKINFOLEAVETIMEFIELD.name = "leaveTime"
TurnbackModule_pb.TURNBACKINFOLEAVETIMEFIELD.full_name = ".TurnbackInfo.leaveTime"
TurnbackModule_pb.TURNBACKINFOLEAVETIMEFIELD.number = 12
TurnbackModule_pb.TURNBACKINFOLEAVETIMEFIELD.index = 11
TurnbackModule_pb.TURNBACKINFOLEAVETIMEFIELD.label = 1
TurnbackModule_pb.TURNBACKINFOLEAVETIMEFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKINFOLEAVETIMEFIELD.default_value = 0
TurnbackModule_pb.TURNBACKINFOLEAVETIMEFIELD.type = 5
TurnbackModule_pb.TURNBACKINFOLEAVETIMEFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKINFOMONTHCARDADDEDBUYCOUNTFIELD.name = "monthCardAddedBuyCount"
TurnbackModule_pb.TURNBACKINFOMONTHCARDADDEDBUYCOUNTFIELD.full_name = ".TurnbackInfo.monthCardAddedBuyCount"
TurnbackModule_pb.TURNBACKINFOMONTHCARDADDEDBUYCOUNTFIELD.number = 13
TurnbackModule_pb.TURNBACKINFOMONTHCARDADDEDBUYCOUNTFIELD.index = 12
TurnbackModule_pb.TURNBACKINFOMONTHCARDADDEDBUYCOUNTFIELD.label = 1
TurnbackModule_pb.TURNBACKINFOMONTHCARDADDEDBUYCOUNTFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKINFOMONTHCARDADDEDBUYCOUNTFIELD.default_value = 0
TurnbackModule_pb.TURNBACKINFOMONTHCARDADDEDBUYCOUNTFIELD.type = 5
TurnbackModule_pb.TURNBACKINFOMONTHCARDADDEDBUYCOUNTFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKINFOVERSIONFIELD.name = "version"
TurnbackModule_pb.TURNBACKINFOVERSIONFIELD.full_name = ".TurnbackInfo.version"
TurnbackModule_pb.TURNBACKINFOVERSIONFIELD.number = 14
TurnbackModule_pb.TURNBACKINFOVERSIONFIELD.index = 13
TurnbackModule_pb.TURNBACKINFOVERSIONFIELD.label = 1
TurnbackModule_pb.TURNBACKINFOVERSIONFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKINFOVERSIONFIELD.default_value = 0
TurnbackModule_pb.TURNBACKINFOVERSIONFIELD.type = 5
TurnbackModule_pb.TURNBACKINFOVERSIONFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKINFOBUYDOUBLEBONUSFIELD.name = "buyDoubleBonus"
TurnbackModule_pb.TURNBACKINFOBUYDOUBLEBONUSFIELD.full_name = ".TurnbackInfo.buyDoubleBonus"
TurnbackModule_pb.TURNBACKINFOBUYDOUBLEBONUSFIELD.number = 15
TurnbackModule_pb.TURNBACKINFOBUYDOUBLEBONUSFIELD.index = 14
TurnbackModule_pb.TURNBACKINFOBUYDOUBLEBONUSFIELD.label = 1
TurnbackModule_pb.TURNBACKINFOBUYDOUBLEBONUSFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKINFOBUYDOUBLEBONUSFIELD.default_value = false
TurnbackModule_pb.TURNBACKINFOBUYDOUBLEBONUSFIELD.type = 8
TurnbackModule_pb.TURNBACKINFOBUYDOUBLEBONUSFIELD.cpp_type = 7
TurnbackModule_pb.TURNBACKINFODROPINFOSFIELD.name = "dropInfos"
TurnbackModule_pb.TURNBACKINFODROPINFOSFIELD.full_name = ".TurnbackInfo.dropInfos"
TurnbackModule_pb.TURNBACKINFODROPINFOSFIELD.number = 16
TurnbackModule_pb.TURNBACKINFODROPINFOSFIELD.index = 15
TurnbackModule_pb.TURNBACKINFODROPINFOSFIELD.label = 3
TurnbackModule_pb.TURNBACKINFODROPINFOSFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKINFODROPINFOSFIELD.default_value = {}
TurnbackModule_pb.TURNBACKINFODROPINFOSFIELD.message_type = TurnbackModule_pb.DROPINFO_MSG
TurnbackModule_pb.TURNBACKINFODROPINFOSFIELD.type = 11
TurnbackModule_pb.TURNBACKINFODROPINFOSFIELD.cpp_type = 10
TurnbackModule_pb.TURNBACKINFOGETDAILYBONUSFIELD.name = "getDailyBonus"
TurnbackModule_pb.TURNBACKINFOGETDAILYBONUSFIELD.full_name = ".TurnbackInfo.getDailyBonus"
TurnbackModule_pb.TURNBACKINFOGETDAILYBONUSFIELD.number = 17
TurnbackModule_pb.TURNBACKINFOGETDAILYBONUSFIELD.index = 16
TurnbackModule_pb.TURNBACKINFOGETDAILYBONUSFIELD.label = 1
TurnbackModule_pb.TURNBACKINFOGETDAILYBONUSFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKINFOGETDAILYBONUSFIELD.default_value = 0
TurnbackModule_pb.TURNBACKINFOGETDAILYBONUSFIELD.type = 5
TurnbackModule_pb.TURNBACKINFOGETDAILYBONUSFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKINFO_MSG.name = "TurnbackInfo"
TurnbackModule_pb.TURNBACKINFO_MSG.full_name = ".TurnbackInfo"
TurnbackModule_pb.TURNBACKINFO_MSG.nested_types = {}
TurnbackModule_pb.TURNBACKINFO_MSG.enum_types = {}
TurnbackModule_pb.TURNBACKINFO_MSG.fields = {
	TurnbackModule_pb.TURNBACKINFOIDFIELD,
	TurnbackModule_pb.TURNBACKINFOTASKSFIELD,
	TurnbackModule_pb.TURNBACKINFOBONUSPOINTFIELD,
	TurnbackModule_pb.TURNBACKINFOFIRSTSHOWFIELD,
	TurnbackModule_pb.TURNBACKINFOHASGETTASKBONUSFIELD,
	TurnbackModule_pb.TURNBACKINFOSIGNINDAYFIELD,
	TurnbackModule_pb.TURNBACKINFOSIGNININFOSFIELD,
	TurnbackModule_pb.TURNBACKINFOONCEBONUSFIELD,
	TurnbackModule_pb.TURNBACKINFOENDTIMEFIELD,
	TurnbackModule_pb.TURNBACKINFOSTARTTIMEFIELD,
	TurnbackModule_pb.TURNBACKINFOREMAINADDITIONCOUNTFIELD,
	TurnbackModule_pb.TURNBACKINFOLEAVETIMEFIELD,
	TurnbackModule_pb.TURNBACKINFOMONTHCARDADDEDBUYCOUNTFIELD,
	TurnbackModule_pb.TURNBACKINFOVERSIONFIELD,
	TurnbackModule_pb.TURNBACKINFOBUYDOUBLEBONUSFIELD,
	TurnbackModule_pb.TURNBACKINFODROPINFOSFIELD,
	TurnbackModule_pb.TURNBACKINFOGETDAILYBONUSFIELD
}
TurnbackModule_pb.TURNBACKINFO_MSG.is_extendable = false
TurnbackModule_pb.TURNBACKINFO_MSG.extensions = {}
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYIDFIELD.name = "id"
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYIDFIELD.full_name = ".TurnbackBonusPointReply.id"
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYIDFIELD.number = 1
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYIDFIELD.index = 0
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYIDFIELD.label = 1
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYIDFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYIDFIELD.default_value = 0
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYIDFIELD.type = 5
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYIDFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYBONUSPOINTIDFIELD.name = "bonusPointId"
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYBONUSPOINTIDFIELD.full_name = ".TurnbackBonusPointReply.bonusPointId"
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYBONUSPOINTIDFIELD.number = 2
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYBONUSPOINTIDFIELD.index = 1
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYBONUSPOINTIDFIELD.label = 1
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYBONUSPOINTIDFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYBONUSPOINTIDFIELD.default_value = 0
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYBONUSPOINTIDFIELD.type = 5
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYBONUSPOINTIDFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.name = "hasGetTaskBonus"
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.full_name = ".TurnbackBonusPointReply.hasGetTaskBonus"
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.number = 3
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.index = 2
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.label = 3
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.default_value = {}
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.type = 5
TurnbackModule_pb.TURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKBONUSPOINTREPLY_MSG.name = "TurnbackBonusPointReply"
TurnbackModule_pb.TURNBACKBONUSPOINTREPLY_MSG.full_name = ".TurnbackBonusPointReply"
TurnbackModule_pb.TURNBACKBONUSPOINTREPLY_MSG.nested_types = {}
TurnbackModule_pb.TURNBACKBONUSPOINTREPLY_MSG.enum_types = {}
TurnbackModule_pb.TURNBACKBONUSPOINTREPLY_MSG.fields = {
	TurnbackModule_pb.TURNBACKBONUSPOINTREPLYIDFIELD,
	TurnbackModule_pb.TURNBACKBONUSPOINTREPLYBONUSPOINTIDFIELD,
	TurnbackModule_pb.TURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD
}
TurnbackModule_pb.TURNBACKBONUSPOINTREPLY_MSG.is_extendable = false
TurnbackModule_pb.TURNBACKBONUSPOINTREPLY_MSG.extensions = {}
TurnbackModule_pb.TURNBACKONCEBONUSREPLYIDFIELD.name = "id"
TurnbackModule_pb.TURNBACKONCEBONUSREPLYIDFIELD.full_name = ".TurnbackOnceBonusReply.id"
TurnbackModule_pb.TURNBACKONCEBONUSREPLYIDFIELD.number = 1
TurnbackModule_pb.TURNBACKONCEBONUSREPLYIDFIELD.index = 0
TurnbackModule_pb.TURNBACKONCEBONUSREPLYIDFIELD.label = 1
TurnbackModule_pb.TURNBACKONCEBONUSREPLYIDFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKONCEBONUSREPLYIDFIELD.default_value = 0
TurnbackModule_pb.TURNBACKONCEBONUSREPLYIDFIELD.type = 5
TurnbackModule_pb.TURNBACKONCEBONUSREPLYIDFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKONCEBONUSREPLY_MSG.name = "TurnbackOnceBonusReply"
TurnbackModule_pb.TURNBACKONCEBONUSREPLY_MSG.full_name = ".TurnbackOnceBonusReply"
TurnbackModule_pb.TURNBACKONCEBONUSREPLY_MSG.nested_types = {}
TurnbackModule_pb.TURNBACKONCEBONUSREPLY_MSG.enum_types = {}
TurnbackModule_pb.TURNBACKONCEBONUSREPLY_MSG.fields = {
	TurnbackModule_pb.TURNBACKONCEBONUSREPLYIDFIELD
}
TurnbackModule_pb.TURNBACKONCEBONUSREPLY_MSG.is_extendable = false
TurnbackModule_pb.TURNBACKONCEBONUSREPLY_MSG.extensions = {}
TurnbackModule_pb.TURNBACKONCEBONUSREQUESTIDFIELD.name = "id"
TurnbackModule_pb.TURNBACKONCEBONUSREQUESTIDFIELD.full_name = ".TurnbackOnceBonusRequest.id"
TurnbackModule_pb.TURNBACKONCEBONUSREQUESTIDFIELD.number = 1
TurnbackModule_pb.TURNBACKONCEBONUSREQUESTIDFIELD.index = 0
TurnbackModule_pb.TURNBACKONCEBONUSREQUESTIDFIELD.label = 1
TurnbackModule_pb.TURNBACKONCEBONUSREQUESTIDFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKONCEBONUSREQUESTIDFIELD.default_value = 0
TurnbackModule_pb.TURNBACKONCEBONUSREQUESTIDFIELD.type = 5
TurnbackModule_pb.TURNBACKONCEBONUSREQUESTIDFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKONCEBONUSREQUEST_MSG.name = "TurnbackOnceBonusRequest"
TurnbackModule_pb.TURNBACKONCEBONUSREQUEST_MSG.full_name = ".TurnbackOnceBonusRequest"
TurnbackModule_pb.TURNBACKONCEBONUSREQUEST_MSG.nested_types = {}
TurnbackModule_pb.TURNBACKONCEBONUSREQUEST_MSG.enum_types = {}
TurnbackModule_pb.TURNBACKONCEBONUSREQUEST_MSG.fields = {
	TurnbackModule_pb.TURNBACKONCEBONUSREQUESTIDFIELD
}
TurnbackModule_pb.TURNBACKONCEBONUSREQUEST_MSG.is_extendable = false
TurnbackModule_pb.TURNBACKONCEBONUSREQUEST_MSG.extensions = {}
TurnbackModule_pb.TURNBACKSIGNININFOIDFIELD.name = "id"
TurnbackModule_pb.TURNBACKSIGNININFOIDFIELD.full_name = ".TurnbackSignInInfo.id"
TurnbackModule_pb.TURNBACKSIGNININFOIDFIELD.number = 1
TurnbackModule_pb.TURNBACKSIGNININFOIDFIELD.index = 0
TurnbackModule_pb.TURNBACKSIGNININFOIDFIELD.label = 1
TurnbackModule_pb.TURNBACKSIGNININFOIDFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKSIGNININFOIDFIELD.default_value = 0
TurnbackModule_pb.TURNBACKSIGNININFOIDFIELD.type = 5
TurnbackModule_pb.TURNBACKSIGNININFOIDFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKSIGNININFOSTATEFIELD.name = "state"
TurnbackModule_pb.TURNBACKSIGNININFOSTATEFIELD.full_name = ".TurnbackSignInInfo.state"
TurnbackModule_pb.TURNBACKSIGNININFOSTATEFIELD.number = 2
TurnbackModule_pb.TURNBACKSIGNININFOSTATEFIELD.index = 1
TurnbackModule_pb.TURNBACKSIGNININFOSTATEFIELD.label = 1
TurnbackModule_pb.TURNBACKSIGNININFOSTATEFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKSIGNININFOSTATEFIELD.default_value = 0
TurnbackModule_pb.TURNBACKSIGNININFOSTATEFIELD.type = 5
TurnbackModule_pb.TURNBACKSIGNININFOSTATEFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKSIGNININFO_MSG.name = "TurnbackSignInInfo"
TurnbackModule_pb.TURNBACKSIGNININFO_MSG.full_name = ".TurnbackSignInInfo"
TurnbackModule_pb.TURNBACKSIGNININFO_MSG.nested_types = {}
TurnbackModule_pb.TURNBACKSIGNININFO_MSG.enum_types = {}
TurnbackModule_pb.TURNBACKSIGNININFO_MSG.fields = {
	TurnbackModule_pb.TURNBACKSIGNININFOIDFIELD,
	TurnbackModule_pb.TURNBACKSIGNININFOSTATEFIELD
}
TurnbackModule_pb.TURNBACKSIGNININFO_MSG.is_extendable = false
TurnbackModule_pb.TURNBACKSIGNININFO_MSG.extensions = {}
TurnbackModule_pb.TURNBACKFIRSTSHOWREPLYIDFIELD.name = "id"
TurnbackModule_pb.TURNBACKFIRSTSHOWREPLYIDFIELD.full_name = ".TurnbackFirstShowReply.id"
TurnbackModule_pb.TURNBACKFIRSTSHOWREPLYIDFIELD.number = 1
TurnbackModule_pb.TURNBACKFIRSTSHOWREPLYIDFIELD.index = 0
TurnbackModule_pb.TURNBACKFIRSTSHOWREPLYIDFIELD.label = 1
TurnbackModule_pb.TURNBACKFIRSTSHOWREPLYIDFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKFIRSTSHOWREPLYIDFIELD.default_value = 0
TurnbackModule_pb.TURNBACKFIRSTSHOWREPLYIDFIELD.type = 5
TurnbackModule_pb.TURNBACKFIRSTSHOWREPLYIDFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKFIRSTSHOWREPLY_MSG.name = "TurnbackFirstShowReply"
TurnbackModule_pb.TURNBACKFIRSTSHOWREPLY_MSG.full_name = ".TurnbackFirstShowReply"
TurnbackModule_pb.TURNBACKFIRSTSHOWREPLY_MSG.nested_types = {}
TurnbackModule_pb.TURNBACKFIRSTSHOWREPLY_MSG.enum_types = {}
TurnbackModule_pb.TURNBACKFIRSTSHOWREPLY_MSG.fields = {
	TurnbackModule_pb.TURNBACKFIRSTSHOWREPLYIDFIELD
}
TurnbackModule_pb.TURNBACKFIRSTSHOWREPLY_MSG.is_extendable = false
TurnbackModule_pb.TURNBACKFIRSTSHOWREPLY_MSG.extensions = {}
TurnbackModule_pb.GETTURNBACKDAILYBONUSREQUESTIDFIELD.name = "id"
TurnbackModule_pb.GETTURNBACKDAILYBONUSREQUESTIDFIELD.full_name = ".GetTurnbackDailyBonusRequest.id"
TurnbackModule_pb.GETTURNBACKDAILYBONUSREQUESTIDFIELD.number = 1
TurnbackModule_pb.GETTURNBACKDAILYBONUSREQUESTIDFIELD.index = 0
TurnbackModule_pb.GETTURNBACKDAILYBONUSREQUESTIDFIELD.label = 1
TurnbackModule_pb.GETTURNBACKDAILYBONUSREQUESTIDFIELD.has_default_value = false
TurnbackModule_pb.GETTURNBACKDAILYBONUSREQUESTIDFIELD.default_value = 0
TurnbackModule_pb.GETTURNBACKDAILYBONUSREQUESTIDFIELD.type = 5
TurnbackModule_pb.GETTURNBACKDAILYBONUSREQUESTIDFIELD.cpp_type = 1
TurnbackModule_pb.GETTURNBACKDAILYBONUSREQUEST_MSG.name = "GetTurnbackDailyBonusRequest"
TurnbackModule_pb.GETTURNBACKDAILYBONUSREQUEST_MSG.full_name = ".GetTurnbackDailyBonusRequest"
TurnbackModule_pb.GETTURNBACKDAILYBONUSREQUEST_MSG.nested_types = {}
TurnbackModule_pb.GETTURNBACKDAILYBONUSREQUEST_MSG.enum_types = {}
TurnbackModule_pb.GETTURNBACKDAILYBONUSREQUEST_MSG.fields = {
	TurnbackModule_pb.GETTURNBACKDAILYBONUSREQUESTIDFIELD
}
TurnbackModule_pb.GETTURNBACKDAILYBONUSREQUEST_MSG.is_extendable = false
TurnbackModule_pb.GETTURNBACKDAILYBONUSREQUEST_MSG.extensions = {}
TurnbackModule_pb.TURNBACKADDITIONPUSHIDFIELD.name = "id"
TurnbackModule_pb.TURNBACKADDITIONPUSHIDFIELD.full_name = ".TurnbackAdditionPush.id"
TurnbackModule_pb.TURNBACKADDITIONPUSHIDFIELD.number = 1
TurnbackModule_pb.TURNBACKADDITIONPUSHIDFIELD.index = 0
TurnbackModule_pb.TURNBACKADDITIONPUSHIDFIELD.label = 1
TurnbackModule_pb.TURNBACKADDITIONPUSHIDFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKADDITIONPUSHIDFIELD.default_value = 0
TurnbackModule_pb.TURNBACKADDITIONPUSHIDFIELD.type = 5
TurnbackModule_pb.TURNBACKADDITIONPUSHIDFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKADDITIONPUSHREMAINADDITIONCOUNTFIELD.name = "remainAdditionCount"
TurnbackModule_pb.TURNBACKADDITIONPUSHREMAINADDITIONCOUNTFIELD.full_name = ".TurnbackAdditionPush.remainAdditionCount"
TurnbackModule_pb.TURNBACKADDITIONPUSHREMAINADDITIONCOUNTFIELD.number = 2
TurnbackModule_pb.TURNBACKADDITIONPUSHREMAINADDITIONCOUNTFIELD.index = 1
TurnbackModule_pb.TURNBACKADDITIONPUSHREMAINADDITIONCOUNTFIELD.label = 1
TurnbackModule_pb.TURNBACKADDITIONPUSHREMAINADDITIONCOUNTFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKADDITIONPUSHREMAINADDITIONCOUNTFIELD.default_value = 0
TurnbackModule_pb.TURNBACKADDITIONPUSHREMAINADDITIONCOUNTFIELD.type = 5
TurnbackModule_pb.TURNBACKADDITIONPUSHREMAINADDITIONCOUNTFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKADDITIONPUSH_MSG.name = "TurnbackAdditionPush"
TurnbackModule_pb.TURNBACKADDITIONPUSH_MSG.full_name = ".TurnbackAdditionPush"
TurnbackModule_pb.TURNBACKADDITIONPUSH_MSG.nested_types = {}
TurnbackModule_pb.TURNBACKADDITIONPUSH_MSG.enum_types = {}
TurnbackModule_pb.TURNBACKADDITIONPUSH_MSG.fields = {
	TurnbackModule_pb.TURNBACKADDITIONPUSHIDFIELD,
	TurnbackModule_pb.TURNBACKADDITIONPUSHREMAINADDITIONCOUNTFIELD
}
TurnbackModule_pb.TURNBACKADDITIONPUSH_MSG.is_extendable = false
TurnbackModule_pb.TURNBACKADDITIONPUSH_MSG.extensions = {}
TurnbackModule_pb.TURNBACKSIGNINREQUESTIDFIELD.name = "id"
TurnbackModule_pb.TURNBACKSIGNINREQUESTIDFIELD.full_name = ".TurnbackSignInRequest.id"
TurnbackModule_pb.TURNBACKSIGNINREQUESTIDFIELD.number = 1
TurnbackModule_pb.TURNBACKSIGNINREQUESTIDFIELD.index = 0
TurnbackModule_pb.TURNBACKSIGNINREQUESTIDFIELD.label = 1
TurnbackModule_pb.TURNBACKSIGNINREQUESTIDFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKSIGNINREQUESTIDFIELD.default_value = 0
TurnbackModule_pb.TURNBACKSIGNINREQUESTIDFIELD.type = 5
TurnbackModule_pb.TURNBACKSIGNINREQUESTIDFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKSIGNINREQUESTDAYFIELD.name = "day"
TurnbackModule_pb.TURNBACKSIGNINREQUESTDAYFIELD.full_name = ".TurnbackSignInRequest.day"
TurnbackModule_pb.TURNBACKSIGNINREQUESTDAYFIELD.number = 2
TurnbackModule_pb.TURNBACKSIGNINREQUESTDAYFIELD.index = 1
TurnbackModule_pb.TURNBACKSIGNINREQUESTDAYFIELD.label = 1
TurnbackModule_pb.TURNBACKSIGNINREQUESTDAYFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKSIGNINREQUESTDAYFIELD.default_value = 0
TurnbackModule_pb.TURNBACKSIGNINREQUESTDAYFIELD.type = 5
TurnbackModule_pb.TURNBACKSIGNINREQUESTDAYFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKSIGNINREQUEST_MSG.name = "TurnbackSignInRequest"
TurnbackModule_pb.TURNBACKSIGNINREQUEST_MSG.full_name = ".TurnbackSignInRequest"
TurnbackModule_pb.TURNBACKSIGNINREQUEST_MSG.nested_types = {}
TurnbackModule_pb.TURNBACKSIGNINREQUEST_MSG.enum_types = {}
TurnbackModule_pb.TURNBACKSIGNINREQUEST_MSG.fields = {
	TurnbackModule_pb.TURNBACKSIGNINREQUESTIDFIELD,
	TurnbackModule_pb.TURNBACKSIGNINREQUESTDAYFIELD
}
TurnbackModule_pb.TURNBACKSIGNINREQUEST_MSG.is_extendable = false
TurnbackModule_pb.TURNBACKSIGNINREQUEST_MSG.extensions = {}
TurnbackModule_pb.DROPINFOTYPEFIELD.name = "type"
TurnbackModule_pb.DROPINFOTYPEFIELD.full_name = ".DropInfo.type"
TurnbackModule_pb.DROPINFOTYPEFIELD.number = 1
TurnbackModule_pb.DROPINFOTYPEFIELD.index = 0
TurnbackModule_pb.DROPINFOTYPEFIELD.label = 1
TurnbackModule_pb.DROPINFOTYPEFIELD.has_default_value = false
TurnbackModule_pb.DROPINFOTYPEFIELD.default_value = 0
TurnbackModule_pb.DROPINFOTYPEFIELD.type = 5
TurnbackModule_pb.DROPINFOTYPEFIELD.cpp_type = 1
TurnbackModule_pb.DROPINFOTOTALNUMFIELD.name = "totalNum"
TurnbackModule_pb.DROPINFOTOTALNUMFIELD.full_name = ".DropInfo.totalNum"
TurnbackModule_pb.DROPINFOTOTALNUMFIELD.number = 2
TurnbackModule_pb.DROPINFOTOTALNUMFIELD.index = 1
TurnbackModule_pb.DROPINFOTOTALNUMFIELD.label = 1
TurnbackModule_pb.DROPINFOTOTALNUMFIELD.has_default_value = false
TurnbackModule_pb.DROPINFOTOTALNUMFIELD.default_value = 0
TurnbackModule_pb.DROPINFOTOTALNUMFIELD.type = 5
TurnbackModule_pb.DROPINFOTOTALNUMFIELD.cpp_type = 1
TurnbackModule_pb.DROPINFOCURRENTNUMFIELD.name = "currentNum"
TurnbackModule_pb.DROPINFOCURRENTNUMFIELD.full_name = ".DropInfo.currentNum"
TurnbackModule_pb.DROPINFOCURRENTNUMFIELD.number = 3
TurnbackModule_pb.DROPINFOCURRENTNUMFIELD.index = 2
TurnbackModule_pb.DROPINFOCURRENTNUMFIELD.label = 1
TurnbackModule_pb.DROPINFOCURRENTNUMFIELD.has_default_value = false
TurnbackModule_pb.DROPINFOCURRENTNUMFIELD.default_value = 0
TurnbackModule_pb.DROPINFOCURRENTNUMFIELD.type = 5
TurnbackModule_pb.DROPINFOCURRENTNUMFIELD.cpp_type = 1
TurnbackModule_pb.DROPINFO_MSG.name = "DropInfo"
TurnbackModule_pb.DROPINFO_MSG.full_name = ".DropInfo"
TurnbackModule_pb.DROPINFO_MSG.nested_types = {}
TurnbackModule_pb.DROPINFO_MSG.enum_types = {}
TurnbackModule_pb.DROPINFO_MSG.fields = {
	TurnbackModule_pb.DROPINFOTYPEFIELD,
	TurnbackModule_pb.DROPINFOTOTALNUMFIELD,
	TurnbackModule_pb.DROPINFOCURRENTNUMFIELD
}
TurnbackModule_pb.DROPINFO_MSG.is_extendable = false
TurnbackModule_pb.DROPINFO_MSG.extensions = {}
TurnbackModule_pb.TURNBACKBONUSPOINTREQUESTIDFIELD.name = "id"
TurnbackModule_pb.TURNBACKBONUSPOINTREQUESTIDFIELD.full_name = ".TurnbackBonusPointRequest.id"
TurnbackModule_pb.TURNBACKBONUSPOINTREQUESTIDFIELD.number = 1
TurnbackModule_pb.TURNBACKBONUSPOINTREQUESTIDFIELD.index = 0
TurnbackModule_pb.TURNBACKBONUSPOINTREQUESTIDFIELD.label = 1
TurnbackModule_pb.TURNBACKBONUSPOINTREQUESTIDFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKBONUSPOINTREQUESTIDFIELD.default_value = 0
TurnbackModule_pb.TURNBACKBONUSPOINTREQUESTIDFIELD.type = 5
TurnbackModule_pb.TURNBACKBONUSPOINTREQUESTIDFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKBONUSPOINTREQUESTBONUSPOINTIDFIELD.name = "bonusPointId"
TurnbackModule_pb.TURNBACKBONUSPOINTREQUESTBONUSPOINTIDFIELD.full_name = ".TurnbackBonusPointRequest.bonusPointId"
TurnbackModule_pb.TURNBACKBONUSPOINTREQUESTBONUSPOINTIDFIELD.number = 2
TurnbackModule_pb.TURNBACKBONUSPOINTREQUESTBONUSPOINTIDFIELD.index = 1
TurnbackModule_pb.TURNBACKBONUSPOINTREQUESTBONUSPOINTIDFIELD.label = 1
TurnbackModule_pb.TURNBACKBONUSPOINTREQUESTBONUSPOINTIDFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKBONUSPOINTREQUESTBONUSPOINTIDFIELD.default_value = 0
TurnbackModule_pb.TURNBACKBONUSPOINTREQUESTBONUSPOINTIDFIELD.type = 5
TurnbackModule_pb.TURNBACKBONUSPOINTREQUESTBONUSPOINTIDFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKBONUSPOINTREQUEST_MSG.name = "TurnbackBonusPointRequest"
TurnbackModule_pb.TURNBACKBONUSPOINTREQUEST_MSG.full_name = ".TurnbackBonusPointRequest"
TurnbackModule_pb.TURNBACKBONUSPOINTREQUEST_MSG.nested_types = {}
TurnbackModule_pb.TURNBACKBONUSPOINTREQUEST_MSG.enum_types = {}
TurnbackModule_pb.TURNBACKBONUSPOINTREQUEST_MSG.fields = {
	TurnbackModule_pb.TURNBACKBONUSPOINTREQUESTIDFIELD,
	TurnbackModule_pb.TURNBACKBONUSPOINTREQUESTBONUSPOINTIDFIELD
}
TurnbackModule_pb.TURNBACKBONUSPOINTREQUEST_MSG.is_extendable = false
TurnbackModule_pb.TURNBACKBONUSPOINTREQUEST_MSG.extensions = {}
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLYIDFIELD.name = "id"
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLYIDFIELD.full_name = ".AcceptAllTurnbackBonusPointReply.id"
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLYIDFIELD.number = 1
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLYIDFIELD.index = 0
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLYIDFIELD.label = 1
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLYIDFIELD.has_default_value = false
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLYIDFIELD.default_value = 0
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLYIDFIELD.type = 5
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLYIDFIELD.cpp_type = 1
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.name = "hasGetTaskBonus"
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.full_name = ".AcceptAllTurnbackBonusPointReply.hasGetTaskBonus"
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.number = 2
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.index = 1
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.label = 3
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.has_default_value = false
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.default_value = {}
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.type = 5
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.cpp_type = 1
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLY_MSG.name = "AcceptAllTurnbackBonusPointReply"
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLY_MSG.full_name = ".AcceptAllTurnbackBonusPointReply"
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLY_MSG.nested_types = {}
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLY_MSG.enum_types = {}
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLY_MSG.fields = {
	TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLYIDFIELD,
	TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD
}
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLY_MSG.is_extendable = false
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLY_MSG.extensions = {}
TurnbackModule_pb.GETTURNBACKINFOREQUEST_MSG.name = "GetTurnbackInfoRequest"
TurnbackModule_pb.GETTURNBACKINFOREQUEST_MSG.full_name = ".GetTurnbackInfoRequest"
TurnbackModule_pb.GETTURNBACKINFOREQUEST_MSG.nested_types = {}
TurnbackModule_pb.GETTURNBACKINFOREQUEST_MSG.enum_types = {}
TurnbackModule_pb.GETTURNBACKINFOREQUEST_MSG.fields = {}
TurnbackModule_pb.GETTURNBACKINFOREQUEST_MSG.is_extendable = false
TurnbackModule_pb.GETTURNBACKINFOREQUEST_MSG.extensions = {}
TurnbackModule_pb.GETTURNBACKINFOREPLYINFOFIELD.name = "info"
TurnbackModule_pb.GETTURNBACKINFOREPLYINFOFIELD.full_name = ".GetTurnbackInfoReply.info"
TurnbackModule_pb.GETTURNBACKINFOREPLYINFOFIELD.number = 1
TurnbackModule_pb.GETTURNBACKINFOREPLYINFOFIELD.index = 0
TurnbackModule_pb.GETTURNBACKINFOREPLYINFOFIELD.label = 1
TurnbackModule_pb.GETTURNBACKINFOREPLYINFOFIELD.has_default_value = false
TurnbackModule_pb.GETTURNBACKINFOREPLYINFOFIELD.default_value = nil
TurnbackModule_pb.GETTURNBACKINFOREPLYINFOFIELD.message_type = TurnbackModule_pb.TURNBACKINFO_MSG
TurnbackModule_pb.GETTURNBACKINFOREPLYINFOFIELD.type = 11
TurnbackModule_pb.GETTURNBACKINFOREPLYINFOFIELD.cpp_type = 10
TurnbackModule_pb.GETTURNBACKINFOREPLY_MSG.name = "GetTurnbackInfoReply"
TurnbackModule_pb.GETTURNBACKINFOREPLY_MSG.full_name = ".GetTurnbackInfoReply"
TurnbackModule_pb.GETTURNBACKINFOREPLY_MSG.nested_types = {}
TurnbackModule_pb.GETTURNBACKINFOREPLY_MSG.enum_types = {}
TurnbackModule_pb.GETTURNBACKINFOREPLY_MSG.fields = {
	TurnbackModule_pb.GETTURNBACKINFOREPLYINFOFIELD
}
TurnbackModule_pb.GETTURNBACKINFOREPLY_MSG.is_extendable = false
TurnbackModule_pb.GETTURNBACKINFOREPLY_MSG.extensions = {}
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLYIDFIELD.name = "id"
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLYIDFIELD.full_name = ".GetTurnbackDailyBonusReply.id"
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLYIDFIELD.number = 1
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLYIDFIELD.index = 0
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLYIDFIELD.label = 1
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLYIDFIELD.has_default_value = false
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLYIDFIELD.default_value = 0
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLYIDFIELD.type = 5
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLYIDFIELD.cpp_type = 1
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLYDAYFIELD.name = "day"
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLYDAYFIELD.full_name = ".GetTurnbackDailyBonusReply.day"
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLYDAYFIELD.number = 2
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLYDAYFIELD.index = 1
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLYDAYFIELD.label = 1
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLYDAYFIELD.has_default_value = false
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLYDAYFIELD.default_value = 0
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLYDAYFIELD.type = 5
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLYDAYFIELD.cpp_type = 1
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLY_MSG.name = "GetTurnbackDailyBonusReply"
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLY_MSG.full_name = ".GetTurnbackDailyBonusReply"
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLY_MSG.nested_types = {}
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLY_MSG.enum_types = {}
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLY_MSG.fields = {
	TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLYIDFIELD,
	TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLYDAYFIELD
}
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLY_MSG.is_extendable = false
TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLY_MSG.extensions = {}
TurnbackModule_pb.REFRESHONLINETASKREQUESTIDFIELD.name = "id"
TurnbackModule_pb.REFRESHONLINETASKREQUESTIDFIELD.full_name = ".RefreshOnlineTaskRequest.id"
TurnbackModule_pb.REFRESHONLINETASKREQUESTIDFIELD.number = 1
TurnbackModule_pb.REFRESHONLINETASKREQUESTIDFIELD.index = 0
TurnbackModule_pb.REFRESHONLINETASKREQUESTIDFIELD.label = 1
TurnbackModule_pb.REFRESHONLINETASKREQUESTIDFIELD.has_default_value = false
TurnbackModule_pb.REFRESHONLINETASKREQUESTIDFIELD.default_value = 0
TurnbackModule_pb.REFRESHONLINETASKREQUESTIDFIELD.type = 5
TurnbackModule_pb.REFRESHONLINETASKREQUESTIDFIELD.cpp_type = 1
TurnbackModule_pb.REFRESHONLINETASKREQUEST_MSG.name = "RefreshOnlineTaskRequest"
TurnbackModule_pb.REFRESHONLINETASKREQUEST_MSG.full_name = ".RefreshOnlineTaskRequest"
TurnbackModule_pb.REFRESHONLINETASKREQUEST_MSG.nested_types = {}
TurnbackModule_pb.REFRESHONLINETASKREQUEST_MSG.enum_types = {}
TurnbackModule_pb.REFRESHONLINETASKREQUEST_MSG.fields = {
	TurnbackModule_pb.REFRESHONLINETASKREQUESTIDFIELD
}
TurnbackModule_pb.REFRESHONLINETASKREQUEST_MSG.is_extendable = false
TurnbackModule_pb.REFRESHONLINETASKREQUEST_MSG.extensions = {}
TurnbackModule_pb.TURNBACKFIRSTSHOWREQUESTIDFIELD.name = "id"
TurnbackModule_pb.TURNBACKFIRSTSHOWREQUESTIDFIELD.full_name = ".TurnbackFirstShowRequest.id"
TurnbackModule_pb.TURNBACKFIRSTSHOWREQUESTIDFIELD.number = 1
TurnbackModule_pb.TURNBACKFIRSTSHOWREQUESTIDFIELD.index = 0
TurnbackModule_pb.TURNBACKFIRSTSHOWREQUESTIDFIELD.label = 1
TurnbackModule_pb.TURNBACKFIRSTSHOWREQUESTIDFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKFIRSTSHOWREQUESTIDFIELD.default_value = 0
TurnbackModule_pb.TURNBACKFIRSTSHOWREQUESTIDFIELD.type = 5
TurnbackModule_pb.TURNBACKFIRSTSHOWREQUESTIDFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKFIRSTSHOWREQUEST_MSG.name = "TurnbackFirstShowRequest"
TurnbackModule_pb.TURNBACKFIRSTSHOWREQUEST_MSG.full_name = ".TurnbackFirstShowRequest"
TurnbackModule_pb.TURNBACKFIRSTSHOWREQUEST_MSG.nested_types = {}
TurnbackModule_pb.TURNBACKFIRSTSHOWREQUEST_MSG.enum_types = {}
TurnbackModule_pb.TURNBACKFIRSTSHOWREQUEST_MSG.fields = {
	TurnbackModule_pb.TURNBACKFIRSTSHOWREQUESTIDFIELD
}
TurnbackModule_pb.TURNBACKFIRSTSHOWREQUEST_MSG.is_extendable = false
TurnbackModule_pb.TURNBACKFIRSTSHOWREQUEST_MSG.extensions = {}
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREQUESTIDFIELD.name = "id"
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREQUESTIDFIELD.full_name = ".AcceptAllTurnbackBonusPointRequest.id"
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREQUESTIDFIELD.number = 1
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREQUESTIDFIELD.index = 0
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREQUESTIDFIELD.label = 1
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREQUESTIDFIELD.has_default_value = false
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREQUESTIDFIELD.default_value = 0
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREQUESTIDFIELD.type = 5
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREQUESTIDFIELD.cpp_type = 1
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREQUEST_MSG.name = "AcceptAllTurnbackBonusPointRequest"
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREQUEST_MSG.full_name = ".AcceptAllTurnbackBonusPointRequest"
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREQUEST_MSG.nested_types = {}
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREQUEST_MSG.enum_types = {}
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREQUEST_MSG.fields = {
	TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREQUESTIDFIELD
}
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREQUEST_MSG.is_extendable = false
TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREQUEST_MSG.extensions = {}
TurnbackModule_pb.TURNBACKSIGNINREPLYIDFIELD.name = "id"
TurnbackModule_pb.TURNBACKSIGNINREPLYIDFIELD.full_name = ".TurnbackSignInReply.id"
TurnbackModule_pb.TURNBACKSIGNINREPLYIDFIELD.number = 1
TurnbackModule_pb.TURNBACKSIGNINREPLYIDFIELD.index = 0
TurnbackModule_pb.TURNBACKSIGNINREPLYIDFIELD.label = 1
TurnbackModule_pb.TURNBACKSIGNINREPLYIDFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKSIGNINREPLYIDFIELD.default_value = 0
TurnbackModule_pb.TURNBACKSIGNINREPLYIDFIELD.type = 5
TurnbackModule_pb.TURNBACKSIGNINREPLYIDFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKSIGNINREPLYDAYFIELD.name = "day"
TurnbackModule_pb.TURNBACKSIGNINREPLYDAYFIELD.full_name = ".TurnbackSignInReply.day"
TurnbackModule_pb.TURNBACKSIGNINREPLYDAYFIELD.number = 2
TurnbackModule_pb.TURNBACKSIGNINREPLYDAYFIELD.index = 1
TurnbackModule_pb.TURNBACKSIGNINREPLYDAYFIELD.label = 1
TurnbackModule_pb.TURNBACKSIGNINREPLYDAYFIELD.has_default_value = false
TurnbackModule_pb.TURNBACKSIGNINREPLYDAYFIELD.default_value = 0
TurnbackModule_pb.TURNBACKSIGNINREPLYDAYFIELD.type = 5
TurnbackModule_pb.TURNBACKSIGNINREPLYDAYFIELD.cpp_type = 1
TurnbackModule_pb.TURNBACKSIGNINREPLY_MSG.name = "TurnbackSignInReply"
TurnbackModule_pb.TURNBACKSIGNINREPLY_MSG.full_name = ".TurnbackSignInReply"
TurnbackModule_pb.TURNBACKSIGNINREPLY_MSG.nested_types = {}
TurnbackModule_pb.TURNBACKSIGNINREPLY_MSG.enum_types = {}
TurnbackModule_pb.TURNBACKSIGNINREPLY_MSG.fields = {
	TurnbackModule_pb.TURNBACKSIGNINREPLYIDFIELD,
	TurnbackModule_pb.TURNBACKSIGNINREPLYDAYFIELD
}
TurnbackModule_pb.TURNBACKSIGNINREPLY_MSG.is_extendable = false
TurnbackModule_pb.TURNBACKSIGNINREPLY_MSG.extensions = {}
TurnbackModule_pb.BUYDOUBLEBONUSREQUESTIDFIELD.name = "id"
TurnbackModule_pb.BUYDOUBLEBONUSREQUESTIDFIELD.full_name = ".BuyDoubleBonusRequest.id"
TurnbackModule_pb.BUYDOUBLEBONUSREQUESTIDFIELD.number = 1
TurnbackModule_pb.BUYDOUBLEBONUSREQUESTIDFIELD.index = 0
TurnbackModule_pb.BUYDOUBLEBONUSREQUESTIDFIELD.label = 1
TurnbackModule_pb.BUYDOUBLEBONUSREQUESTIDFIELD.has_default_value = false
TurnbackModule_pb.BUYDOUBLEBONUSREQUESTIDFIELD.default_value = 0
TurnbackModule_pb.BUYDOUBLEBONUSREQUESTIDFIELD.type = 5
TurnbackModule_pb.BUYDOUBLEBONUSREQUESTIDFIELD.cpp_type = 1
TurnbackModule_pb.BUYDOUBLEBONUSREQUEST_MSG.name = "BuyDoubleBonusRequest"
TurnbackModule_pb.BUYDOUBLEBONUSREQUEST_MSG.full_name = ".BuyDoubleBonusRequest"
TurnbackModule_pb.BUYDOUBLEBONUSREQUEST_MSG.nested_types = {}
TurnbackModule_pb.BUYDOUBLEBONUSREQUEST_MSG.enum_types = {}
TurnbackModule_pb.BUYDOUBLEBONUSREQUEST_MSG.fields = {
	TurnbackModule_pb.BUYDOUBLEBONUSREQUESTIDFIELD
}
TurnbackModule_pb.BUYDOUBLEBONUSREQUEST_MSG.is_extendable = false
TurnbackModule_pb.BUYDOUBLEBONUSREQUEST_MSG.extensions = {}
TurnbackModule_pb.REFRESHONLINETASKREPLYIDFIELD.name = "id"
TurnbackModule_pb.REFRESHONLINETASKREPLYIDFIELD.full_name = ".RefreshOnlineTaskReply.id"
TurnbackModule_pb.REFRESHONLINETASKREPLYIDFIELD.number = 1
TurnbackModule_pb.REFRESHONLINETASKREPLYIDFIELD.index = 0
TurnbackModule_pb.REFRESHONLINETASKREPLYIDFIELD.label = 1
TurnbackModule_pb.REFRESHONLINETASKREPLYIDFIELD.has_default_value = false
TurnbackModule_pb.REFRESHONLINETASKREPLYIDFIELD.default_value = 0
TurnbackModule_pb.REFRESHONLINETASKREPLYIDFIELD.type = 5
TurnbackModule_pb.REFRESHONLINETASKREPLYIDFIELD.cpp_type = 1
TurnbackModule_pb.REFRESHONLINETASKREPLY_MSG.name = "RefreshOnlineTaskReply"
TurnbackModule_pb.REFRESHONLINETASKREPLY_MSG.full_name = ".RefreshOnlineTaskReply"
TurnbackModule_pb.REFRESHONLINETASKREPLY_MSG.nested_types = {}
TurnbackModule_pb.REFRESHONLINETASKREPLY_MSG.enum_types = {}
TurnbackModule_pb.REFRESHONLINETASKREPLY_MSG.fields = {
	TurnbackModule_pb.REFRESHONLINETASKREPLYIDFIELD
}
TurnbackModule_pb.REFRESHONLINETASKREPLY_MSG.is_extendable = false
TurnbackModule_pb.REFRESHONLINETASKREPLY_MSG.extensions = {}
TurnbackModule_pb.BUYDOUBLEBONUSREPLYIDFIELD.name = "id"
TurnbackModule_pb.BUYDOUBLEBONUSREPLYIDFIELD.full_name = ".BuyDoubleBonusReply.id"
TurnbackModule_pb.BUYDOUBLEBONUSREPLYIDFIELD.number = 1
TurnbackModule_pb.BUYDOUBLEBONUSREPLYIDFIELD.index = 0
TurnbackModule_pb.BUYDOUBLEBONUSREPLYIDFIELD.label = 1
TurnbackModule_pb.BUYDOUBLEBONUSREPLYIDFIELD.has_default_value = false
TurnbackModule_pb.BUYDOUBLEBONUSREPLYIDFIELD.default_value = 0
TurnbackModule_pb.BUYDOUBLEBONUSREPLYIDFIELD.type = 5
TurnbackModule_pb.BUYDOUBLEBONUSREPLYIDFIELD.cpp_type = 1
TurnbackModule_pb.BUYDOUBLEBONUSREPLYHASGETDOUBLETASKBONUSFIELD.name = "hasGetDoubleTaskBonus"
TurnbackModule_pb.BUYDOUBLEBONUSREPLYHASGETDOUBLETASKBONUSFIELD.full_name = ".BuyDoubleBonusReply.hasGetDoubleTaskBonus"
TurnbackModule_pb.BUYDOUBLEBONUSREPLYHASGETDOUBLETASKBONUSFIELD.number = 2
TurnbackModule_pb.BUYDOUBLEBONUSREPLYHASGETDOUBLETASKBONUSFIELD.index = 1
TurnbackModule_pb.BUYDOUBLEBONUSREPLYHASGETDOUBLETASKBONUSFIELD.label = 3
TurnbackModule_pb.BUYDOUBLEBONUSREPLYHASGETDOUBLETASKBONUSFIELD.has_default_value = false
TurnbackModule_pb.BUYDOUBLEBONUSREPLYHASGETDOUBLETASKBONUSFIELD.default_value = {}
TurnbackModule_pb.BUYDOUBLEBONUSREPLYHASGETDOUBLETASKBONUSFIELD.type = 5
TurnbackModule_pb.BUYDOUBLEBONUSREPLYHASGETDOUBLETASKBONUSFIELD.cpp_type = 1
TurnbackModule_pb.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD.name = "doubleBonus"
TurnbackModule_pb.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD.full_name = ".BuyDoubleBonusReply.doubleBonus"
TurnbackModule_pb.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD.number = 3
TurnbackModule_pb.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD.index = 2
TurnbackModule_pb.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD.label = 3
TurnbackModule_pb.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD.has_default_value = false
TurnbackModule_pb.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD.default_value = {}
TurnbackModule_pb.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD.message_type = TurnbackModule_pb.MATERIALMODULE_PB.MATERIALDATA_MSG
TurnbackModule_pb.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD.type = 11
TurnbackModule_pb.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD.cpp_type = 10
TurnbackModule_pb.BUYDOUBLEBONUSREPLY_MSG.name = "BuyDoubleBonusReply"
TurnbackModule_pb.BUYDOUBLEBONUSREPLY_MSG.full_name = ".BuyDoubleBonusReply"
TurnbackModule_pb.BUYDOUBLEBONUSREPLY_MSG.nested_types = {}
TurnbackModule_pb.BUYDOUBLEBONUSREPLY_MSG.enum_types = {}
TurnbackModule_pb.BUYDOUBLEBONUSREPLY_MSG.fields = {
	TurnbackModule_pb.BUYDOUBLEBONUSREPLYIDFIELD,
	TurnbackModule_pb.BUYDOUBLEBONUSREPLYHASGETDOUBLETASKBONUSFIELD,
	TurnbackModule_pb.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD
}
TurnbackModule_pb.BUYDOUBLEBONUSREPLY_MSG.is_extendable = false
TurnbackModule_pb.BUYDOUBLEBONUSREPLY_MSG.extensions = {}
TurnbackModule_pb.AcceptAllTurnbackBonusPointReply = protobuf.Message(TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREPLY_MSG)
TurnbackModule_pb.AcceptAllTurnbackBonusPointRequest = protobuf.Message(TurnbackModule_pb.ACCEPTALLTURNBACKBONUSPOINTREQUEST_MSG)
TurnbackModule_pb.BuyDoubleBonusReply = protobuf.Message(TurnbackModule_pb.BUYDOUBLEBONUSREPLY_MSG)
TurnbackModule_pb.BuyDoubleBonusRequest = protobuf.Message(TurnbackModule_pb.BUYDOUBLEBONUSREQUEST_MSG)
TurnbackModule_pb.DropInfo = protobuf.Message(TurnbackModule_pb.DROPINFO_MSG)
TurnbackModule_pb.GetTurnbackDailyBonusReply = protobuf.Message(TurnbackModule_pb.GETTURNBACKDAILYBONUSREPLY_MSG)
TurnbackModule_pb.GetTurnbackDailyBonusRequest = protobuf.Message(TurnbackModule_pb.GETTURNBACKDAILYBONUSREQUEST_MSG)
TurnbackModule_pb.GetTurnbackInfoReply = protobuf.Message(TurnbackModule_pb.GETTURNBACKINFOREPLY_MSG)
TurnbackModule_pb.GetTurnbackInfoRequest = protobuf.Message(TurnbackModule_pb.GETTURNBACKINFOREQUEST_MSG)
TurnbackModule_pb.RefreshOnlineTaskReply = protobuf.Message(TurnbackModule_pb.REFRESHONLINETASKREPLY_MSG)
TurnbackModule_pb.RefreshOnlineTaskRequest = protobuf.Message(TurnbackModule_pb.REFRESHONLINETASKREQUEST_MSG)
TurnbackModule_pb.TurnbackAdditionPush = protobuf.Message(TurnbackModule_pb.TURNBACKADDITIONPUSH_MSG)
TurnbackModule_pb.TurnbackBonusPointReply = protobuf.Message(TurnbackModule_pb.TURNBACKBONUSPOINTREPLY_MSG)
TurnbackModule_pb.TurnbackBonusPointRequest = protobuf.Message(TurnbackModule_pb.TURNBACKBONUSPOINTREQUEST_MSG)
TurnbackModule_pb.TurnbackFirstShowReply = protobuf.Message(TurnbackModule_pb.TURNBACKFIRSTSHOWREPLY_MSG)
TurnbackModule_pb.TurnbackFirstShowRequest = protobuf.Message(TurnbackModule_pb.TURNBACKFIRSTSHOWREQUEST_MSG)
TurnbackModule_pb.TurnbackInfo = protobuf.Message(TurnbackModule_pb.TURNBACKINFO_MSG)
TurnbackModule_pb.TurnbackOnceBonusReply = protobuf.Message(TurnbackModule_pb.TURNBACKONCEBONUSREPLY_MSG)
TurnbackModule_pb.TurnbackOnceBonusRequest = protobuf.Message(TurnbackModule_pb.TURNBACKONCEBONUSREQUEST_MSG)
TurnbackModule_pb.TurnbackSignInInfo = protobuf.Message(TurnbackModule_pb.TURNBACKSIGNININFO_MSG)
TurnbackModule_pb.TurnbackSignInReply = protobuf.Message(TurnbackModule_pb.TURNBACKSIGNINREPLY_MSG)
TurnbackModule_pb.TurnbackSignInRequest = protobuf.Message(TurnbackModule_pb.TURNBACKSIGNINREQUEST_MSG)

return TurnbackModule_pb
