slot1 = require("protobuf.protobuf")

module("modules.proto.TaskModule_pb", package.seeall)

slot2 = {
	TASK_MSG = slot1.Descriptor(),
	TASKIDFIELD = slot1.FieldDescriptor(),
	TASKPROGRESSFIELD = slot1.FieldDescriptor(),
	TASKHASFINISHEDFIELD = slot1.FieldDescriptor(),
	TASKFINISHCOUNTFIELD = slot1.FieldDescriptor(),
	TASKTYPEFIELD = slot1.FieldDescriptor(),
	TASKEXPIRYTIMEFIELD = slot1.FieldDescriptor(),
	TASKACTIVITYINFO_MSG = slot1.Descriptor(),
	TASKACTIVITYINFOTYPEIDFIELD = slot1.FieldDescriptor(),
	TASKACTIVITYINFODEFINEIDFIELD = slot1.FieldDescriptor(),
	TASKACTIVITYINFOVALUEFIELD = slot1.FieldDescriptor(),
	TASKACTIVITYINFOGAINVALUEFIELD = slot1.FieldDescriptor(),
	TASKACTIVITYINFOEXPIRYTIMEFIELD = slot1.FieldDescriptor(),
	FINISHREADTASKREQUEST_MSG = slot1.Descriptor(),
	FINISHREADTASKREQUESTTASKIDFIELD = slot1.FieldDescriptor(),
	GETTASKINFOREQUEST_MSG = slot1.Descriptor(),
	GETTASKINFOREQUESTTYPEIDSFIELD = slot1.FieldDescriptor(),
	FINISHALLTASKREQUEST_MSG = slot1.Descriptor(),
	FINISHALLTASKREQUESTTYPEIDFIELD = slot1.FieldDescriptor(),
	FINISHALLTASKREQUESTMINTYPEIDFIELD = slot1.FieldDescriptor(),
	FINISHALLTASKREQUESTTASKIDSFIELD = slot1.FieldDescriptor(),
	FINISHALLTASKREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor(),
	GETTASKACTIVITYBONUSREPLY_MSG = slot1.Descriptor(),
	GETTASKACTIVITYBONUSREPLYTYPEIDFIELD = slot1.FieldDescriptor(),
	GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD = slot1.FieldDescriptor(),
	FINISHALLTASKREPLY_MSG = slot1.Descriptor(),
	FINISHALLTASKREPLYTYPEIDFIELD = slot1.FieldDescriptor(),
	FINISHALLTASKREPLYMINTYPEIDFIELD = slot1.FieldDescriptor(),
	FINISHALLTASKREPLYTASKIDSFIELD = slot1.FieldDescriptor(),
	FINISHALLTASKREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	GETTASKACTIVITYBONUSREQUEST_MSG = slot1.Descriptor(),
	GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD = slot1.FieldDescriptor(),
	GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD = slot1.FieldDescriptor(),
	FINISHREADTASKREPLY_MSG = slot1.Descriptor(),
	FINISHREADTASKREPLYTASKIDFIELD = slot1.FieldDescriptor(),
	UPDATETASKPUSH_MSG = slot1.Descriptor(),
	UPDATETASKPUSHTASKINFOFIELD = slot1.FieldDescriptor(),
	UPDATETASKPUSHACTIVITYINFOFIELD = slot1.FieldDescriptor(),
	FINISHTASKREQUEST_MSG = slot1.Descriptor(),
	FINISHTASKREQUESTIDFIELD = slot1.FieldDescriptor(),
	FINISHTASKREPLY_MSG = slot1.Descriptor(),
	FINISHTASKREPLYIDFIELD = slot1.FieldDescriptor(),
	FINISHTASKREPLYFINISHCOUNTFIELD = slot1.FieldDescriptor(),
	DELETETASKPUSH_MSG = slot1.Descriptor(),
	DELETETASKPUSHTASKIDSFIELD = slot1.FieldDescriptor(),
	GETTASKINFOREPLY_MSG = slot1.Descriptor(),
	GETTASKINFOREPLYTASKINFOFIELD = slot1.FieldDescriptor(),
	GETTASKINFOREPLYACTIVITYINFOFIELD = slot1.FieldDescriptor(),
	GETTASKINFOREPLYTYPEIDSFIELD = slot1.FieldDescriptor()
}
slot2.TASKIDFIELD.name = "id"
slot2.TASKIDFIELD.full_name = ".Task.id"
slot2.TASKIDFIELD.number = 1
slot2.TASKIDFIELD.index = 0
slot2.TASKIDFIELD.label = 2
slot2.TASKIDFIELD.has_default_value = false
slot2.TASKIDFIELD.default_value = 0
slot2.TASKIDFIELD.type = 5
slot2.TASKIDFIELD.cpp_type = 1
slot2.TASKPROGRESSFIELD.name = "progress"
slot2.TASKPROGRESSFIELD.full_name = ".Task.progress"
slot2.TASKPROGRESSFIELD.number = 2
slot2.TASKPROGRESSFIELD.index = 1
slot2.TASKPROGRESSFIELD.label = 2
slot2.TASKPROGRESSFIELD.has_default_value = false
slot2.TASKPROGRESSFIELD.default_value = 0
slot2.TASKPROGRESSFIELD.type = 5
slot2.TASKPROGRESSFIELD.cpp_type = 1
slot2.TASKHASFINISHEDFIELD.name = "hasFinished"
slot2.TASKHASFINISHEDFIELD.full_name = ".Task.hasFinished"
slot2.TASKHASFINISHEDFIELD.number = 3
slot2.TASKHASFINISHEDFIELD.index = 2
slot2.TASKHASFINISHEDFIELD.label = 2
slot2.TASKHASFINISHEDFIELD.has_default_value = false
slot2.TASKHASFINISHEDFIELD.default_value = false
slot2.TASKHASFINISHEDFIELD.type = 8
slot2.TASKHASFINISHEDFIELD.cpp_type = 7
slot2.TASKFINISHCOUNTFIELD.name = "finishCount"
slot2.TASKFINISHCOUNTFIELD.full_name = ".Task.finishCount"
slot2.TASKFINISHCOUNTFIELD.number = 4
slot2.TASKFINISHCOUNTFIELD.index = 3
slot2.TASKFINISHCOUNTFIELD.label = 1
slot2.TASKFINISHCOUNTFIELD.has_default_value = false
slot2.TASKFINISHCOUNTFIELD.default_value = 0
slot2.TASKFINISHCOUNTFIELD.type = 5
slot2.TASKFINISHCOUNTFIELD.cpp_type = 1
slot2.TASKTYPEFIELD.name = "type"
slot2.TASKTYPEFIELD.full_name = ".Task.type"
slot2.TASKTYPEFIELD.number = 5
slot2.TASKTYPEFIELD.index = 4
slot2.TASKTYPEFIELD.label = 1
slot2.TASKTYPEFIELD.has_default_value = false
slot2.TASKTYPEFIELD.default_value = 0
slot2.TASKTYPEFIELD.type = 5
slot2.TASKTYPEFIELD.cpp_type = 1
slot2.TASKEXPIRYTIMEFIELD.name = "expiryTime"
slot2.TASKEXPIRYTIMEFIELD.full_name = ".Task.expiryTime"
slot2.TASKEXPIRYTIMEFIELD.number = 6
slot2.TASKEXPIRYTIMEFIELD.index = 5
slot2.TASKEXPIRYTIMEFIELD.label = 1
slot2.TASKEXPIRYTIMEFIELD.has_default_value = false
slot2.TASKEXPIRYTIMEFIELD.default_value = 0
slot2.TASKEXPIRYTIMEFIELD.type = 5
slot2.TASKEXPIRYTIMEFIELD.cpp_type = 1
slot2.TASK_MSG.name = "Task"
slot2.TASK_MSG.full_name = ".Task"
slot2.TASK_MSG.nested_types = {}
slot2.TASK_MSG.enum_types = {}
slot2.TASK_MSG.fields = {
	slot2.TASKIDFIELD,
	slot2.TASKPROGRESSFIELD,
	slot2.TASKHASFINISHEDFIELD,
	slot2.TASKFINISHCOUNTFIELD,
	slot2.TASKTYPEFIELD,
	slot2.TASKEXPIRYTIMEFIELD
}
slot2.TASK_MSG.is_extendable = false
slot2.TASK_MSG.extensions = {}
slot2.TASKACTIVITYINFOTYPEIDFIELD.name = "typeId"
slot2.TASKACTIVITYINFOTYPEIDFIELD.full_name = ".TaskActivityInfo.typeId"
slot2.TASKACTIVITYINFOTYPEIDFIELD.number = 1
slot2.TASKACTIVITYINFOTYPEIDFIELD.index = 0
slot2.TASKACTIVITYINFOTYPEIDFIELD.label = 2
slot2.TASKACTIVITYINFOTYPEIDFIELD.has_default_value = false
slot2.TASKACTIVITYINFOTYPEIDFIELD.default_value = 0
slot2.TASKACTIVITYINFOTYPEIDFIELD.type = 5
slot2.TASKACTIVITYINFOTYPEIDFIELD.cpp_type = 1
slot2.TASKACTIVITYINFODEFINEIDFIELD.name = "defineId"
slot2.TASKACTIVITYINFODEFINEIDFIELD.full_name = ".TaskActivityInfo.defineId"
slot2.TASKACTIVITYINFODEFINEIDFIELD.number = 2
slot2.TASKACTIVITYINFODEFINEIDFIELD.index = 1
slot2.TASKACTIVITYINFODEFINEIDFIELD.label = 2
slot2.TASKACTIVITYINFODEFINEIDFIELD.has_default_value = false
slot2.TASKACTIVITYINFODEFINEIDFIELD.default_value = 0
slot2.TASKACTIVITYINFODEFINEIDFIELD.type = 5
slot2.TASKACTIVITYINFODEFINEIDFIELD.cpp_type = 1
slot2.TASKACTIVITYINFOVALUEFIELD.name = "value"
slot2.TASKACTIVITYINFOVALUEFIELD.full_name = ".TaskActivityInfo.value"
slot2.TASKACTIVITYINFOVALUEFIELD.number = 3
slot2.TASKACTIVITYINFOVALUEFIELD.index = 2
slot2.TASKACTIVITYINFOVALUEFIELD.label = 2
slot2.TASKACTIVITYINFOVALUEFIELD.has_default_value = false
slot2.TASKACTIVITYINFOVALUEFIELD.default_value = 0
slot2.TASKACTIVITYINFOVALUEFIELD.type = 5
slot2.TASKACTIVITYINFOVALUEFIELD.cpp_type = 1
slot2.TASKACTIVITYINFOGAINVALUEFIELD.name = "gainValue"
slot2.TASKACTIVITYINFOGAINVALUEFIELD.full_name = ".TaskActivityInfo.gainValue"
slot2.TASKACTIVITYINFOGAINVALUEFIELD.number = 4
slot2.TASKACTIVITYINFOGAINVALUEFIELD.index = 3
slot2.TASKACTIVITYINFOGAINVALUEFIELD.label = 1
slot2.TASKACTIVITYINFOGAINVALUEFIELD.has_default_value = false
slot2.TASKACTIVITYINFOGAINVALUEFIELD.default_value = 0
slot2.TASKACTIVITYINFOGAINVALUEFIELD.type = 5
slot2.TASKACTIVITYINFOGAINVALUEFIELD.cpp_type = 1
slot2.TASKACTIVITYINFOEXPIRYTIMEFIELD.name = "expiryTime"
slot2.TASKACTIVITYINFOEXPIRYTIMEFIELD.full_name = ".TaskActivityInfo.expiryTime"
slot2.TASKACTIVITYINFOEXPIRYTIMEFIELD.number = 5
slot2.TASKACTIVITYINFOEXPIRYTIMEFIELD.index = 4
slot2.TASKACTIVITYINFOEXPIRYTIMEFIELD.label = 2
slot2.TASKACTIVITYINFOEXPIRYTIMEFIELD.has_default_value = false
slot2.TASKACTIVITYINFOEXPIRYTIMEFIELD.default_value = 0
slot2.TASKACTIVITYINFOEXPIRYTIMEFIELD.type = 5
slot2.TASKACTIVITYINFOEXPIRYTIMEFIELD.cpp_type = 1
slot2.TASKACTIVITYINFO_MSG.name = "TaskActivityInfo"
slot2.TASKACTIVITYINFO_MSG.full_name = ".TaskActivityInfo"
slot2.TASKACTIVITYINFO_MSG.nested_types = {}
slot2.TASKACTIVITYINFO_MSG.enum_types = {}
slot2.TASKACTIVITYINFO_MSG.fields = {
	slot2.TASKACTIVITYINFOTYPEIDFIELD,
	slot2.TASKACTIVITYINFODEFINEIDFIELD,
	slot2.TASKACTIVITYINFOVALUEFIELD,
	slot2.TASKACTIVITYINFOGAINVALUEFIELD,
	slot2.TASKACTIVITYINFOEXPIRYTIMEFIELD
}
slot2.TASKACTIVITYINFO_MSG.is_extendable = false
slot2.TASKACTIVITYINFO_MSG.extensions = {}
slot2.FINISHREADTASKREQUESTTASKIDFIELD.name = "taskId"
slot2.FINISHREADTASKREQUESTTASKIDFIELD.full_name = ".FinishReadTaskRequest.taskId"
slot2.FINISHREADTASKREQUESTTASKIDFIELD.number = 1
slot2.FINISHREADTASKREQUESTTASKIDFIELD.index = 0
slot2.FINISHREADTASKREQUESTTASKIDFIELD.label = 1
slot2.FINISHREADTASKREQUESTTASKIDFIELD.has_default_value = false
slot2.FINISHREADTASKREQUESTTASKIDFIELD.default_value = 0
slot2.FINISHREADTASKREQUESTTASKIDFIELD.type = 5
slot2.FINISHREADTASKREQUESTTASKIDFIELD.cpp_type = 1
slot2.FINISHREADTASKREQUEST_MSG.name = "FinishReadTaskRequest"
slot2.FINISHREADTASKREQUEST_MSG.full_name = ".FinishReadTaskRequest"
slot2.FINISHREADTASKREQUEST_MSG.nested_types = {}
slot2.FINISHREADTASKREQUEST_MSG.enum_types = {}
slot2.FINISHREADTASKREQUEST_MSG.fields = {
	slot2.FINISHREADTASKREQUESTTASKIDFIELD
}
slot2.FINISHREADTASKREQUEST_MSG.is_extendable = false
slot2.FINISHREADTASKREQUEST_MSG.extensions = {}
slot2.GETTASKINFOREQUESTTYPEIDSFIELD.name = "typeIds"
slot2.GETTASKINFOREQUESTTYPEIDSFIELD.full_name = ".GetTaskInfoRequest.typeIds"
slot2.GETTASKINFOREQUESTTYPEIDSFIELD.number = 1
slot2.GETTASKINFOREQUESTTYPEIDSFIELD.index = 0
slot2.GETTASKINFOREQUESTTYPEIDSFIELD.label = 3
slot2.GETTASKINFOREQUESTTYPEIDSFIELD.has_default_value = false
slot2.GETTASKINFOREQUESTTYPEIDSFIELD.default_value = {}
slot2.GETTASKINFOREQUESTTYPEIDSFIELD.type = 13
slot2.GETTASKINFOREQUESTTYPEIDSFIELD.cpp_type = 3
slot2.GETTASKINFOREQUEST_MSG.name = "GetTaskInfoRequest"
slot2.GETTASKINFOREQUEST_MSG.full_name = ".GetTaskInfoRequest"
slot2.GETTASKINFOREQUEST_MSG.nested_types = {}
slot2.GETTASKINFOREQUEST_MSG.enum_types = {}
slot2.GETTASKINFOREQUEST_MSG.fields = {
	slot2.GETTASKINFOREQUESTTYPEIDSFIELD
}
slot2.GETTASKINFOREQUEST_MSG.is_extendable = false
slot2.GETTASKINFOREQUEST_MSG.extensions = {}
slot2.FINISHALLTASKREQUESTTYPEIDFIELD.name = "typeId"
slot2.FINISHALLTASKREQUESTTYPEIDFIELD.full_name = ".FinishAllTaskRequest.typeId"
slot2.FINISHALLTASKREQUESTTYPEIDFIELD.number = 1
slot2.FINISHALLTASKREQUESTTYPEIDFIELD.index = 0
slot2.FINISHALLTASKREQUESTTYPEIDFIELD.label = 1
slot2.FINISHALLTASKREQUESTTYPEIDFIELD.has_default_value = false
slot2.FINISHALLTASKREQUESTTYPEIDFIELD.default_value = 0
slot2.FINISHALLTASKREQUESTTYPEIDFIELD.type = 5
slot2.FINISHALLTASKREQUESTTYPEIDFIELD.cpp_type = 1
slot2.FINISHALLTASKREQUESTMINTYPEIDFIELD.name = "minTypeId"
slot2.FINISHALLTASKREQUESTMINTYPEIDFIELD.full_name = ".FinishAllTaskRequest.minTypeId"
slot2.FINISHALLTASKREQUESTMINTYPEIDFIELD.number = 2
slot2.FINISHALLTASKREQUESTMINTYPEIDFIELD.index = 1
slot2.FINISHALLTASKREQUESTMINTYPEIDFIELD.label = 1
slot2.FINISHALLTASKREQUESTMINTYPEIDFIELD.has_default_value = false
slot2.FINISHALLTASKREQUESTMINTYPEIDFIELD.default_value = 0
slot2.FINISHALLTASKREQUESTMINTYPEIDFIELD.type = 5
slot2.FINISHALLTASKREQUESTMINTYPEIDFIELD.cpp_type = 1
slot2.FINISHALLTASKREQUESTTASKIDSFIELD.name = "taskIds"
slot2.FINISHALLTASKREQUESTTASKIDSFIELD.full_name = ".FinishAllTaskRequest.taskIds"
slot2.FINISHALLTASKREQUESTTASKIDSFIELD.number = 3
slot2.FINISHALLTASKREQUESTTASKIDSFIELD.index = 2
slot2.FINISHALLTASKREQUESTTASKIDSFIELD.label = 3
slot2.FINISHALLTASKREQUESTTASKIDSFIELD.has_default_value = false
slot2.FINISHALLTASKREQUESTTASKIDSFIELD.default_value = {}
slot2.FINISHALLTASKREQUESTTASKIDSFIELD.type = 5
slot2.FINISHALLTASKREQUESTTASKIDSFIELD.cpp_type = 1
slot2.FINISHALLTASKREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.FINISHALLTASKREQUESTACTIVITYIDFIELD.full_name = ".FinishAllTaskRequest.activityId"
slot2.FINISHALLTASKREQUESTACTIVITYIDFIELD.number = 4
slot2.FINISHALLTASKREQUESTACTIVITYIDFIELD.index = 3
slot2.FINISHALLTASKREQUESTACTIVITYIDFIELD.label = 1
slot2.FINISHALLTASKREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.FINISHALLTASKREQUESTACTIVITYIDFIELD.default_value = 0
slot2.FINISHALLTASKREQUESTACTIVITYIDFIELD.type = 5
slot2.FINISHALLTASKREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.FINISHALLTASKREQUEST_MSG.name = "FinishAllTaskRequest"
slot2.FINISHALLTASKREQUEST_MSG.full_name = ".FinishAllTaskRequest"
slot2.FINISHALLTASKREQUEST_MSG.nested_types = {}
slot2.FINISHALLTASKREQUEST_MSG.enum_types = {}
slot2.FINISHALLTASKREQUEST_MSG.fields = {
	slot2.FINISHALLTASKREQUESTTYPEIDFIELD,
	slot2.FINISHALLTASKREQUESTMINTYPEIDFIELD,
	slot2.FINISHALLTASKREQUESTTASKIDSFIELD,
	slot2.FINISHALLTASKREQUESTACTIVITYIDFIELD
}
slot2.FINISHALLTASKREQUEST_MSG.is_extendable = false
slot2.FINISHALLTASKREQUEST_MSG.extensions = {}
slot2.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.name = "typeId"
slot2.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.full_name = ".GetTaskActivityBonusReply.typeId"
slot2.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.number = 1
slot2.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.index = 0
slot2.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.label = 1
slot2.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.has_default_value = false
slot2.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.default_value = 0
slot2.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.type = 5
slot2.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD.cpp_type = 1
slot2.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.name = "defineId"
slot2.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.full_name = ".GetTaskActivityBonusReply.defineId"
slot2.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.number = 2
slot2.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.index = 1
slot2.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.label = 1
slot2.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.has_default_value = false
slot2.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.default_value = 0
slot2.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.type = 5
slot2.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD.cpp_type = 1
slot2.GETTASKACTIVITYBONUSREPLY_MSG.name = "GetTaskActivityBonusReply"
slot2.GETTASKACTIVITYBONUSREPLY_MSG.full_name = ".GetTaskActivityBonusReply"
slot2.GETTASKACTIVITYBONUSREPLY_MSG.nested_types = {}
slot2.GETTASKACTIVITYBONUSREPLY_MSG.enum_types = {}
slot2.GETTASKACTIVITYBONUSREPLY_MSG.fields = {
	slot2.GETTASKACTIVITYBONUSREPLYTYPEIDFIELD,
	slot2.GETTASKACTIVITYBONUSREPLYDEFINEIDFIELD
}
slot2.GETTASKACTIVITYBONUSREPLY_MSG.is_extendable = false
slot2.GETTASKACTIVITYBONUSREPLY_MSG.extensions = {}
slot2.FINISHALLTASKREPLYTYPEIDFIELD.name = "typeId"
slot2.FINISHALLTASKREPLYTYPEIDFIELD.full_name = ".FinishAllTaskReply.typeId"
slot2.FINISHALLTASKREPLYTYPEIDFIELD.number = 1
slot2.FINISHALLTASKREPLYTYPEIDFIELD.index = 0
slot2.FINISHALLTASKREPLYTYPEIDFIELD.label = 1
slot2.FINISHALLTASKREPLYTYPEIDFIELD.has_default_value = false
slot2.FINISHALLTASKREPLYTYPEIDFIELD.default_value = 0
slot2.FINISHALLTASKREPLYTYPEIDFIELD.type = 5
slot2.FINISHALLTASKREPLYTYPEIDFIELD.cpp_type = 1
slot2.FINISHALLTASKREPLYMINTYPEIDFIELD.name = "minTypeId"
slot2.FINISHALLTASKREPLYMINTYPEIDFIELD.full_name = ".FinishAllTaskReply.minTypeId"
slot2.FINISHALLTASKREPLYMINTYPEIDFIELD.number = 2
slot2.FINISHALLTASKREPLYMINTYPEIDFIELD.index = 1
slot2.FINISHALLTASKREPLYMINTYPEIDFIELD.label = 1
slot2.FINISHALLTASKREPLYMINTYPEIDFIELD.has_default_value = false
slot2.FINISHALLTASKREPLYMINTYPEIDFIELD.default_value = 0
slot2.FINISHALLTASKREPLYMINTYPEIDFIELD.type = 5
slot2.FINISHALLTASKREPLYMINTYPEIDFIELD.cpp_type = 1
slot2.FINISHALLTASKREPLYTASKIDSFIELD.name = "taskIds"
slot2.FINISHALLTASKREPLYTASKIDSFIELD.full_name = ".FinishAllTaskReply.taskIds"
slot2.FINISHALLTASKREPLYTASKIDSFIELD.number = 3
slot2.FINISHALLTASKREPLYTASKIDSFIELD.index = 2
slot2.FINISHALLTASKREPLYTASKIDSFIELD.label = 3
slot2.FINISHALLTASKREPLYTASKIDSFIELD.has_default_value = false
slot2.FINISHALLTASKREPLYTASKIDSFIELD.default_value = {}
slot2.FINISHALLTASKREPLYTASKIDSFIELD.type = 5
slot2.FINISHALLTASKREPLYTASKIDSFIELD.cpp_type = 1
slot2.FINISHALLTASKREPLYACTIVITYIDFIELD.name = "activityId"
slot2.FINISHALLTASKREPLYACTIVITYIDFIELD.full_name = ".FinishAllTaskReply.activityId"
slot2.FINISHALLTASKREPLYACTIVITYIDFIELD.number = 4
slot2.FINISHALLTASKREPLYACTIVITYIDFIELD.index = 3
slot2.FINISHALLTASKREPLYACTIVITYIDFIELD.label = 1
slot2.FINISHALLTASKREPLYACTIVITYIDFIELD.has_default_value = false
slot2.FINISHALLTASKREPLYACTIVITYIDFIELD.default_value = 0
slot2.FINISHALLTASKREPLYACTIVITYIDFIELD.type = 5
slot2.FINISHALLTASKREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.FINISHALLTASKREPLY_MSG.name = "FinishAllTaskReply"
slot2.FINISHALLTASKREPLY_MSG.full_name = ".FinishAllTaskReply"
slot2.FINISHALLTASKREPLY_MSG.nested_types = {}
slot2.FINISHALLTASKREPLY_MSG.enum_types = {}
slot2.FINISHALLTASKREPLY_MSG.fields = {
	slot2.FINISHALLTASKREPLYTYPEIDFIELD,
	slot2.FINISHALLTASKREPLYMINTYPEIDFIELD,
	slot2.FINISHALLTASKREPLYTASKIDSFIELD,
	slot2.FINISHALLTASKREPLYACTIVITYIDFIELD
}
slot2.FINISHALLTASKREPLY_MSG.is_extendable = false
slot2.FINISHALLTASKREPLY_MSG.extensions = {}
slot2.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.name = "typeId"
slot2.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.full_name = ".GetTaskActivityBonusRequest.typeId"
slot2.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.number = 1
slot2.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.index = 0
slot2.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.label = 1
slot2.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.has_default_value = false
slot2.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.default_value = 0
slot2.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.type = 5
slot2.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD.cpp_type = 1
slot2.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.name = "defineId"
slot2.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.full_name = ".GetTaskActivityBonusRequest.defineId"
slot2.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.number = 2
slot2.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.index = 1
slot2.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.label = 1
slot2.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.has_default_value = false
slot2.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.default_value = 0
slot2.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.type = 5
slot2.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD.cpp_type = 1
slot2.GETTASKACTIVITYBONUSREQUEST_MSG.name = "GetTaskActivityBonusRequest"
slot2.GETTASKACTIVITYBONUSREQUEST_MSG.full_name = ".GetTaskActivityBonusRequest"
slot2.GETTASKACTIVITYBONUSREQUEST_MSG.nested_types = {}
slot2.GETTASKACTIVITYBONUSREQUEST_MSG.enum_types = {}
slot2.GETTASKACTIVITYBONUSREQUEST_MSG.fields = {
	slot2.GETTASKACTIVITYBONUSREQUESTTYPEIDFIELD,
	slot2.GETTASKACTIVITYBONUSREQUESTDEFINEIDFIELD
}
slot2.GETTASKACTIVITYBONUSREQUEST_MSG.is_extendable = false
slot2.GETTASKACTIVITYBONUSREQUEST_MSG.extensions = {}
slot2.FINISHREADTASKREPLYTASKIDFIELD.name = "taskId"
slot2.FINISHREADTASKREPLYTASKIDFIELD.full_name = ".FinishReadTaskReply.taskId"
slot2.FINISHREADTASKREPLYTASKIDFIELD.number = 1
slot2.FINISHREADTASKREPLYTASKIDFIELD.index = 0
slot2.FINISHREADTASKREPLYTASKIDFIELD.label = 1
slot2.FINISHREADTASKREPLYTASKIDFIELD.has_default_value = false
slot2.FINISHREADTASKREPLYTASKIDFIELD.default_value = 0
slot2.FINISHREADTASKREPLYTASKIDFIELD.type = 5
slot2.FINISHREADTASKREPLYTASKIDFIELD.cpp_type = 1
slot2.FINISHREADTASKREPLY_MSG.name = "FinishReadTaskReply"
slot2.FINISHREADTASKREPLY_MSG.full_name = ".FinishReadTaskReply"
slot2.FINISHREADTASKREPLY_MSG.nested_types = {}
slot2.FINISHREADTASKREPLY_MSG.enum_types = {}
slot2.FINISHREADTASKREPLY_MSG.fields = {
	slot2.FINISHREADTASKREPLYTASKIDFIELD
}
slot2.FINISHREADTASKREPLY_MSG.is_extendable = false
slot2.FINISHREADTASKREPLY_MSG.extensions = {}
slot2.UPDATETASKPUSHTASKINFOFIELD.name = "taskInfo"
slot2.UPDATETASKPUSHTASKINFOFIELD.full_name = ".UpdateTaskPush.taskInfo"
slot2.UPDATETASKPUSHTASKINFOFIELD.number = 1
slot2.UPDATETASKPUSHTASKINFOFIELD.index = 0
slot2.UPDATETASKPUSHTASKINFOFIELD.label = 3
slot2.UPDATETASKPUSHTASKINFOFIELD.has_default_value = false
slot2.UPDATETASKPUSHTASKINFOFIELD.default_value = {}
slot2.UPDATETASKPUSHTASKINFOFIELD.message_type = slot2.TASK_MSG
slot2.UPDATETASKPUSHTASKINFOFIELD.type = 11
slot2.UPDATETASKPUSHTASKINFOFIELD.cpp_type = 10
slot2.UPDATETASKPUSHACTIVITYINFOFIELD.name = "activityInfo"
slot2.UPDATETASKPUSHACTIVITYINFOFIELD.full_name = ".UpdateTaskPush.activityInfo"
slot2.UPDATETASKPUSHACTIVITYINFOFIELD.number = 2
slot2.UPDATETASKPUSHACTIVITYINFOFIELD.index = 1
slot2.UPDATETASKPUSHACTIVITYINFOFIELD.label = 3
slot2.UPDATETASKPUSHACTIVITYINFOFIELD.has_default_value = false
slot2.UPDATETASKPUSHACTIVITYINFOFIELD.default_value = {}
slot2.UPDATETASKPUSHACTIVITYINFOFIELD.message_type = slot2.TASKACTIVITYINFO_MSG
slot2.UPDATETASKPUSHACTIVITYINFOFIELD.type = 11
slot2.UPDATETASKPUSHACTIVITYINFOFIELD.cpp_type = 10
slot2.UPDATETASKPUSH_MSG.name = "UpdateTaskPush"
slot2.UPDATETASKPUSH_MSG.full_name = ".UpdateTaskPush"
slot2.UPDATETASKPUSH_MSG.nested_types = {}
slot2.UPDATETASKPUSH_MSG.enum_types = {}
slot2.UPDATETASKPUSH_MSG.fields = {
	slot2.UPDATETASKPUSHTASKINFOFIELD,
	slot2.UPDATETASKPUSHACTIVITYINFOFIELD
}
slot2.UPDATETASKPUSH_MSG.is_extendable = false
slot2.UPDATETASKPUSH_MSG.extensions = {}
slot2.FINISHTASKREQUESTIDFIELD.name = "id"
slot2.FINISHTASKREQUESTIDFIELD.full_name = ".FinishTaskRequest.id"
slot2.FINISHTASKREQUESTIDFIELD.number = 1
slot2.FINISHTASKREQUESTIDFIELD.index = 0
slot2.FINISHTASKREQUESTIDFIELD.label = 2
slot2.FINISHTASKREQUESTIDFIELD.has_default_value = false
slot2.FINISHTASKREQUESTIDFIELD.default_value = 0
slot2.FINISHTASKREQUESTIDFIELD.type = 5
slot2.FINISHTASKREQUESTIDFIELD.cpp_type = 1
slot2.FINISHTASKREQUEST_MSG.name = "FinishTaskRequest"
slot2.FINISHTASKREQUEST_MSG.full_name = ".FinishTaskRequest"
slot2.FINISHTASKREQUEST_MSG.nested_types = {}
slot2.FINISHTASKREQUEST_MSG.enum_types = {}
slot2.FINISHTASKREQUEST_MSG.fields = {
	slot2.FINISHTASKREQUESTIDFIELD
}
slot2.FINISHTASKREQUEST_MSG.is_extendable = false
slot2.FINISHTASKREQUEST_MSG.extensions = {}
slot2.FINISHTASKREPLYIDFIELD.name = "id"
slot2.FINISHTASKREPLYIDFIELD.full_name = ".FinishTaskReply.id"
slot2.FINISHTASKREPLYIDFIELD.number = 1
slot2.FINISHTASKREPLYIDFIELD.index = 0
slot2.FINISHTASKREPLYIDFIELD.label = 1
slot2.FINISHTASKREPLYIDFIELD.has_default_value = false
slot2.FINISHTASKREPLYIDFIELD.default_value = 0
slot2.FINISHTASKREPLYIDFIELD.type = 5
slot2.FINISHTASKREPLYIDFIELD.cpp_type = 1
slot2.FINISHTASKREPLYFINISHCOUNTFIELD.name = "finishCount"
slot2.FINISHTASKREPLYFINISHCOUNTFIELD.full_name = ".FinishTaskReply.finishCount"
slot2.FINISHTASKREPLYFINISHCOUNTFIELD.number = 2
slot2.FINISHTASKREPLYFINISHCOUNTFIELD.index = 1
slot2.FINISHTASKREPLYFINISHCOUNTFIELD.label = 1
slot2.FINISHTASKREPLYFINISHCOUNTFIELD.has_default_value = false
slot2.FINISHTASKREPLYFINISHCOUNTFIELD.default_value = 0
slot2.FINISHTASKREPLYFINISHCOUNTFIELD.type = 5
slot2.FINISHTASKREPLYFINISHCOUNTFIELD.cpp_type = 1
slot2.FINISHTASKREPLY_MSG.name = "FinishTaskReply"
slot2.FINISHTASKREPLY_MSG.full_name = ".FinishTaskReply"
slot2.FINISHTASKREPLY_MSG.nested_types = {}
slot2.FINISHTASKREPLY_MSG.enum_types = {}
slot2.FINISHTASKREPLY_MSG.fields = {
	slot2.FINISHTASKREPLYIDFIELD,
	slot2.FINISHTASKREPLYFINISHCOUNTFIELD
}
slot2.FINISHTASKREPLY_MSG.is_extendable = false
slot2.FINISHTASKREPLY_MSG.extensions = {}
slot2.DELETETASKPUSHTASKIDSFIELD.name = "taskIds"
slot2.DELETETASKPUSHTASKIDSFIELD.full_name = ".DeleteTaskPush.taskIds"
slot2.DELETETASKPUSHTASKIDSFIELD.number = 1
slot2.DELETETASKPUSHTASKIDSFIELD.index = 0
slot2.DELETETASKPUSHTASKIDSFIELD.label = 3
slot2.DELETETASKPUSHTASKIDSFIELD.has_default_value = false
slot2.DELETETASKPUSHTASKIDSFIELD.default_value = {}
slot2.DELETETASKPUSHTASKIDSFIELD.type = 5
slot2.DELETETASKPUSHTASKIDSFIELD.cpp_type = 1
slot2.DELETETASKPUSH_MSG.name = "DeleteTaskPush"
slot2.DELETETASKPUSH_MSG.full_name = ".DeleteTaskPush"
slot2.DELETETASKPUSH_MSG.nested_types = {}
slot2.DELETETASKPUSH_MSG.enum_types = {}
slot2.DELETETASKPUSH_MSG.fields = {
	slot2.DELETETASKPUSHTASKIDSFIELD
}
slot2.DELETETASKPUSH_MSG.is_extendable = false
slot2.DELETETASKPUSH_MSG.extensions = {}
slot2.GETTASKINFOREPLYTASKINFOFIELD.name = "taskInfo"
slot2.GETTASKINFOREPLYTASKINFOFIELD.full_name = ".GetTaskInfoReply.taskInfo"
slot2.GETTASKINFOREPLYTASKINFOFIELD.number = 1
slot2.GETTASKINFOREPLYTASKINFOFIELD.index = 0
slot2.GETTASKINFOREPLYTASKINFOFIELD.label = 3
slot2.GETTASKINFOREPLYTASKINFOFIELD.has_default_value = false
slot2.GETTASKINFOREPLYTASKINFOFIELD.default_value = {}
slot2.GETTASKINFOREPLYTASKINFOFIELD.message_type = slot2.TASK_MSG
slot2.GETTASKINFOREPLYTASKINFOFIELD.type = 11
slot2.GETTASKINFOREPLYTASKINFOFIELD.cpp_type = 10
slot2.GETTASKINFOREPLYACTIVITYINFOFIELD.name = "activityInfo"
slot2.GETTASKINFOREPLYACTIVITYINFOFIELD.full_name = ".GetTaskInfoReply.activityInfo"
slot2.GETTASKINFOREPLYACTIVITYINFOFIELD.number = 2
slot2.GETTASKINFOREPLYACTIVITYINFOFIELD.index = 1
slot2.GETTASKINFOREPLYACTIVITYINFOFIELD.label = 3
slot2.GETTASKINFOREPLYACTIVITYINFOFIELD.has_default_value = false
slot2.GETTASKINFOREPLYACTIVITYINFOFIELD.default_value = {}
slot2.GETTASKINFOREPLYACTIVITYINFOFIELD.message_type = slot2.TASKACTIVITYINFO_MSG
slot2.GETTASKINFOREPLYACTIVITYINFOFIELD.type = 11
slot2.GETTASKINFOREPLYACTIVITYINFOFIELD.cpp_type = 10
slot2.GETTASKINFOREPLYTYPEIDSFIELD.name = "typeIds"
slot2.GETTASKINFOREPLYTYPEIDSFIELD.full_name = ".GetTaskInfoReply.typeIds"
slot2.GETTASKINFOREPLYTYPEIDSFIELD.number = 3
slot2.GETTASKINFOREPLYTYPEIDSFIELD.index = 2
slot2.GETTASKINFOREPLYTYPEIDSFIELD.label = 3
slot2.GETTASKINFOREPLYTYPEIDSFIELD.has_default_value = false
slot2.GETTASKINFOREPLYTYPEIDSFIELD.default_value = {}
slot2.GETTASKINFOREPLYTYPEIDSFIELD.type = 13
slot2.GETTASKINFOREPLYTYPEIDSFIELD.cpp_type = 3
slot2.GETTASKINFOREPLY_MSG.name = "GetTaskInfoReply"
slot2.GETTASKINFOREPLY_MSG.full_name = ".GetTaskInfoReply"
slot2.GETTASKINFOREPLY_MSG.nested_types = {}
slot2.GETTASKINFOREPLY_MSG.enum_types = {}
slot2.GETTASKINFOREPLY_MSG.fields = {
	slot2.GETTASKINFOREPLYTASKINFOFIELD,
	slot2.GETTASKINFOREPLYACTIVITYINFOFIELD,
	slot2.GETTASKINFOREPLYTYPEIDSFIELD
}
slot2.GETTASKINFOREPLY_MSG.is_extendable = false
slot2.GETTASKINFOREPLY_MSG.extensions = {}
slot2.DeleteTaskPush = slot1.Message(slot2.DELETETASKPUSH_MSG)
slot2.FinishAllTaskReply = slot1.Message(slot2.FINISHALLTASKREPLY_MSG)
slot2.FinishAllTaskRequest = slot1.Message(slot2.FINISHALLTASKREQUEST_MSG)
slot2.FinishReadTaskReply = slot1.Message(slot2.FINISHREADTASKREPLY_MSG)
slot2.FinishReadTaskRequest = slot1.Message(slot2.FINISHREADTASKREQUEST_MSG)
slot2.FinishTaskReply = slot1.Message(slot2.FINISHTASKREPLY_MSG)
slot2.FinishTaskRequest = slot1.Message(slot2.FINISHTASKREQUEST_MSG)
slot2.GetTaskActivityBonusReply = slot1.Message(slot2.GETTASKACTIVITYBONUSREPLY_MSG)
slot2.GetTaskActivityBonusRequest = slot1.Message(slot2.GETTASKACTIVITYBONUSREQUEST_MSG)
slot2.GetTaskInfoReply = slot1.Message(slot2.GETTASKINFOREPLY_MSG)
slot2.GetTaskInfoRequest = slot1.Message(slot2.GETTASKINFOREQUEST_MSG)
slot2.Task = slot1.Message(slot2.TASK_MSG)
slot2.TaskActivityInfo = slot1.Message(slot2.TASKACTIVITYINFO_MSG)
slot2.UpdateTaskPush = slot1.Message(slot2.UPDATETASKPUSH_MSG)

return slot2
