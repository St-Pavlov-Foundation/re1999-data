slot0 = require
slot1 = slot0("protobuf.protobuf")

module("modules.proto.TurnbackModule_pb", package.seeall)

slot2 = {
	TASKMODULE_PB = slot0("modules.proto.TaskModule_pb"),
	MATERIALMODULE_PB = slot0("modules.proto.MaterialModule_pb"),
	TURNBACKINFO_MSG = slot1.Descriptor(),
	TURNBACKINFOIDFIELD = slot1.FieldDescriptor(),
	TURNBACKINFOTASKSFIELD = slot1.FieldDescriptor(),
	TURNBACKINFOBONUSPOINTFIELD = slot1.FieldDescriptor(),
	TURNBACKINFOFIRSTSHOWFIELD = slot1.FieldDescriptor(),
	TURNBACKINFOHASGETTASKBONUSFIELD = slot1.FieldDescriptor(),
	TURNBACKINFOSIGNINDAYFIELD = slot1.FieldDescriptor(),
	TURNBACKINFOSIGNININFOSFIELD = slot1.FieldDescriptor(),
	TURNBACKINFOONCEBONUSFIELD = slot1.FieldDescriptor(),
	TURNBACKINFOENDTIMEFIELD = slot1.FieldDescriptor(),
	TURNBACKINFOSTARTTIMEFIELD = slot1.FieldDescriptor(),
	TURNBACKINFOREMAINADDITIONCOUNTFIELD = slot1.FieldDescriptor(),
	TURNBACKINFOLEAVETIMEFIELD = slot1.FieldDescriptor(),
	TURNBACKINFOMONTHCARDADDEDBUYCOUNTFIELD = slot1.FieldDescriptor(),
	TURNBACKINFOVERSIONFIELD = slot1.FieldDescriptor(),
	TURNBACKINFOBUYDOUBLEBONUSFIELD = slot1.FieldDescriptor(),
	TURNBACKINFODROPINFOSFIELD = slot1.FieldDescriptor(),
	TURNBACKBONUSPOINTREPLY_MSG = slot1.Descriptor(),
	TURNBACKBONUSPOINTREPLYIDFIELD = slot1.FieldDescriptor(),
	TURNBACKBONUSPOINTREPLYBONUSPOINTIDFIELD = slot1.FieldDescriptor(),
	TURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD = slot1.FieldDescriptor(),
	TURNBACKONCEBONUSREPLY_MSG = slot1.Descriptor(),
	TURNBACKONCEBONUSREPLYIDFIELD = slot1.FieldDescriptor(),
	TURNBACKONCEBONUSREQUEST_MSG = slot1.Descriptor(),
	TURNBACKONCEBONUSREQUESTIDFIELD = slot1.FieldDescriptor(),
	TURNBACKSIGNININFO_MSG = slot1.Descriptor(),
	TURNBACKSIGNININFOIDFIELD = slot1.FieldDescriptor(),
	TURNBACKSIGNININFOSTATEFIELD = slot1.FieldDescriptor(),
	TURNBACKFIRSTSHOWREPLY_MSG = slot1.Descriptor(),
	TURNBACKFIRSTSHOWREPLYIDFIELD = slot1.FieldDescriptor(),
	TURNBACKADDITIONPUSH_MSG = slot1.Descriptor(),
	TURNBACKADDITIONPUSHIDFIELD = slot1.FieldDescriptor(),
	TURNBACKADDITIONPUSHREMAINADDITIONCOUNTFIELD = slot1.FieldDescriptor(),
	TURNBACKSIGNINREQUEST_MSG = slot1.Descriptor(),
	TURNBACKSIGNINREQUESTIDFIELD = slot1.FieldDescriptor(),
	TURNBACKSIGNINREQUESTDAYFIELD = slot1.FieldDescriptor(),
	DROPINFO_MSG = slot1.Descriptor(),
	DROPINFOTYPEFIELD = slot1.FieldDescriptor(),
	DROPINFOTOTALNUMFIELD = slot1.FieldDescriptor(),
	DROPINFOCURRENTNUMFIELD = slot1.FieldDescriptor(),
	TURNBACKBONUSPOINTREQUEST_MSG = slot1.Descriptor(),
	TURNBACKBONUSPOINTREQUESTIDFIELD = slot1.FieldDescriptor(),
	TURNBACKBONUSPOINTREQUESTBONUSPOINTIDFIELD = slot1.FieldDescriptor(),
	GETTURNBACKINFOREQUEST_MSG = slot1.Descriptor(),
	GETTURNBACKINFOREPLY_MSG = slot1.Descriptor(),
	GETTURNBACKINFOREPLYINFOFIELD = slot1.FieldDescriptor(),
	REFRESHONLINETASKREQUEST_MSG = slot1.Descriptor(),
	REFRESHONLINETASKREQUESTIDFIELD = slot1.FieldDescriptor(),
	TURNBACKFIRSTSHOWREQUEST_MSG = slot1.Descriptor(),
	TURNBACKFIRSTSHOWREQUESTIDFIELD = slot1.FieldDescriptor(),
	TURNBACKSIGNINREPLY_MSG = slot1.Descriptor(),
	TURNBACKSIGNINREPLYIDFIELD = slot1.FieldDescriptor(),
	TURNBACKSIGNINREPLYDAYFIELD = slot1.FieldDescriptor(),
	BUYDOUBLEBONUSREQUEST_MSG = slot1.Descriptor(),
	BUYDOUBLEBONUSREQUESTIDFIELD = slot1.FieldDescriptor(),
	REFRESHONLINETASKREPLY_MSG = slot1.Descriptor(),
	REFRESHONLINETASKREPLYIDFIELD = slot1.FieldDescriptor(),
	BUYDOUBLEBONUSREPLY_MSG = slot1.Descriptor(),
	BUYDOUBLEBONUSREPLYIDFIELD = slot1.FieldDescriptor(),
	BUYDOUBLEBONUSREPLYHASGETDOUBLETASKBONUSFIELD = slot1.FieldDescriptor(),
	BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD = slot1.FieldDescriptor()
}
slot2.TURNBACKINFOIDFIELD.name = "id"
slot2.TURNBACKINFOIDFIELD.full_name = ".TurnbackInfo.id"
slot2.TURNBACKINFOIDFIELD.number = 1
slot2.TURNBACKINFOIDFIELD.index = 0
slot2.TURNBACKINFOIDFIELD.label = 1
slot2.TURNBACKINFOIDFIELD.has_default_value = false
slot2.TURNBACKINFOIDFIELD.default_value = 0
slot2.TURNBACKINFOIDFIELD.type = 5
slot2.TURNBACKINFOIDFIELD.cpp_type = 1
slot2.TURNBACKINFOTASKSFIELD.name = "tasks"
slot2.TURNBACKINFOTASKSFIELD.full_name = ".TurnbackInfo.tasks"
slot2.TURNBACKINFOTASKSFIELD.number = 2
slot2.TURNBACKINFOTASKSFIELD.index = 1
slot2.TURNBACKINFOTASKSFIELD.label = 3
slot2.TURNBACKINFOTASKSFIELD.has_default_value = false
slot2.TURNBACKINFOTASKSFIELD.default_value = {}
slot2.TURNBACKINFOTASKSFIELD.message_type = slot2.TASKMODULE_PB.TASK_MSG
slot2.TURNBACKINFOTASKSFIELD.type = 11
slot2.TURNBACKINFOTASKSFIELD.cpp_type = 10
slot2.TURNBACKINFOBONUSPOINTFIELD.name = "bonusPoint"
slot2.TURNBACKINFOBONUSPOINTFIELD.full_name = ".TurnbackInfo.bonusPoint"
slot2.TURNBACKINFOBONUSPOINTFIELD.number = 3
slot2.TURNBACKINFOBONUSPOINTFIELD.index = 2
slot2.TURNBACKINFOBONUSPOINTFIELD.label = 1
slot2.TURNBACKINFOBONUSPOINTFIELD.has_default_value = false
slot2.TURNBACKINFOBONUSPOINTFIELD.default_value = 0
slot2.TURNBACKINFOBONUSPOINTFIELD.type = 5
slot2.TURNBACKINFOBONUSPOINTFIELD.cpp_type = 1
slot2.TURNBACKINFOFIRSTSHOWFIELD.name = "firstShow"
slot2.TURNBACKINFOFIRSTSHOWFIELD.full_name = ".TurnbackInfo.firstShow"
slot2.TURNBACKINFOFIRSTSHOWFIELD.number = 4
slot2.TURNBACKINFOFIRSTSHOWFIELD.index = 3
slot2.TURNBACKINFOFIRSTSHOWFIELD.label = 1
slot2.TURNBACKINFOFIRSTSHOWFIELD.has_default_value = false
slot2.TURNBACKINFOFIRSTSHOWFIELD.default_value = false
slot2.TURNBACKINFOFIRSTSHOWFIELD.type = 8
slot2.TURNBACKINFOFIRSTSHOWFIELD.cpp_type = 7
slot2.TURNBACKINFOHASGETTASKBONUSFIELD.name = "hasGetTaskBonus"
slot2.TURNBACKINFOHASGETTASKBONUSFIELD.full_name = ".TurnbackInfo.hasGetTaskBonus"
slot2.TURNBACKINFOHASGETTASKBONUSFIELD.number = 5
slot2.TURNBACKINFOHASGETTASKBONUSFIELD.index = 4
slot2.TURNBACKINFOHASGETTASKBONUSFIELD.label = 3
slot2.TURNBACKINFOHASGETTASKBONUSFIELD.has_default_value = false
slot2.TURNBACKINFOHASGETTASKBONUSFIELD.default_value = {}
slot2.TURNBACKINFOHASGETTASKBONUSFIELD.type = 5
slot2.TURNBACKINFOHASGETTASKBONUSFIELD.cpp_type = 1
slot2.TURNBACKINFOSIGNINDAYFIELD.name = "signInDay"
slot2.TURNBACKINFOSIGNINDAYFIELD.full_name = ".TurnbackInfo.signInDay"
slot2.TURNBACKINFOSIGNINDAYFIELD.number = 6
slot2.TURNBACKINFOSIGNINDAYFIELD.index = 5
slot2.TURNBACKINFOSIGNINDAYFIELD.label = 1
slot2.TURNBACKINFOSIGNINDAYFIELD.has_default_value = false
slot2.TURNBACKINFOSIGNINDAYFIELD.default_value = 0
slot2.TURNBACKINFOSIGNINDAYFIELD.type = 5
slot2.TURNBACKINFOSIGNINDAYFIELD.cpp_type = 1
slot2.TURNBACKINFOSIGNININFOSFIELD.name = "signInInfos"
slot2.TURNBACKINFOSIGNININFOSFIELD.full_name = ".TurnbackInfo.signInInfos"
slot2.TURNBACKINFOSIGNININFOSFIELD.number = 7
slot2.TURNBACKINFOSIGNININFOSFIELD.index = 6
slot2.TURNBACKINFOSIGNININFOSFIELD.label = 3
slot2.TURNBACKINFOSIGNININFOSFIELD.has_default_value = false
slot2.TURNBACKINFOSIGNININFOSFIELD.default_value = {}
slot2.TURNBACKINFOSIGNININFOSFIELD.message_type = slot2.TURNBACKSIGNININFO_MSG
slot2.TURNBACKINFOSIGNININFOSFIELD.type = 11
slot2.TURNBACKINFOSIGNININFOSFIELD.cpp_type = 10
slot2.TURNBACKINFOONCEBONUSFIELD.name = "onceBonus"
slot2.TURNBACKINFOONCEBONUSFIELD.full_name = ".TurnbackInfo.onceBonus"
slot2.TURNBACKINFOONCEBONUSFIELD.number = 8
slot2.TURNBACKINFOONCEBONUSFIELD.index = 7
slot2.TURNBACKINFOONCEBONUSFIELD.label = 1
slot2.TURNBACKINFOONCEBONUSFIELD.has_default_value = false
slot2.TURNBACKINFOONCEBONUSFIELD.default_value = false
slot2.TURNBACKINFOONCEBONUSFIELD.type = 8
slot2.TURNBACKINFOONCEBONUSFIELD.cpp_type = 7
slot2.TURNBACKINFOENDTIMEFIELD.name = "endTime"
slot2.TURNBACKINFOENDTIMEFIELD.full_name = ".TurnbackInfo.endTime"
slot2.TURNBACKINFOENDTIMEFIELD.number = 9
slot2.TURNBACKINFOENDTIMEFIELD.index = 8
slot2.TURNBACKINFOENDTIMEFIELD.label = 1
slot2.TURNBACKINFOENDTIMEFIELD.has_default_value = false
slot2.TURNBACKINFOENDTIMEFIELD.default_value = 0
slot2.TURNBACKINFOENDTIMEFIELD.type = 5
slot2.TURNBACKINFOENDTIMEFIELD.cpp_type = 1
slot2.TURNBACKINFOSTARTTIMEFIELD.name = "startTime"
slot2.TURNBACKINFOSTARTTIMEFIELD.full_name = ".TurnbackInfo.startTime"
slot2.TURNBACKINFOSTARTTIMEFIELD.number = 10
slot2.TURNBACKINFOSTARTTIMEFIELD.index = 9
slot2.TURNBACKINFOSTARTTIMEFIELD.label = 1
slot2.TURNBACKINFOSTARTTIMEFIELD.has_default_value = false
slot2.TURNBACKINFOSTARTTIMEFIELD.default_value = 0
slot2.TURNBACKINFOSTARTTIMEFIELD.type = 5
slot2.TURNBACKINFOSTARTTIMEFIELD.cpp_type = 1
slot2.TURNBACKINFOREMAINADDITIONCOUNTFIELD.name = "remainAdditionCount"
slot2.TURNBACKINFOREMAINADDITIONCOUNTFIELD.full_name = ".TurnbackInfo.remainAdditionCount"
slot2.TURNBACKINFOREMAINADDITIONCOUNTFIELD.number = 11
slot2.TURNBACKINFOREMAINADDITIONCOUNTFIELD.index = 10
slot2.TURNBACKINFOREMAINADDITIONCOUNTFIELD.label = 1
slot2.TURNBACKINFOREMAINADDITIONCOUNTFIELD.has_default_value = false
slot2.TURNBACKINFOREMAINADDITIONCOUNTFIELD.default_value = 0
slot2.TURNBACKINFOREMAINADDITIONCOUNTFIELD.type = 5
slot2.TURNBACKINFOREMAINADDITIONCOUNTFIELD.cpp_type = 1
slot2.TURNBACKINFOLEAVETIMEFIELD.name = "leaveTime"
slot2.TURNBACKINFOLEAVETIMEFIELD.full_name = ".TurnbackInfo.leaveTime"
slot2.TURNBACKINFOLEAVETIMEFIELD.number = 12
slot2.TURNBACKINFOLEAVETIMEFIELD.index = 11
slot2.TURNBACKINFOLEAVETIMEFIELD.label = 1
slot2.TURNBACKINFOLEAVETIMEFIELD.has_default_value = false
slot2.TURNBACKINFOLEAVETIMEFIELD.default_value = 0
slot2.TURNBACKINFOLEAVETIMEFIELD.type = 5
slot2.TURNBACKINFOLEAVETIMEFIELD.cpp_type = 1
slot2.TURNBACKINFOMONTHCARDADDEDBUYCOUNTFIELD.name = "monthCardAddedBuyCount"
slot2.TURNBACKINFOMONTHCARDADDEDBUYCOUNTFIELD.full_name = ".TurnbackInfo.monthCardAddedBuyCount"
slot2.TURNBACKINFOMONTHCARDADDEDBUYCOUNTFIELD.number = 13
slot2.TURNBACKINFOMONTHCARDADDEDBUYCOUNTFIELD.index = 12
slot2.TURNBACKINFOMONTHCARDADDEDBUYCOUNTFIELD.label = 1
slot2.TURNBACKINFOMONTHCARDADDEDBUYCOUNTFIELD.has_default_value = false
slot2.TURNBACKINFOMONTHCARDADDEDBUYCOUNTFIELD.default_value = 0
slot2.TURNBACKINFOMONTHCARDADDEDBUYCOUNTFIELD.type = 5
slot2.TURNBACKINFOMONTHCARDADDEDBUYCOUNTFIELD.cpp_type = 1
slot2.TURNBACKINFOVERSIONFIELD.name = "version"
slot2.TURNBACKINFOVERSIONFIELD.full_name = ".TurnbackInfo.version"
slot2.TURNBACKINFOVERSIONFIELD.number = 14
slot2.TURNBACKINFOVERSIONFIELD.index = 13
slot2.TURNBACKINFOVERSIONFIELD.label = 1
slot2.TURNBACKINFOVERSIONFIELD.has_default_value = false
slot2.TURNBACKINFOVERSIONFIELD.default_value = 0
slot2.TURNBACKINFOVERSIONFIELD.type = 5
slot2.TURNBACKINFOVERSIONFIELD.cpp_type = 1
slot2.TURNBACKINFOBUYDOUBLEBONUSFIELD.name = "buyDoubleBonus"
slot2.TURNBACKINFOBUYDOUBLEBONUSFIELD.full_name = ".TurnbackInfo.buyDoubleBonus"
slot2.TURNBACKINFOBUYDOUBLEBONUSFIELD.number = 15
slot2.TURNBACKINFOBUYDOUBLEBONUSFIELD.index = 14
slot2.TURNBACKINFOBUYDOUBLEBONUSFIELD.label = 1
slot2.TURNBACKINFOBUYDOUBLEBONUSFIELD.has_default_value = false
slot2.TURNBACKINFOBUYDOUBLEBONUSFIELD.default_value = false
slot2.TURNBACKINFOBUYDOUBLEBONUSFIELD.type = 8
slot2.TURNBACKINFOBUYDOUBLEBONUSFIELD.cpp_type = 7
slot2.TURNBACKINFODROPINFOSFIELD.name = "dropInfos"
slot2.TURNBACKINFODROPINFOSFIELD.full_name = ".TurnbackInfo.dropInfos"
slot2.TURNBACKINFODROPINFOSFIELD.number = 16
slot2.TURNBACKINFODROPINFOSFIELD.index = 15
slot2.TURNBACKINFODROPINFOSFIELD.label = 3
slot2.TURNBACKINFODROPINFOSFIELD.has_default_value = false
slot2.TURNBACKINFODROPINFOSFIELD.default_value = {}
slot2.TURNBACKINFODROPINFOSFIELD.message_type = slot2.DROPINFO_MSG
slot2.TURNBACKINFODROPINFOSFIELD.type = 11
slot2.TURNBACKINFODROPINFOSFIELD.cpp_type = 10
slot2.TURNBACKINFO_MSG.name = "TurnbackInfo"
slot2.TURNBACKINFO_MSG.full_name = ".TurnbackInfo"
slot2.TURNBACKINFO_MSG.nested_types = {}
slot2.TURNBACKINFO_MSG.enum_types = {}
slot2.TURNBACKINFO_MSG.fields = {
	slot2.TURNBACKINFOIDFIELD,
	slot2.TURNBACKINFOTASKSFIELD,
	slot2.TURNBACKINFOBONUSPOINTFIELD,
	slot2.TURNBACKINFOFIRSTSHOWFIELD,
	slot2.TURNBACKINFOHASGETTASKBONUSFIELD,
	slot2.TURNBACKINFOSIGNINDAYFIELD,
	slot2.TURNBACKINFOSIGNININFOSFIELD,
	slot2.TURNBACKINFOONCEBONUSFIELD,
	slot2.TURNBACKINFOENDTIMEFIELD,
	slot2.TURNBACKINFOSTARTTIMEFIELD,
	slot2.TURNBACKINFOREMAINADDITIONCOUNTFIELD,
	slot2.TURNBACKINFOLEAVETIMEFIELD,
	slot2.TURNBACKINFOMONTHCARDADDEDBUYCOUNTFIELD,
	slot2.TURNBACKINFOVERSIONFIELD,
	slot2.TURNBACKINFOBUYDOUBLEBONUSFIELD,
	slot2.TURNBACKINFODROPINFOSFIELD
}
slot2.TURNBACKINFO_MSG.is_extendable = false
slot2.TURNBACKINFO_MSG.extensions = {}
slot2.TURNBACKBONUSPOINTREPLYIDFIELD.name = "id"
slot2.TURNBACKBONUSPOINTREPLYIDFIELD.full_name = ".TurnbackBonusPointReply.id"
slot2.TURNBACKBONUSPOINTREPLYIDFIELD.number = 1
slot2.TURNBACKBONUSPOINTREPLYIDFIELD.index = 0
slot2.TURNBACKBONUSPOINTREPLYIDFIELD.label = 1
slot2.TURNBACKBONUSPOINTREPLYIDFIELD.has_default_value = false
slot2.TURNBACKBONUSPOINTREPLYIDFIELD.default_value = 0
slot2.TURNBACKBONUSPOINTREPLYIDFIELD.type = 5
slot2.TURNBACKBONUSPOINTREPLYIDFIELD.cpp_type = 1
slot2.TURNBACKBONUSPOINTREPLYBONUSPOINTIDFIELD.name = "bonusPointId"
slot2.TURNBACKBONUSPOINTREPLYBONUSPOINTIDFIELD.full_name = ".TurnbackBonusPointReply.bonusPointId"
slot2.TURNBACKBONUSPOINTREPLYBONUSPOINTIDFIELD.number = 2
slot2.TURNBACKBONUSPOINTREPLYBONUSPOINTIDFIELD.index = 1
slot2.TURNBACKBONUSPOINTREPLYBONUSPOINTIDFIELD.label = 1
slot2.TURNBACKBONUSPOINTREPLYBONUSPOINTIDFIELD.has_default_value = false
slot2.TURNBACKBONUSPOINTREPLYBONUSPOINTIDFIELD.default_value = 0
slot2.TURNBACKBONUSPOINTREPLYBONUSPOINTIDFIELD.type = 5
slot2.TURNBACKBONUSPOINTREPLYBONUSPOINTIDFIELD.cpp_type = 1
slot2.TURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.name = "hasGetTaskBonus"
slot2.TURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.full_name = ".TurnbackBonusPointReply.hasGetTaskBonus"
slot2.TURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.number = 3
slot2.TURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.index = 2
slot2.TURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.label = 3
slot2.TURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.has_default_value = false
slot2.TURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.default_value = {}
slot2.TURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.type = 5
slot2.TURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD.cpp_type = 1
slot2.TURNBACKBONUSPOINTREPLY_MSG.name = "TurnbackBonusPointReply"
slot2.TURNBACKBONUSPOINTREPLY_MSG.full_name = ".TurnbackBonusPointReply"
slot2.TURNBACKBONUSPOINTREPLY_MSG.nested_types = {}
slot2.TURNBACKBONUSPOINTREPLY_MSG.enum_types = {}
slot2.TURNBACKBONUSPOINTREPLY_MSG.fields = {
	slot2.TURNBACKBONUSPOINTREPLYIDFIELD,
	slot2.TURNBACKBONUSPOINTREPLYBONUSPOINTIDFIELD,
	slot2.TURNBACKBONUSPOINTREPLYHASGETTASKBONUSFIELD
}
slot2.TURNBACKBONUSPOINTREPLY_MSG.is_extendable = false
slot2.TURNBACKBONUSPOINTREPLY_MSG.extensions = {}
slot2.TURNBACKONCEBONUSREPLYIDFIELD.name = "id"
slot2.TURNBACKONCEBONUSREPLYIDFIELD.full_name = ".TurnbackOnceBonusReply.id"
slot2.TURNBACKONCEBONUSREPLYIDFIELD.number = 1
slot2.TURNBACKONCEBONUSREPLYIDFIELD.index = 0
slot2.TURNBACKONCEBONUSREPLYIDFIELD.label = 1
slot2.TURNBACKONCEBONUSREPLYIDFIELD.has_default_value = false
slot2.TURNBACKONCEBONUSREPLYIDFIELD.default_value = 0
slot2.TURNBACKONCEBONUSREPLYIDFIELD.type = 5
slot2.TURNBACKONCEBONUSREPLYIDFIELD.cpp_type = 1
slot2.TURNBACKONCEBONUSREPLY_MSG.name = "TurnbackOnceBonusReply"
slot2.TURNBACKONCEBONUSREPLY_MSG.full_name = ".TurnbackOnceBonusReply"
slot2.TURNBACKONCEBONUSREPLY_MSG.nested_types = {}
slot2.TURNBACKONCEBONUSREPLY_MSG.enum_types = {}
slot2.TURNBACKONCEBONUSREPLY_MSG.fields = {
	slot2.TURNBACKONCEBONUSREPLYIDFIELD
}
slot2.TURNBACKONCEBONUSREPLY_MSG.is_extendable = false
slot2.TURNBACKONCEBONUSREPLY_MSG.extensions = {}
slot2.TURNBACKONCEBONUSREQUESTIDFIELD.name = "id"
slot2.TURNBACKONCEBONUSREQUESTIDFIELD.full_name = ".TurnbackOnceBonusRequest.id"
slot2.TURNBACKONCEBONUSREQUESTIDFIELD.number = 1
slot2.TURNBACKONCEBONUSREQUESTIDFIELD.index = 0
slot2.TURNBACKONCEBONUSREQUESTIDFIELD.label = 1
slot2.TURNBACKONCEBONUSREQUESTIDFIELD.has_default_value = false
slot2.TURNBACKONCEBONUSREQUESTIDFIELD.default_value = 0
slot2.TURNBACKONCEBONUSREQUESTIDFIELD.type = 5
slot2.TURNBACKONCEBONUSREQUESTIDFIELD.cpp_type = 1
slot2.TURNBACKONCEBONUSREQUEST_MSG.name = "TurnbackOnceBonusRequest"
slot2.TURNBACKONCEBONUSREQUEST_MSG.full_name = ".TurnbackOnceBonusRequest"
slot2.TURNBACKONCEBONUSREQUEST_MSG.nested_types = {}
slot2.TURNBACKONCEBONUSREQUEST_MSG.enum_types = {}
slot2.TURNBACKONCEBONUSREQUEST_MSG.fields = {
	slot2.TURNBACKONCEBONUSREQUESTIDFIELD
}
slot2.TURNBACKONCEBONUSREQUEST_MSG.is_extendable = false
slot2.TURNBACKONCEBONUSREQUEST_MSG.extensions = {}
slot2.TURNBACKSIGNININFOIDFIELD.name = "id"
slot2.TURNBACKSIGNININFOIDFIELD.full_name = ".TurnbackSignInInfo.id"
slot2.TURNBACKSIGNININFOIDFIELD.number = 1
slot2.TURNBACKSIGNININFOIDFIELD.index = 0
slot2.TURNBACKSIGNININFOIDFIELD.label = 1
slot2.TURNBACKSIGNININFOIDFIELD.has_default_value = false
slot2.TURNBACKSIGNININFOIDFIELD.default_value = 0
slot2.TURNBACKSIGNININFOIDFIELD.type = 5
slot2.TURNBACKSIGNININFOIDFIELD.cpp_type = 1
slot2.TURNBACKSIGNININFOSTATEFIELD.name = "state"
slot2.TURNBACKSIGNININFOSTATEFIELD.full_name = ".TurnbackSignInInfo.state"
slot2.TURNBACKSIGNININFOSTATEFIELD.number = 2
slot2.TURNBACKSIGNININFOSTATEFIELD.index = 1
slot2.TURNBACKSIGNININFOSTATEFIELD.label = 1
slot2.TURNBACKSIGNININFOSTATEFIELD.has_default_value = false
slot2.TURNBACKSIGNININFOSTATEFIELD.default_value = 0
slot2.TURNBACKSIGNININFOSTATEFIELD.type = 5
slot2.TURNBACKSIGNININFOSTATEFIELD.cpp_type = 1
slot2.TURNBACKSIGNININFO_MSG.name = "TurnbackSignInInfo"
slot2.TURNBACKSIGNININFO_MSG.full_name = ".TurnbackSignInInfo"
slot2.TURNBACKSIGNININFO_MSG.nested_types = {}
slot2.TURNBACKSIGNININFO_MSG.enum_types = {}
slot2.TURNBACKSIGNININFO_MSG.fields = {
	slot2.TURNBACKSIGNININFOIDFIELD,
	slot2.TURNBACKSIGNININFOSTATEFIELD
}
slot2.TURNBACKSIGNININFO_MSG.is_extendable = false
slot2.TURNBACKSIGNININFO_MSG.extensions = {}
slot2.TURNBACKFIRSTSHOWREPLYIDFIELD.name = "id"
slot2.TURNBACKFIRSTSHOWREPLYIDFIELD.full_name = ".TurnbackFirstShowReply.id"
slot2.TURNBACKFIRSTSHOWREPLYIDFIELD.number = 1
slot2.TURNBACKFIRSTSHOWREPLYIDFIELD.index = 0
slot2.TURNBACKFIRSTSHOWREPLYIDFIELD.label = 1
slot2.TURNBACKFIRSTSHOWREPLYIDFIELD.has_default_value = false
slot2.TURNBACKFIRSTSHOWREPLYIDFIELD.default_value = 0
slot2.TURNBACKFIRSTSHOWREPLYIDFIELD.type = 5
slot2.TURNBACKFIRSTSHOWREPLYIDFIELD.cpp_type = 1
slot2.TURNBACKFIRSTSHOWREPLY_MSG.name = "TurnbackFirstShowReply"
slot2.TURNBACKFIRSTSHOWREPLY_MSG.full_name = ".TurnbackFirstShowReply"
slot2.TURNBACKFIRSTSHOWREPLY_MSG.nested_types = {}
slot2.TURNBACKFIRSTSHOWREPLY_MSG.enum_types = {}
slot2.TURNBACKFIRSTSHOWREPLY_MSG.fields = {
	slot2.TURNBACKFIRSTSHOWREPLYIDFIELD
}
slot2.TURNBACKFIRSTSHOWREPLY_MSG.is_extendable = false
slot2.TURNBACKFIRSTSHOWREPLY_MSG.extensions = {}
slot2.TURNBACKADDITIONPUSHIDFIELD.name = "id"
slot2.TURNBACKADDITIONPUSHIDFIELD.full_name = ".TurnbackAdditionPush.id"
slot2.TURNBACKADDITIONPUSHIDFIELD.number = 1
slot2.TURNBACKADDITIONPUSHIDFIELD.index = 0
slot2.TURNBACKADDITIONPUSHIDFIELD.label = 1
slot2.TURNBACKADDITIONPUSHIDFIELD.has_default_value = false
slot2.TURNBACKADDITIONPUSHIDFIELD.default_value = 0
slot2.TURNBACKADDITIONPUSHIDFIELD.type = 5
slot2.TURNBACKADDITIONPUSHIDFIELD.cpp_type = 1
slot2.TURNBACKADDITIONPUSHREMAINADDITIONCOUNTFIELD.name = "remainAdditionCount"
slot2.TURNBACKADDITIONPUSHREMAINADDITIONCOUNTFIELD.full_name = ".TurnbackAdditionPush.remainAdditionCount"
slot2.TURNBACKADDITIONPUSHREMAINADDITIONCOUNTFIELD.number = 2
slot2.TURNBACKADDITIONPUSHREMAINADDITIONCOUNTFIELD.index = 1
slot2.TURNBACKADDITIONPUSHREMAINADDITIONCOUNTFIELD.label = 1
slot2.TURNBACKADDITIONPUSHREMAINADDITIONCOUNTFIELD.has_default_value = false
slot2.TURNBACKADDITIONPUSHREMAINADDITIONCOUNTFIELD.default_value = 0
slot2.TURNBACKADDITIONPUSHREMAINADDITIONCOUNTFIELD.type = 5
slot2.TURNBACKADDITIONPUSHREMAINADDITIONCOUNTFIELD.cpp_type = 1
slot2.TURNBACKADDITIONPUSH_MSG.name = "TurnbackAdditionPush"
slot2.TURNBACKADDITIONPUSH_MSG.full_name = ".TurnbackAdditionPush"
slot2.TURNBACKADDITIONPUSH_MSG.nested_types = {}
slot2.TURNBACKADDITIONPUSH_MSG.enum_types = {}
slot2.TURNBACKADDITIONPUSH_MSG.fields = {
	slot2.TURNBACKADDITIONPUSHIDFIELD,
	slot2.TURNBACKADDITIONPUSHREMAINADDITIONCOUNTFIELD
}
slot2.TURNBACKADDITIONPUSH_MSG.is_extendable = false
slot2.TURNBACKADDITIONPUSH_MSG.extensions = {}
slot2.TURNBACKSIGNINREQUESTIDFIELD.name = "id"
slot2.TURNBACKSIGNINREQUESTIDFIELD.full_name = ".TurnbackSignInRequest.id"
slot2.TURNBACKSIGNINREQUESTIDFIELD.number = 1
slot2.TURNBACKSIGNINREQUESTIDFIELD.index = 0
slot2.TURNBACKSIGNINREQUESTIDFIELD.label = 1
slot2.TURNBACKSIGNINREQUESTIDFIELD.has_default_value = false
slot2.TURNBACKSIGNINREQUESTIDFIELD.default_value = 0
slot2.TURNBACKSIGNINREQUESTIDFIELD.type = 5
slot2.TURNBACKSIGNINREQUESTIDFIELD.cpp_type = 1
slot2.TURNBACKSIGNINREQUESTDAYFIELD.name = "day"
slot2.TURNBACKSIGNINREQUESTDAYFIELD.full_name = ".TurnbackSignInRequest.day"
slot2.TURNBACKSIGNINREQUESTDAYFIELD.number = 2
slot2.TURNBACKSIGNINREQUESTDAYFIELD.index = 1
slot2.TURNBACKSIGNINREQUESTDAYFIELD.label = 1
slot2.TURNBACKSIGNINREQUESTDAYFIELD.has_default_value = false
slot2.TURNBACKSIGNINREQUESTDAYFIELD.default_value = 0
slot2.TURNBACKSIGNINREQUESTDAYFIELD.type = 5
slot2.TURNBACKSIGNINREQUESTDAYFIELD.cpp_type = 1
slot2.TURNBACKSIGNINREQUEST_MSG.name = "TurnbackSignInRequest"
slot2.TURNBACKSIGNINREQUEST_MSG.full_name = ".TurnbackSignInRequest"
slot2.TURNBACKSIGNINREQUEST_MSG.nested_types = {}
slot2.TURNBACKSIGNINREQUEST_MSG.enum_types = {}
slot2.TURNBACKSIGNINREQUEST_MSG.fields = {
	slot2.TURNBACKSIGNINREQUESTIDFIELD,
	slot2.TURNBACKSIGNINREQUESTDAYFIELD
}
slot2.TURNBACKSIGNINREQUEST_MSG.is_extendable = false
slot2.TURNBACKSIGNINREQUEST_MSG.extensions = {}
slot2.DROPINFOTYPEFIELD.name = "type"
slot2.DROPINFOTYPEFIELD.full_name = ".DropInfo.type"
slot2.DROPINFOTYPEFIELD.number = 1
slot2.DROPINFOTYPEFIELD.index = 0
slot2.DROPINFOTYPEFIELD.label = 1
slot2.DROPINFOTYPEFIELD.has_default_value = false
slot2.DROPINFOTYPEFIELD.default_value = 0
slot2.DROPINFOTYPEFIELD.type = 5
slot2.DROPINFOTYPEFIELD.cpp_type = 1
slot2.DROPINFOTOTALNUMFIELD.name = "totalNum"
slot2.DROPINFOTOTALNUMFIELD.full_name = ".DropInfo.totalNum"
slot2.DROPINFOTOTALNUMFIELD.number = 2
slot2.DROPINFOTOTALNUMFIELD.index = 1
slot2.DROPINFOTOTALNUMFIELD.label = 1
slot2.DROPINFOTOTALNUMFIELD.has_default_value = false
slot2.DROPINFOTOTALNUMFIELD.default_value = 0
slot2.DROPINFOTOTALNUMFIELD.type = 5
slot2.DROPINFOTOTALNUMFIELD.cpp_type = 1
slot2.DROPINFOCURRENTNUMFIELD.name = "currentNum"
slot2.DROPINFOCURRENTNUMFIELD.full_name = ".DropInfo.currentNum"
slot2.DROPINFOCURRENTNUMFIELD.number = 3
slot2.DROPINFOCURRENTNUMFIELD.index = 2
slot2.DROPINFOCURRENTNUMFIELD.label = 1
slot2.DROPINFOCURRENTNUMFIELD.has_default_value = false
slot2.DROPINFOCURRENTNUMFIELD.default_value = 0
slot2.DROPINFOCURRENTNUMFIELD.type = 5
slot2.DROPINFOCURRENTNUMFIELD.cpp_type = 1
slot2.DROPINFO_MSG.name = "DropInfo"
slot2.DROPINFO_MSG.full_name = ".DropInfo"
slot2.DROPINFO_MSG.nested_types = {}
slot2.DROPINFO_MSG.enum_types = {}
slot2.DROPINFO_MSG.fields = {
	slot2.DROPINFOTYPEFIELD,
	slot2.DROPINFOTOTALNUMFIELD,
	slot2.DROPINFOCURRENTNUMFIELD
}
slot2.DROPINFO_MSG.is_extendable = false
slot2.DROPINFO_MSG.extensions = {}
slot2.TURNBACKBONUSPOINTREQUESTIDFIELD.name = "id"
slot2.TURNBACKBONUSPOINTREQUESTIDFIELD.full_name = ".TurnbackBonusPointRequest.id"
slot2.TURNBACKBONUSPOINTREQUESTIDFIELD.number = 1
slot2.TURNBACKBONUSPOINTREQUESTIDFIELD.index = 0
slot2.TURNBACKBONUSPOINTREQUESTIDFIELD.label = 1
slot2.TURNBACKBONUSPOINTREQUESTIDFIELD.has_default_value = false
slot2.TURNBACKBONUSPOINTREQUESTIDFIELD.default_value = 0
slot2.TURNBACKBONUSPOINTREQUESTIDFIELD.type = 5
slot2.TURNBACKBONUSPOINTREQUESTIDFIELD.cpp_type = 1
slot2.TURNBACKBONUSPOINTREQUESTBONUSPOINTIDFIELD.name = "bonusPointId"
slot2.TURNBACKBONUSPOINTREQUESTBONUSPOINTIDFIELD.full_name = ".TurnbackBonusPointRequest.bonusPointId"
slot2.TURNBACKBONUSPOINTREQUESTBONUSPOINTIDFIELD.number = 2
slot2.TURNBACKBONUSPOINTREQUESTBONUSPOINTIDFIELD.index = 1
slot2.TURNBACKBONUSPOINTREQUESTBONUSPOINTIDFIELD.label = 1
slot2.TURNBACKBONUSPOINTREQUESTBONUSPOINTIDFIELD.has_default_value = false
slot2.TURNBACKBONUSPOINTREQUESTBONUSPOINTIDFIELD.default_value = 0
slot2.TURNBACKBONUSPOINTREQUESTBONUSPOINTIDFIELD.type = 5
slot2.TURNBACKBONUSPOINTREQUESTBONUSPOINTIDFIELD.cpp_type = 1
slot2.TURNBACKBONUSPOINTREQUEST_MSG.name = "TurnbackBonusPointRequest"
slot2.TURNBACKBONUSPOINTREQUEST_MSG.full_name = ".TurnbackBonusPointRequest"
slot2.TURNBACKBONUSPOINTREQUEST_MSG.nested_types = {}
slot2.TURNBACKBONUSPOINTREQUEST_MSG.enum_types = {}
slot2.TURNBACKBONUSPOINTREQUEST_MSG.fields = {
	slot2.TURNBACKBONUSPOINTREQUESTIDFIELD,
	slot2.TURNBACKBONUSPOINTREQUESTBONUSPOINTIDFIELD
}
slot2.TURNBACKBONUSPOINTREQUEST_MSG.is_extendable = false
slot2.TURNBACKBONUSPOINTREQUEST_MSG.extensions = {}
slot2.GETTURNBACKINFOREQUEST_MSG.name = "GetTurnbackInfoRequest"
slot2.GETTURNBACKINFOREQUEST_MSG.full_name = ".GetTurnbackInfoRequest"
slot2.GETTURNBACKINFOREQUEST_MSG.nested_types = {}
slot2.GETTURNBACKINFOREQUEST_MSG.enum_types = {}
slot2.GETTURNBACKINFOREQUEST_MSG.fields = {}
slot2.GETTURNBACKINFOREQUEST_MSG.is_extendable = false
slot2.GETTURNBACKINFOREQUEST_MSG.extensions = {}
slot2.GETTURNBACKINFOREPLYINFOFIELD.name = "info"
slot2.GETTURNBACKINFOREPLYINFOFIELD.full_name = ".GetTurnbackInfoReply.info"
slot2.GETTURNBACKINFOREPLYINFOFIELD.number = 1
slot2.GETTURNBACKINFOREPLYINFOFIELD.index = 0
slot2.GETTURNBACKINFOREPLYINFOFIELD.label = 1
slot2.GETTURNBACKINFOREPLYINFOFIELD.has_default_value = false
slot2.GETTURNBACKINFOREPLYINFOFIELD.default_value = nil
slot2.GETTURNBACKINFOREPLYINFOFIELD.message_type = slot2.TURNBACKINFO_MSG
slot2.GETTURNBACKINFOREPLYINFOFIELD.type = 11
slot2.GETTURNBACKINFOREPLYINFOFIELD.cpp_type = 10
slot2.GETTURNBACKINFOREPLY_MSG.name = "GetTurnbackInfoReply"
slot2.GETTURNBACKINFOREPLY_MSG.full_name = ".GetTurnbackInfoReply"
slot2.GETTURNBACKINFOREPLY_MSG.nested_types = {}
slot2.GETTURNBACKINFOREPLY_MSG.enum_types = {}
slot2.GETTURNBACKINFOREPLY_MSG.fields = {
	slot2.GETTURNBACKINFOREPLYINFOFIELD
}
slot2.GETTURNBACKINFOREPLY_MSG.is_extendable = false
slot2.GETTURNBACKINFOREPLY_MSG.extensions = {}
slot2.REFRESHONLINETASKREQUESTIDFIELD.name = "id"
slot2.REFRESHONLINETASKREQUESTIDFIELD.full_name = ".RefreshOnlineTaskRequest.id"
slot2.REFRESHONLINETASKREQUESTIDFIELD.number = 1
slot2.REFRESHONLINETASKREQUESTIDFIELD.index = 0
slot2.REFRESHONLINETASKREQUESTIDFIELD.label = 1
slot2.REFRESHONLINETASKREQUESTIDFIELD.has_default_value = false
slot2.REFRESHONLINETASKREQUESTIDFIELD.default_value = 0
slot2.REFRESHONLINETASKREQUESTIDFIELD.type = 5
slot2.REFRESHONLINETASKREQUESTIDFIELD.cpp_type = 1
slot2.REFRESHONLINETASKREQUEST_MSG.name = "RefreshOnlineTaskRequest"
slot2.REFRESHONLINETASKREQUEST_MSG.full_name = ".RefreshOnlineTaskRequest"
slot2.REFRESHONLINETASKREQUEST_MSG.nested_types = {}
slot2.REFRESHONLINETASKREQUEST_MSG.enum_types = {}
slot2.REFRESHONLINETASKREQUEST_MSG.fields = {
	slot2.REFRESHONLINETASKREQUESTIDFIELD
}
slot2.REFRESHONLINETASKREQUEST_MSG.is_extendable = false
slot2.REFRESHONLINETASKREQUEST_MSG.extensions = {}
slot2.TURNBACKFIRSTSHOWREQUESTIDFIELD.name = "id"
slot2.TURNBACKFIRSTSHOWREQUESTIDFIELD.full_name = ".TurnbackFirstShowRequest.id"
slot2.TURNBACKFIRSTSHOWREQUESTIDFIELD.number = 1
slot2.TURNBACKFIRSTSHOWREQUESTIDFIELD.index = 0
slot2.TURNBACKFIRSTSHOWREQUESTIDFIELD.label = 1
slot2.TURNBACKFIRSTSHOWREQUESTIDFIELD.has_default_value = false
slot2.TURNBACKFIRSTSHOWREQUESTIDFIELD.default_value = 0
slot2.TURNBACKFIRSTSHOWREQUESTIDFIELD.type = 5
slot2.TURNBACKFIRSTSHOWREQUESTIDFIELD.cpp_type = 1
slot2.TURNBACKFIRSTSHOWREQUEST_MSG.name = "TurnbackFirstShowRequest"
slot2.TURNBACKFIRSTSHOWREQUEST_MSG.full_name = ".TurnbackFirstShowRequest"
slot2.TURNBACKFIRSTSHOWREQUEST_MSG.nested_types = {}
slot2.TURNBACKFIRSTSHOWREQUEST_MSG.enum_types = {}
slot2.TURNBACKFIRSTSHOWREQUEST_MSG.fields = {
	slot2.TURNBACKFIRSTSHOWREQUESTIDFIELD
}
slot2.TURNBACKFIRSTSHOWREQUEST_MSG.is_extendable = false
slot2.TURNBACKFIRSTSHOWREQUEST_MSG.extensions = {}
slot2.TURNBACKSIGNINREPLYIDFIELD.name = "id"
slot2.TURNBACKSIGNINREPLYIDFIELD.full_name = ".TurnbackSignInReply.id"
slot2.TURNBACKSIGNINREPLYIDFIELD.number = 1
slot2.TURNBACKSIGNINREPLYIDFIELD.index = 0
slot2.TURNBACKSIGNINREPLYIDFIELD.label = 1
slot2.TURNBACKSIGNINREPLYIDFIELD.has_default_value = false
slot2.TURNBACKSIGNINREPLYIDFIELD.default_value = 0
slot2.TURNBACKSIGNINREPLYIDFIELD.type = 5
slot2.TURNBACKSIGNINREPLYIDFIELD.cpp_type = 1
slot2.TURNBACKSIGNINREPLYDAYFIELD.name = "day"
slot2.TURNBACKSIGNINREPLYDAYFIELD.full_name = ".TurnbackSignInReply.day"
slot2.TURNBACKSIGNINREPLYDAYFIELD.number = 2
slot2.TURNBACKSIGNINREPLYDAYFIELD.index = 1
slot2.TURNBACKSIGNINREPLYDAYFIELD.label = 1
slot2.TURNBACKSIGNINREPLYDAYFIELD.has_default_value = false
slot2.TURNBACKSIGNINREPLYDAYFIELD.default_value = 0
slot2.TURNBACKSIGNINREPLYDAYFIELD.type = 5
slot2.TURNBACKSIGNINREPLYDAYFIELD.cpp_type = 1
slot2.TURNBACKSIGNINREPLY_MSG.name = "TurnbackSignInReply"
slot2.TURNBACKSIGNINREPLY_MSG.full_name = ".TurnbackSignInReply"
slot2.TURNBACKSIGNINREPLY_MSG.nested_types = {}
slot2.TURNBACKSIGNINREPLY_MSG.enum_types = {}
slot2.TURNBACKSIGNINREPLY_MSG.fields = {
	slot2.TURNBACKSIGNINREPLYIDFIELD,
	slot2.TURNBACKSIGNINREPLYDAYFIELD
}
slot2.TURNBACKSIGNINREPLY_MSG.is_extendable = false
slot2.TURNBACKSIGNINREPLY_MSG.extensions = {}
slot2.BUYDOUBLEBONUSREQUESTIDFIELD.name = "id"
slot2.BUYDOUBLEBONUSREQUESTIDFIELD.full_name = ".BuyDoubleBonusRequest.id"
slot2.BUYDOUBLEBONUSREQUESTIDFIELD.number = 1
slot2.BUYDOUBLEBONUSREQUESTIDFIELD.index = 0
slot2.BUYDOUBLEBONUSREQUESTIDFIELD.label = 1
slot2.BUYDOUBLEBONUSREQUESTIDFIELD.has_default_value = false
slot2.BUYDOUBLEBONUSREQUESTIDFIELD.default_value = 0
slot2.BUYDOUBLEBONUSREQUESTIDFIELD.type = 5
slot2.BUYDOUBLEBONUSREQUESTIDFIELD.cpp_type = 1
slot2.BUYDOUBLEBONUSREQUEST_MSG.name = "BuyDoubleBonusRequest"
slot2.BUYDOUBLEBONUSREQUEST_MSG.full_name = ".BuyDoubleBonusRequest"
slot2.BUYDOUBLEBONUSREQUEST_MSG.nested_types = {}
slot2.BUYDOUBLEBONUSREQUEST_MSG.enum_types = {}
slot2.BUYDOUBLEBONUSREQUEST_MSG.fields = {
	slot2.BUYDOUBLEBONUSREQUESTIDFIELD
}
slot2.BUYDOUBLEBONUSREQUEST_MSG.is_extendable = false
slot2.BUYDOUBLEBONUSREQUEST_MSG.extensions = {}
slot2.REFRESHONLINETASKREPLYIDFIELD.name = "id"
slot2.REFRESHONLINETASKREPLYIDFIELD.full_name = ".RefreshOnlineTaskReply.id"
slot2.REFRESHONLINETASKREPLYIDFIELD.number = 1
slot2.REFRESHONLINETASKREPLYIDFIELD.index = 0
slot2.REFRESHONLINETASKREPLYIDFIELD.label = 1
slot2.REFRESHONLINETASKREPLYIDFIELD.has_default_value = false
slot2.REFRESHONLINETASKREPLYIDFIELD.default_value = 0
slot2.REFRESHONLINETASKREPLYIDFIELD.type = 5
slot2.REFRESHONLINETASKREPLYIDFIELD.cpp_type = 1
slot2.REFRESHONLINETASKREPLY_MSG.name = "RefreshOnlineTaskReply"
slot2.REFRESHONLINETASKREPLY_MSG.full_name = ".RefreshOnlineTaskReply"
slot2.REFRESHONLINETASKREPLY_MSG.nested_types = {}
slot2.REFRESHONLINETASKREPLY_MSG.enum_types = {}
slot2.REFRESHONLINETASKREPLY_MSG.fields = {
	slot2.REFRESHONLINETASKREPLYIDFIELD
}
slot2.REFRESHONLINETASKREPLY_MSG.is_extendable = false
slot2.REFRESHONLINETASKREPLY_MSG.extensions = {}
slot2.BUYDOUBLEBONUSREPLYIDFIELD.name = "id"
slot2.BUYDOUBLEBONUSREPLYIDFIELD.full_name = ".BuyDoubleBonusReply.id"
slot2.BUYDOUBLEBONUSREPLYIDFIELD.number = 1
slot2.BUYDOUBLEBONUSREPLYIDFIELD.index = 0
slot2.BUYDOUBLEBONUSREPLYIDFIELD.label = 1
slot2.BUYDOUBLEBONUSREPLYIDFIELD.has_default_value = false
slot2.BUYDOUBLEBONUSREPLYIDFIELD.default_value = 0
slot2.BUYDOUBLEBONUSREPLYIDFIELD.type = 5
slot2.BUYDOUBLEBONUSREPLYIDFIELD.cpp_type = 1
slot2.BUYDOUBLEBONUSREPLYHASGETDOUBLETASKBONUSFIELD.name = "hasGetDoubleTaskBonus"
slot2.BUYDOUBLEBONUSREPLYHASGETDOUBLETASKBONUSFIELD.full_name = ".BuyDoubleBonusReply.hasGetDoubleTaskBonus"
slot2.BUYDOUBLEBONUSREPLYHASGETDOUBLETASKBONUSFIELD.number = 2
slot2.BUYDOUBLEBONUSREPLYHASGETDOUBLETASKBONUSFIELD.index = 1
slot2.BUYDOUBLEBONUSREPLYHASGETDOUBLETASKBONUSFIELD.label = 3
slot2.BUYDOUBLEBONUSREPLYHASGETDOUBLETASKBONUSFIELD.has_default_value = false
slot2.BUYDOUBLEBONUSREPLYHASGETDOUBLETASKBONUSFIELD.default_value = {}
slot2.BUYDOUBLEBONUSREPLYHASGETDOUBLETASKBONUSFIELD.type = 5
slot2.BUYDOUBLEBONUSREPLYHASGETDOUBLETASKBONUSFIELD.cpp_type = 1
slot2.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD.name = "doubleBonus"
slot2.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD.full_name = ".BuyDoubleBonusReply.doubleBonus"
slot2.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD.number = 3
slot2.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD.index = 2
slot2.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD.label = 3
slot2.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD.has_default_value = false
slot2.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD.default_value = {}
slot2.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD.message_type = slot2.MATERIALMODULE_PB.MATERIALDATA_MSG
slot2.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD.type = 11
slot2.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD.cpp_type = 10
slot2.BUYDOUBLEBONUSREPLY_MSG.name = "BuyDoubleBonusReply"
slot2.BUYDOUBLEBONUSREPLY_MSG.full_name = ".BuyDoubleBonusReply"
slot2.BUYDOUBLEBONUSREPLY_MSG.nested_types = {}
slot2.BUYDOUBLEBONUSREPLY_MSG.enum_types = {}
slot2.BUYDOUBLEBONUSREPLY_MSG.fields = {
	slot2.BUYDOUBLEBONUSREPLYIDFIELD,
	slot2.BUYDOUBLEBONUSREPLYHASGETDOUBLETASKBONUSFIELD,
	slot2.BUYDOUBLEBONUSREPLYDOUBLEBONUSFIELD
}
slot2.BUYDOUBLEBONUSREPLY_MSG.is_extendable = false
slot2.BUYDOUBLEBONUSREPLY_MSG.extensions = {}
slot2.BuyDoubleBonusReply = slot1.Message(slot2.BUYDOUBLEBONUSREPLY_MSG)
slot2.BuyDoubleBonusRequest = slot1.Message(slot2.BUYDOUBLEBONUSREQUEST_MSG)
slot2.DropInfo = slot1.Message(slot2.DROPINFO_MSG)
slot2.GetTurnbackInfoReply = slot1.Message(slot2.GETTURNBACKINFOREPLY_MSG)
slot2.GetTurnbackInfoRequest = slot1.Message(slot2.GETTURNBACKINFOREQUEST_MSG)
slot2.RefreshOnlineTaskReply = slot1.Message(slot2.REFRESHONLINETASKREPLY_MSG)
slot2.RefreshOnlineTaskRequest = slot1.Message(slot2.REFRESHONLINETASKREQUEST_MSG)
slot2.TurnbackAdditionPush = slot1.Message(slot2.TURNBACKADDITIONPUSH_MSG)
slot2.TurnbackBonusPointReply = slot1.Message(slot2.TURNBACKBONUSPOINTREPLY_MSG)
slot2.TurnbackBonusPointRequest = slot1.Message(slot2.TURNBACKBONUSPOINTREQUEST_MSG)
slot2.TurnbackFirstShowReply = slot1.Message(slot2.TURNBACKFIRSTSHOWREPLY_MSG)
slot2.TurnbackFirstShowRequest = slot1.Message(slot2.TURNBACKFIRSTSHOWREQUEST_MSG)
slot2.TurnbackInfo = slot1.Message(slot2.TURNBACKINFO_MSG)
slot2.TurnbackOnceBonusReply = slot1.Message(slot2.TURNBACKONCEBONUSREPLY_MSG)
slot2.TurnbackOnceBonusRequest = slot1.Message(slot2.TURNBACKONCEBONUSREQUEST_MSG)
slot2.TurnbackSignInInfo = slot1.Message(slot2.TURNBACKSIGNININFO_MSG)
slot2.TurnbackSignInReply = slot1.Message(slot2.TURNBACKSIGNINREPLY_MSG)
slot2.TurnbackSignInRequest = slot1.Message(slot2.TURNBACKSIGNINREQUEST_MSG)

return slot2
