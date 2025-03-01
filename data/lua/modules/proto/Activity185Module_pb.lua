slot1 = require("protobuf.protobuf")

module("modules.proto.Activity185Module_pb", package.seeall)

slot2 = {
	ACT185EPISODENO_MSG = slot1.Descriptor(),
	ACT185EPISODENOEPISODEIDFIELD = slot1.FieldDescriptor(),
	ACT185EPISODENOISFINISHEDFIELD = slot1.FieldDescriptor(),
	ACT185FINISHEPISODEREQUEST_MSG = slot1.Descriptor(),
	ACT185FINISHEPISODEREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT185FINISHEPISODEREQUESTEPISODEIDFIELD = slot1.FieldDescriptor(),
	GETACT185INFOREQUEST_MSG = slot1.Descriptor(),
	GETACT185INFOREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor(),
	GETACT185INFOREPLY_MSG = slot1.Descriptor(),
	GETACT185INFOREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	GETACT185INFOREPLYEPISODESFIELD = slot1.FieldDescriptor(),
	ACT185FINISHEPISODEREPLY_MSG = slot1.Descriptor(),
	ACT185FINISHEPISODEREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT185FINISHEPISODEREPLYEPISODEIDFIELD = slot1.FieldDescriptor(),
	ACT185EPISODEPUSH_MSG = slot1.Descriptor(),
	ACT185EPISODEPUSHACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT185EPISODEPUSHEPISODESFIELD = slot1.FieldDescriptor()
}
slot2.ACT185EPISODENOEPISODEIDFIELD.name = "episodeId"
slot2.ACT185EPISODENOEPISODEIDFIELD.full_name = ".Act185EpisodeNO.episodeId"
slot2.ACT185EPISODENOEPISODEIDFIELD.number = 1
slot2.ACT185EPISODENOEPISODEIDFIELD.index = 0
slot2.ACT185EPISODENOEPISODEIDFIELD.label = 1
slot2.ACT185EPISODENOEPISODEIDFIELD.has_default_value = false
slot2.ACT185EPISODENOEPISODEIDFIELD.default_value = 0
slot2.ACT185EPISODENOEPISODEIDFIELD.type = 5
slot2.ACT185EPISODENOEPISODEIDFIELD.cpp_type = 1
slot2.ACT185EPISODENOISFINISHEDFIELD.name = "isFinished"
slot2.ACT185EPISODENOISFINISHEDFIELD.full_name = ".Act185EpisodeNO.isFinished"
slot2.ACT185EPISODENOISFINISHEDFIELD.number = 2
slot2.ACT185EPISODENOISFINISHEDFIELD.index = 1
slot2.ACT185EPISODENOISFINISHEDFIELD.label = 1
slot2.ACT185EPISODENOISFINISHEDFIELD.has_default_value = false
slot2.ACT185EPISODENOISFINISHEDFIELD.default_value = false
slot2.ACT185EPISODENOISFINISHEDFIELD.type = 8
slot2.ACT185EPISODENOISFINISHEDFIELD.cpp_type = 7
slot2.ACT185EPISODENO_MSG.name = "Act185EpisodeNO"
slot2.ACT185EPISODENO_MSG.full_name = ".Act185EpisodeNO"
slot2.ACT185EPISODENO_MSG.nested_types = {}
slot2.ACT185EPISODENO_MSG.enum_types = {}
slot2.ACT185EPISODENO_MSG.fields = {
	slot2.ACT185EPISODENOEPISODEIDFIELD,
	slot2.ACT185EPISODENOISFINISHEDFIELD
}
slot2.ACT185EPISODENO_MSG.is_extendable = false
slot2.ACT185EPISODENO_MSG.extensions = {}
slot2.ACT185FINISHEPISODEREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.ACT185FINISHEPISODEREQUESTACTIVITYIDFIELD.full_name = ".Act185FinishEpisodeRequest.activityId"
slot2.ACT185FINISHEPISODEREQUESTACTIVITYIDFIELD.number = 1
slot2.ACT185FINISHEPISODEREQUESTACTIVITYIDFIELD.index = 0
slot2.ACT185FINISHEPISODEREQUESTACTIVITYIDFIELD.label = 1
slot2.ACT185FINISHEPISODEREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.ACT185FINISHEPISODEREQUESTACTIVITYIDFIELD.default_value = 0
slot2.ACT185FINISHEPISODEREQUESTACTIVITYIDFIELD.type = 5
slot2.ACT185FINISHEPISODEREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.ACT185FINISHEPISODEREQUESTEPISODEIDFIELD.name = "episodeId"
slot2.ACT185FINISHEPISODEREQUESTEPISODEIDFIELD.full_name = ".Act185FinishEpisodeRequest.episodeId"
slot2.ACT185FINISHEPISODEREQUESTEPISODEIDFIELD.number = 2
slot2.ACT185FINISHEPISODEREQUESTEPISODEIDFIELD.index = 1
slot2.ACT185FINISHEPISODEREQUESTEPISODEIDFIELD.label = 1
slot2.ACT185FINISHEPISODEREQUESTEPISODEIDFIELD.has_default_value = false
slot2.ACT185FINISHEPISODEREQUESTEPISODEIDFIELD.default_value = 0
slot2.ACT185FINISHEPISODEREQUESTEPISODEIDFIELD.type = 5
slot2.ACT185FINISHEPISODEREQUESTEPISODEIDFIELD.cpp_type = 1
slot2.ACT185FINISHEPISODEREQUEST_MSG.name = "Act185FinishEpisodeRequest"
slot2.ACT185FINISHEPISODEREQUEST_MSG.full_name = ".Act185FinishEpisodeRequest"
slot2.ACT185FINISHEPISODEREQUEST_MSG.nested_types = {}
slot2.ACT185FINISHEPISODEREQUEST_MSG.enum_types = {}
slot2.ACT185FINISHEPISODEREQUEST_MSG.fields = {
	slot2.ACT185FINISHEPISODEREQUESTACTIVITYIDFIELD,
	slot2.ACT185FINISHEPISODEREQUESTEPISODEIDFIELD
}
slot2.ACT185FINISHEPISODEREQUEST_MSG.is_extendable = false
slot2.ACT185FINISHEPISODEREQUEST_MSG.extensions = {}
slot2.GETACT185INFOREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.GETACT185INFOREQUESTACTIVITYIDFIELD.full_name = ".GetAct185InfoRequest.activityId"
slot2.GETACT185INFOREQUESTACTIVITYIDFIELD.number = 1
slot2.GETACT185INFOREQUESTACTIVITYIDFIELD.index = 0
slot2.GETACT185INFOREQUESTACTIVITYIDFIELD.label = 1
slot2.GETACT185INFOREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.GETACT185INFOREQUESTACTIVITYIDFIELD.default_value = 0
slot2.GETACT185INFOREQUESTACTIVITYIDFIELD.type = 5
slot2.GETACT185INFOREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.GETACT185INFOREQUEST_MSG.name = "GetAct185InfoRequest"
slot2.GETACT185INFOREQUEST_MSG.full_name = ".GetAct185InfoRequest"
slot2.GETACT185INFOREQUEST_MSG.nested_types = {}
slot2.GETACT185INFOREQUEST_MSG.enum_types = {}
slot2.GETACT185INFOREQUEST_MSG.fields = {
	slot2.GETACT185INFOREQUESTACTIVITYIDFIELD
}
slot2.GETACT185INFOREQUEST_MSG.is_extendable = false
slot2.GETACT185INFOREQUEST_MSG.extensions = {}
slot2.GETACT185INFOREPLYACTIVITYIDFIELD.name = "activityId"
slot2.GETACT185INFOREPLYACTIVITYIDFIELD.full_name = ".GetAct185InfoReply.activityId"
slot2.GETACT185INFOREPLYACTIVITYIDFIELD.number = 1
slot2.GETACT185INFOREPLYACTIVITYIDFIELD.index = 0
slot2.GETACT185INFOREPLYACTIVITYIDFIELD.label = 1
slot2.GETACT185INFOREPLYACTIVITYIDFIELD.has_default_value = false
slot2.GETACT185INFOREPLYACTIVITYIDFIELD.default_value = 0
slot2.GETACT185INFOREPLYACTIVITYIDFIELD.type = 5
slot2.GETACT185INFOREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.GETACT185INFOREPLYEPISODESFIELD.name = "episodes"
slot2.GETACT185INFOREPLYEPISODESFIELD.full_name = ".GetAct185InfoReply.episodes"
slot2.GETACT185INFOREPLYEPISODESFIELD.number = 2
slot2.GETACT185INFOREPLYEPISODESFIELD.index = 1
slot2.GETACT185INFOREPLYEPISODESFIELD.label = 3
slot2.GETACT185INFOREPLYEPISODESFIELD.has_default_value = false
slot2.GETACT185INFOREPLYEPISODESFIELD.default_value = {}
slot2.GETACT185INFOREPLYEPISODESFIELD.message_type = slot2.ACT185EPISODENO_MSG
slot2.GETACT185INFOREPLYEPISODESFIELD.type = 11
slot2.GETACT185INFOREPLYEPISODESFIELD.cpp_type = 10
slot2.GETACT185INFOREPLY_MSG.name = "GetAct185InfoReply"
slot2.GETACT185INFOREPLY_MSG.full_name = ".GetAct185InfoReply"
slot2.GETACT185INFOREPLY_MSG.nested_types = {}
slot2.GETACT185INFOREPLY_MSG.enum_types = {}
slot2.GETACT185INFOREPLY_MSG.fields = {
	slot2.GETACT185INFOREPLYACTIVITYIDFIELD,
	slot2.GETACT185INFOREPLYEPISODESFIELD
}
slot2.GETACT185INFOREPLY_MSG.is_extendable = false
slot2.GETACT185INFOREPLY_MSG.extensions = {}
slot2.ACT185FINISHEPISODEREPLYACTIVITYIDFIELD.name = "activityId"
slot2.ACT185FINISHEPISODEREPLYACTIVITYIDFIELD.full_name = ".Act185FinishEpisodeReply.activityId"
slot2.ACT185FINISHEPISODEREPLYACTIVITYIDFIELD.number = 1
slot2.ACT185FINISHEPISODEREPLYACTIVITYIDFIELD.index = 0
slot2.ACT185FINISHEPISODEREPLYACTIVITYIDFIELD.label = 1
slot2.ACT185FINISHEPISODEREPLYACTIVITYIDFIELD.has_default_value = false
slot2.ACT185FINISHEPISODEREPLYACTIVITYIDFIELD.default_value = 0
slot2.ACT185FINISHEPISODEREPLYACTIVITYIDFIELD.type = 5
slot2.ACT185FINISHEPISODEREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.ACT185FINISHEPISODEREPLYEPISODEIDFIELD.name = "episodeId"
slot2.ACT185FINISHEPISODEREPLYEPISODEIDFIELD.full_name = ".Act185FinishEpisodeReply.episodeId"
slot2.ACT185FINISHEPISODEREPLYEPISODEIDFIELD.number = 2
slot2.ACT185FINISHEPISODEREPLYEPISODEIDFIELD.index = 1
slot2.ACT185FINISHEPISODEREPLYEPISODEIDFIELD.label = 1
slot2.ACT185FINISHEPISODEREPLYEPISODEIDFIELD.has_default_value = false
slot2.ACT185FINISHEPISODEREPLYEPISODEIDFIELD.default_value = 0
slot2.ACT185FINISHEPISODEREPLYEPISODEIDFIELD.type = 5
slot2.ACT185FINISHEPISODEREPLYEPISODEIDFIELD.cpp_type = 1
slot2.ACT185FINISHEPISODEREPLY_MSG.name = "Act185FinishEpisodeReply"
slot2.ACT185FINISHEPISODEREPLY_MSG.full_name = ".Act185FinishEpisodeReply"
slot2.ACT185FINISHEPISODEREPLY_MSG.nested_types = {}
slot2.ACT185FINISHEPISODEREPLY_MSG.enum_types = {}
slot2.ACT185FINISHEPISODEREPLY_MSG.fields = {
	slot2.ACT185FINISHEPISODEREPLYACTIVITYIDFIELD,
	slot2.ACT185FINISHEPISODEREPLYEPISODEIDFIELD
}
slot2.ACT185FINISHEPISODEREPLY_MSG.is_extendable = false
slot2.ACT185FINISHEPISODEREPLY_MSG.extensions = {}
slot2.ACT185EPISODEPUSHACTIVITYIDFIELD.name = "activityId"
slot2.ACT185EPISODEPUSHACTIVITYIDFIELD.full_name = ".Act185EpisodePush.activityId"
slot2.ACT185EPISODEPUSHACTIVITYIDFIELD.number = 1
slot2.ACT185EPISODEPUSHACTIVITYIDFIELD.index = 0
slot2.ACT185EPISODEPUSHACTIVITYIDFIELD.label = 1
slot2.ACT185EPISODEPUSHACTIVITYIDFIELD.has_default_value = false
slot2.ACT185EPISODEPUSHACTIVITYIDFIELD.default_value = 0
slot2.ACT185EPISODEPUSHACTIVITYIDFIELD.type = 5
slot2.ACT185EPISODEPUSHACTIVITYIDFIELD.cpp_type = 1
slot2.ACT185EPISODEPUSHEPISODESFIELD.name = "episodes"
slot2.ACT185EPISODEPUSHEPISODESFIELD.full_name = ".Act185EpisodePush.episodes"
slot2.ACT185EPISODEPUSHEPISODESFIELD.number = 2
slot2.ACT185EPISODEPUSHEPISODESFIELD.index = 1
slot2.ACT185EPISODEPUSHEPISODESFIELD.label = 3
slot2.ACT185EPISODEPUSHEPISODESFIELD.has_default_value = false
slot2.ACT185EPISODEPUSHEPISODESFIELD.default_value = {}
slot2.ACT185EPISODEPUSHEPISODESFIELD.message_type = slot2.ACT185EPISODENO_MSG
slot2.ACT185EPISODEPUSHEPISODESFIELD.type = 11
slot2.ACT185EPISODEPUSHEPISODESFIELD.cpp_type = 10
slot2.ACT185EPISODEPUSH_MSG.name = "Act185EpisodePush"
slot2.ACT185EPISODEPUSH_MSG.full_name = ".Act185EpisodePush"
slot2.ACT185EPISODEPUSH_MSG.nested_types = {}
slot2.ACT185EPISODEPUSH_MSG.enum_types = {}
slot2.ACT185EPISODEPUSH_MSG.fields = {
	slot2.ACT185EPISODEPUSHACTIVITYIDFIELD,
	slot2.ACT185EPISODEPUSHEPISODESFIELD
}
slot2.ACT185EPISODEPUSH_MSG.is_extendable = false
slot2.ACT185EPISODEPUSH_MSG.extensions = {}
slot2.Act185EpisodeNO = slot1.Message(slot2.ACT185EPISODENO_MSG)
slot2.Act185EpisodePush = slot1.Message(slot2.ACT185EPISODEPUSH_MSG)
slot2.Act185FinishEpisodeReply = slot1.Message(slot2.ACT185FINISHEPISODEREPLY_MSG)
slot2.Act185FinishEpisodeRequest = slot1.Message(slot2.ACT185FINISHEPISODEREQUEST_MSG)
slot2.GetAct185InfoReply = slot1.Message(slot2.GETACT185INFOREPLY_MSG)
slot2.GetAct185InfoRequest = slot1.Message(slot2.GETACT185INFOREQUEST_MSG)

return slot2
