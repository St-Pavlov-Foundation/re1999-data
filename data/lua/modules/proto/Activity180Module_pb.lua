slot1 = require("protobuf.protobuf")

module("modules.proto.Activity180Module_pb", package.seeall)

slot2 = {
	ACT180GAMEFINISHREQUEST_MSG = slot1.Descriptor(),
	ACT180GAMEFINISHREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT180GAMEFINISHREQUESTEPISODEIDFIELD = slot1.FieldDescriptor(),
	ACT180ENTEREPISODEREQUEST_MSG = slot1.Descriptor(),
	ACT180ENTEREPISODEREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT180ENTEREPISODEREQUESTEPISODEIDFIELD = slot1.FieldDescriptor(),
	GET180INFOSREQUEST_MSG = slot1.Descriptor(),
	GET180INFOSREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT180ENTEREPISODEREPLY_MSG = slot1.Descriptor(),
	ACT180ENTEREPISODEREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT180ENTEREPISODEREPLYEPISODEFIELD = slot1.FieldDescriptor(),
	ACT180EPISODEPUSH_MSG = slot1.Descriptor(),
	ACT180EPISODEPUSHACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT180EPISODEPUSHACT180EPISODESFIELD = slot1.FieldDescriptor(),
	ACT180STORYREPLY_MSG = slot1.Descriptor(),
	ACT180STORYREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT180STORYREPLYEPISODEFIELD = slot1.FieldDescriptor(),
	ACT180SAVEGAMEREPLY_MSG = slot1.Descriptor(),
	ACT180SAVEGAMEREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT180SAVEGAMEREPLYEPISODEIDFIELD = slot1.FieldDescriptor(),
	ACT180SAVEGAMEREPLYGAMEDATAFIELD = slot1.FieldDescriptor(),
	GET180INFOSREPLY_MSG = slot1.Descriptor(),
	GET180INFOSREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	GET180INFOSREPLYACT180EPISODENOFIELD = slot1.FieldDescriptor(),
	ACT180SAVEGAMEREQUEST_MSG = slot1.Descriptor(),
	ACT180SAVEGAMEREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT180SAVEGAMEREQUESTEPISODEIDFIELD = slot1.FieldDescriptor(),
	ACT180SAVEGAMEREQUESTGAMEDATAFIELD = slot1.FieldDescriptor(),
	ACT180EPISODENO_MSG = slot1.Descriptor(),
	ACT180EPISODENOEPISODEIDFIELD = slot1.FieldDescriptor(),
	ACT180EPISODENOISFINISHEDFIELD = slot1.FieldDescriptor(),
	ACT180EPISODENOSTATUSFIELD = slot1.FieldDescriptor(),
	ACT180EPISODENOGAMESTRINGFIELD = slot1.FieldDescriptor(),
	ACT180STORYREQUEST_MSG = slot1.Descriptor(),
	ACT180STORYREQUESTACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT180STORYREQUESTEPISODEIDFIELD = slot1.FieldDescriptor(),
	ACT180GAMEFINISHREPLY_MSG = slot1.Descriptor(),
	ACT180GAMEFINISHREPLYACTIVITYIDFIELD = slot1.FieldDescriptor(),
	ACT180GAMEFINISHREPLYEPISODEFIELD = slot1.FieldDescriptor()
}
slot2.ACT180GAMEFINISHREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.ACT180GAMEFINISHREQUESTACTIVITYIDFIELD.full_name = ".Act180GameFinishRequest.activityId"
slot2.ACT180GAMEFINISHREQUESTACTIVITYIDFIELD.number = 1
slot2.ACT180GAMEFINISHREQUESTACTIVITYIDFIELD.index = 0
slot2.ACT180GAMEFINISHREQUESTACTIVITYIDFIELD.label = 1
slot2.ACT180GAMEFINISHREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.ACT180GAMEFINISHREQUESTACTIVITYIDFIELD.default_value = 0
slot2.ACT180GAMEFINISHREQUESTACTIVITYIDFIELD.type = 5
slot2.ACT180GAMEFINISHREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.ACT180GAMEFINISHREQUESTEPISODEIDFIELD.name = "episodeId"
slot2.ACT180GAMEFINISHREQUESTEPISODEIDFIELD.full_name = ".Act180GameFinishRequest.episodeId"
slot2.ACT180GAMEFINISHREQUESTEPISODEIDFIELD.number = 2
slot2.ACT180GAMEFINISHREQUESTEPISODEIDFIELD.index = 1
slot2.ACT180GAMEFINISHREQUESTEPISODEIDFIELD.label = 1
slot2.ACT180GAMEFINISHREQUESTEPISODEIDFIELD.has_default_value = false
slot2.ACT180GAMEFINISHREQUESTEPISODEIDFIELD.default_value = 0
slot2.ACT180GAMEFINISHREQUESTEPISODEIDFIELD.type = 5
slot2.ACT180GAMEFINISHREQUESTEPISODEIDFIELD.cpp_type = 1
slot2.ACT180GAMEFINISHREQUEST_MSG.name = "Act180GameFinishRequest"
slot2.ACT180GAMEFINISHREQUEST_MSG.full_name = ".Act180GameFinishRequest"
slot2.ACT180GAMEFINISHREQUEST_MSG.nested_types = {}
slot2.ACT180GAMEFINISHREQUEST_MSG.enum_types = {}
slot2.ACT180GAMEFINISHREQUEST_MSG.fields = {
	slot2.ACT180GAMEFINISHREQUESTACTIVITYIDFIELD,
	slot2.ACT180GAMEFINISHREQUESTEPISODEIDFIELD
}
slot2.ACT180GAMEFINISHREQUEST_MSG.is_extendable = false
slot2.ACT180GAMEFINISHREQUEST_MSG.extensions = {}
slot2.ACT180ENTEREPISODEREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.ACT180ENTEREPISODEREQUESTACTIVITYIDFIELD.full_name = ".Act180EnterEpisodeRequest.activityId"
slot2.ACT180ENTEREPISODEREQUESTACTIVITYIDFIELD.number = 1
slot2.ACT180ENTEREPISODEREQUESTACTIVITYIDFIELD.index = 0
slot2.ACT180ENTEREPISODEREQUESTACTIVITYIDFIELD.label = 1
slot2.ACT180ENTEREPISODEREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.ACT180ENTEREPISODEREQUESTACTIVITYIDFIELD.default_value = 0
slot2.ACT180ENTEREPISODEREQUESTACTIVITYIDFIELD.type = 5
slot2.ACT180ENTEREPISODEREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.ACT180ENTEREPISODEREQUESTEPISODEIDFIELD.name = "episodeId"
slot2.ACT180ENTEREPISODEREQUESTEPISODEIDFIELD.full_name = ".Act180EnterEpisodeRequest.episodeId"
slot2.ACT180ENTEREPISODEREQUESTEPISODEIDFIELD.number = 2
slot2.ACT180ENTEREPISODEREQUESTEPISODEIDFIELD.index = 1
slot2.ACT180ENTEREPISODEREQUESTEPISODEIDFIELD.label = 1
slot2.ACT180ENTEREPISODEREQUESTEPISODEIDFIELD.has_default_value = false
slot2.ACT180ENTEREPISODEREQUESTEPISODEIDFIELD.default_value = 0
slot2.ACT180ENTEREPISODEREQUESTEPISODEIDFIELD.type = 5
slot2.ACT180ENTEREPISODEREQUESTEPISODEIDFIELD.cpp_type = 1
slot2.ACT180ENTEREPISODEREQUEST_MSG.name = "Act180EnterEpisodeRequest"
slot2.ACT180ENTEREPISODEREQUEST_MSG.full_name = ".Act180EnterEpisodeRequest"
slot2.ACT180ENTEREPISODEREQUEST_MSG.nested_types = {}
slot2.ACT180ENTEREPISODEREQUEST_MSG.enum_types = {}
slot2.ACT180ENTEREPISODEREQUEST_MSG.fields = {
	slot2.ACT180ENTEREPISODEREQUESTACTIVITYIDFIELD,
	slot2.ACT180ENTEREPISODEREQUESTEPISODEIDFIELD
}
slot2.ACT180ENTEREPISODEREQUEST_MSG.is_extendable = false
slot2.ACT180ENTEREPISODEREQUEST_MSG.extensions = {}
slot2.GET180INFOSREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.GET180INFOSREQUESTACTIVITYIDFIELD.full_name = ".Get180InfosRequest.activityId"
slot2.GET180INFOSREQUESTACTIVITYIDFIELD.number = 1
slot2.GET180INFOSREQUESTACTIVITYIDFIELD.index = 0
slot2.GET180INFOSREQUESTACTIVITYIDFIELD.label = 1
slot2.GET180INFOSREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.GET180INFOSREQUESTACTIVITYIDFIELD.default_value = 0
slot2.GET180INFOSREQUESTACTIVITYIDFIELD.type = 5
slot2.GET180INFOSREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.GET180INFOSREQUEST_MSG.name = "Get180InfosRequest"
slot2.GET180INFOSREQUEST_MSG.full_name = ".Get180InfosRequest"
slot2.GET180INFOSREQUEST_MSG.nested_types = {}
slot2.GET180INFOSREQUEST_MSG.enum_types = {}
slot2.GET180INFOSREQUEST_MSG.fields = {
	slot2.GET180INFOSREQUESTACTIVITYIDFIELD
}
slot2.GET180INFOSREQUEST_MSG.is_extendable = false
slot2.GET180INFOSREQUEST_MSG.extensions = {}
slot2.ACT180ENTEREPISODEREPLYACTIVITYIDFIELD.name = "activityId"
slot2.ACT180ENTEREPISODEREPLYACTIVITYIDFIELD.full_name = ".Act180EnterEpisodeReply.activityId"
slot2.ACT180ENTEREPISODEREPLYACTIVITYIDFIELD.number = 1
slot2.ACT180ENTEREPISODEREPLYACTIVITYIDFIELD.index = 0
slot2.ACT180ENTEREPISODEREPLYACTIVITYIDFIELD.label = 1
slot2.ACT180ENTEREPISODEREPLYACTIVITYIDFIELD.has_default_value = false
slot2.ACT180ENTEREPISODEREPLYACTIVITYIDFIELD.default_value = 0
slot2.ACT180ENTEREPISODEREPLYACTIVITYIDFIELD.type = 5
slot2.ACT180ENTEREPISODEREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.ACT180ENTEREPISODEREPLYEPISODEFIELD.name = "episode"
slot2.ACT180ENTEREPISODEREPLYEPISODEFIELD.full_name = ".Act180EnterEpisodeReply.episode"
slot2.ACT180ENTEREPISODEREPLYEPISODEFIELD.number = 2
slot2.ACT180ENTEREPISODEREPLYEPISODEFIELD.index = 1
slot2.ACT180ENTEREPISODEREPLYEPISODEFIELD.label = 1
slot2.ACT180ENTEREPISODEREPLYEPISODEFIELD.has_default_value = false
slot2.ACT180ENTEREPISODEREPLYEPISODEFIELD.default_value = nil
slot2.ACT180ENTEREPISODEREPLYEPISODEFIELD.message_type = slot2.ACT180EPISODENO_MSG
slot2.ACT180ENTEREPISODEREPLYEPISODEFIELD.type = 11
slot2.ACT180ENTEREPISODEREPLYEPISODEFIELD.cpp_type = 10
slot2.ACT180ENTEREPISODEREPLY_MSG.name = "Act180EnterEpisodeReply"
slot2.ACT180ENTEREPISODEREPLY_MSG.full_name = ".Act180EnterEpisodeReply"
slot2.ACT180ENTEREPISODEREPLY_MSG.nested_types = {}
slot2.ACT180ENTEREPISODEREPLY_MSG.enum_types = {}
slot2.ACT180ENTEREPISODEREPLY_MSG.fields = {
	slot2.ACT180ENTEREPISODEREPLYACTIVITYIDFIELD,
	slot2.ACT180ENTEREPISODEREPLYEPISODEFIELD
}
slot2.ACT180ENTEREPISODEREPLY_MSG.is_extendable = false
slot2.ACT180ENTEREPISODEREPLY_MSG.extensions = {}
slot2.ACT180EPISODEPUSHACTIVITYIDFIELD.name = "activityId"
slot2.ACT180EPISODEPUSHACTIVITYIDFIELD.full_name = ".Act180EpisodePush.activityId"
slot2.ACT180EPISODEPUSHACTIVITYIDFIELD.number = 1
slot2.ACT180EPISODEPUSHACTIVITYIDFIELD.index = 0
slot2.ACT180EPISODEPUSHACTIVITYIDFIELD.label = 1
slot2.ACT180EPISODEPUSHACTIVITYIDFIELD.has_default_value = false
slot2.ACT180EPISODEPUSHACTIVITYIDFIELD.default_value = 0
slot2.ACT180EPISODEPUSHACTIVITYIDFIELD.type = 5
slot2.ACT180EPISODEPUSHACTIVITYIDFIELD.cpp_type = 1
slot2.ACT180EPISODEPUSHACT180EPISODESFIELD.name = "act180Episodes"
slot2.ACT180EPISODEPUSHACT180EPISODESFIELD.full_name = ".Act180EpisodePush.act180Episodes"
slot2.ACT180EPISODEPUSHACT180EPISODESFIELD.number = 2
slot2.ACT180EPISODEPUSHACT180EPISODESFIELD.index = 1
slot2.ACT180EPISODEPUSHACT180EPISODESFIELD.label = 3
slot2.ACT180EPISODEPUSHACT180EPISODESFIELD.has_default_value = false
slot2.ACT180EPISODEPUSHACT180EPISODESFIELD.default_value = {}
slot2.ACT180EPISODEPUSHACT180EPISODESFIELD.message_type = slot2.ACT180EPISODENO_MSG
slot2.ACT180EPISODEPUSHACT180EPISODESFIELD.type = 11
slot2.ACT180EPISODEPUSHACT180EPISODESFIELD.cpp_type = 10
slot2.ACT180EPISODEPUSH_MSG.name = "Act180EpisodePush"
slot2.ACT180EPISODEPUSH_MSG.full_name = ".Act180EpisodePush"
slot2.ACT180EPISODEPUSH_MSG.nested_types = {}
slot2.ACT180EPISODEPUSH_MSG.enum_types = {}
slot2.ACT180EPISODEPUSH_MSG.fields = {
	slot2.ACT180EPISODEPUSHACTIVITYIDFIELD,
	slot2.ACT180EPISODEPUSHACT180EPISODESFIELD
}
slot2.ACT180EPISODEPUSH_MSG.is_extendable = false
slot2.ACT180EPISODEPUSH_MSG.extensions = {}
slot2.ACT180STORYREPLYACTIVITYIDFIELD.name = "activityId"
slot2.ACT180STORYREPLYACTIVITYIDFIELD.full_name = ".Act180StoryReply.activityId"
slot2.ACT180STORYREPLYACTIVITYIDFIELD.number = 1
slot2.ACT180STORYREPLYACTIVITYIDFIELD.index = 0
slot2.ACT180STORYREPLYACTIVITYIDFIELD.label = 1
slot2.ACT180STORYREPLYACTIVITYIDFIELD.has_default_value = false
slot2.ACT180STORYREPLYACTIVITYIDFIELD.default_value = 0
slot2.ACT180STORYREPLYACTIVITYIDFIELD.type = 5
slot2.ACT180STORYREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.ACT180STORYREPLYEPISODEFIELD.name = "episode"
slot2.ACT180STORYREPLYEPISODEFIELD.full_name = ".Act180StoryReply.episode"
slot2.ACT180STORYREPLYEPISODEFIELD.number = 2
slot2.ACT180STORYREPLYEPISODEFIELD.index = 1
slot2.ACT180STORYREPLYEPISODEFIELD.label = 1
slot2.ACT180STORYREPLYEPISODEFIELD.has_default_value = false
slot2.ACT180STORYREPLYEPISODEFIELD.default_value = nil
slot2.ACT180STORYREPLYEPISODEFIELD.message_type = slot2.ACT180EPISODENO_MSG
slot2.ACT180STORYREPLYEPISODEFIELD.type = 11
slot2.ACT180STORYREPLYEPISODEFIELD.cpp_type = 10
slot2.ACT180STORYREPLY_MSG.name = "Act180StoryReply"
slot2.ACT180STORYREPLY_MSG.full_name = ".Act180StoryReply"
slot2.ACT180STORYREPLY_MSG.nested_types = {}
slot2.ACT180STORYREPLY_MSG.enum_types = {}
slot2.ACT180STORYREPLY_MSG.fields = {
	slot2.ACT180STORYREPLYACTIVITYIDFIELD,
	slot2.ACT180STORYREPLYEPISODEFIELD
}
slot2.ACT180STORYREPLY_MSG.is_extendable = false
slot2.ACT180STORYREPLY_MSG.extensions = {}
slot2.ACT180SAVEGAMEREPLYACTIVITYIDFIELD.name = "activityId"
slot2.ACT180SAVEGAMEREPLYACTIVITYIDFIELD.full_name = ".Act180SaveGameReply.activityId"
slot2.ACT180SAVEGAMEREPLYACTIVITYIDFIELD.number = 1
slot2.ACT180SAVEGAMEREPLYACTIVITYIDFIELD.index = 0
slot2.ACT180SAVEGAMEREPLYACTIVITYIDFIELD.label = 1
slot2.ACT180SAVEGAMEREPLYACTIVITYIDFIELD.has_default_value = false
slot2.ACT180SAVEGAMEREPLYACTIVITYIDFIELD.default_value = 0
slot2.ACT180SAVEGAMEREPLYACTIVITYIDFIELD.type = 5
slot2.ACT180SAVEGAMEREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.ACT180SAVEGAMEREPLYEPISODEIDFIELD.name = "episodeId"
slot2.ACT180SAVEGAMEREPLYEPISODEIDFIELD.full_name = ".Act180SaveGameReply.episodeId"
slot2.ACT180SAVEGAMEREPLYEPISODEIDFIELD.number = 2
slot2.ACT180SAVEGAMEREPLYEPISODEIDFIELD.index = 1
slot2.ACT180SAVEGAMEREPLYEPISODEIDFIELD.label = 1
slot2.ACT180SAVEGAMEREPLYEPISODEIDFIELD.has_default_value = false
slot2.ACT180SAVEGAMEREPLYEPISODEIDFIELD.default_value = 0
slot2.ACT180SAVEGAMEREPLYEPISODEIDFIELD.type = 5
slot2.ACT180SAVEGAMEREPLYEPISODEIDFIELD.cpp_type = 1
slot2.ACT180SAVEGAMEREPLYGAMEDATAFIELD.name = "gameData"
slot2.ACT180SAVEGAMEREPLYGAMEDATAFIELD.full_name = ".Act180SaveGameReply.gameData"
slot2.ACT180SAVEGAMEREPLYGAMEDATAFIELD.number = 3
slot2.ACT180SAVEGAMEREPLYGAMEDATAFIELD.index = 2
slot2.ACT180SAVEGAMEREPLYGAMEDATAFIELD.label = 1
slot2.ACT180SAVEGAMEREPLYGAMEDATAFIELD.has_default_value = false
slot2.ACT180SAVEGAMEREPLYGAMEDATAFIELD.default_value = ""
slot2.ACT180SAVEGAMEREPLYGAMEDATAFIELD.type = 9
slot2.ACT180SAVEGAMEREPLYGAMEDATAFIELD.cpp_type = 9
slot2.ACT180SAVEGAMEREPLY_MSG.name = "Act180SaveGameReply"
slot2.ACT180SAVEGAMEREPLY_MSG.full_name = ".Act180SaveGameReply"
slot2.ACT180SAVEGAMEREPLY_MSG.nested_types = {}
slot2.ACT180SAVEGAMEREPLY_MSG.enum_types = {}
slot2.ACT180SAVEGAMEREPLY_MSG.fields = {
	slot2.ACT180SAVEGAMEREPLYACTIVITYIDFIELD,
	slot2.ACT180SAVEGAMEREPLYEPISODEIDFIELD,
	slot2.ACT180SAVEGAMEREPLYGAMEDATAFIELD
}
slot2.ACT180SAVEGAMEREPLY_MSG.is_extendable = false
slot2.ACT180SAVEGAMEREPLY_MSG.extensions = {}
slot2.GET180INFOSREPLYACTIVITYIDFIELD.name = "activityId"
slot2.GET180INFOSREPLYACTIVITYIDFIELD.full_name = ".Get180InfosReply.activityId"
slot2.GET180INFOSREPLYACTIVITYIDFIELD.number = 1
slot2.GET180INFOSREPLYACTIVITYIDFIELD.index = 0
slot2.GET180INFOSREPLYACTIVITYIDFIELD.label = 1
slot2.GET180INFOSREPLYACTIVITYIDFIELD.has_default_value = false
slot2.GET180INFOSREPLYACTIVITYIDFIELD.default_value = 0
slot2.GET180INFOSREPLYACTIVITYIDFIELD.type = 5
slot2.GET180INFOSREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.GET180INFOSREPLYACT180EPISODENOFIELD.name = "act180EpisodeNO"
slot2.GET180INFOSREPLYACT180EPISODENOFIELD.full_name = ".Get180InfosReply.act180EpisodeNO"
slot2.GET180INFOSREPLYACT180EPISODENOFIELD.number = 2
slot2.GET180INFOSREPLYACT180EPISODENOFIELD.index = 1
slot2.GET180INFOSREPLYACT180EPISODENOFIELD.label = 3
slot2.GET180INFOSREPLYACT180EPISODENOFIELD.has_default_value = false
slot2.GET180INFOSREPLYACT180EPISODENOFIELD.default_value = {}
slot2.GET180INFOSREPLYACT180EPISODENOFIELD.message_type = slot2.ACT180EPISODENO_MSG
slot2.GET180INFOSREPLYACT180EPISODENOFIELD.type = 11
slot2.GET180INFOSREPLYACT180EPISODENOFIELD.cpp_type = 10
slot2.GET180INFOSREPLY_MSG.name = "Get180InfosReply"
slot2.GET180INFOSREPLY_MSG.full_name = ".Get180InfosReply"
slot2.GET180INFOSREPLY_MSG.nested_types = {}
slot2.GET180INFOSREPLY_MSG.enum_types = {}
slot2.GET180INFOSREPLY_MSG.fields = {
	slot2.GET180INFOSREPLYACTIVITYIDFIELD,
	slot2.GET180INFOSREPLYACT180EPISODENOFIELD
}
slot2.GET180INFOSREPLY_MSG.is_extendable = false
slot2.GET180INFOSREPLY_MSG.extensions = {}
slot2.ACT180SAVEGAMEREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.ACT180SAVEGAMEREQUESTACTIVITYIDFIELD.full_name = ".Act180SaveGameRequest.activityId"
slot2.ACT180SAVEGAMEREQUESTACTIVITYIDFIELD.number = 1
slot2.ACT180SAVEGAMEREQUESTACTIVITYIDFIELD.index = 0
slot2.ACT180SAVEGAMEREQUESTACTIVITYIDFIELD.label = 1
slot2.ACT180SAVEGAMEREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.ACT180SAVEGAMEREQUESTACTIVITYIDFIELD.default_value = 0
slot2.ACT180SAVEGAMEREQUESTACTIVITYIDFIELD.type = 5
slot2.ACT180SAVEGAMEREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.ACT180SAVEGAMEREQUESTEPISODEIDFIELD.name = "episodeId"
slot2.ACT180SAVEGAMEREQUESTEPISODEIDFIELD.full_name = ".Act180SaveGameRequest.episodeId"
slot2.ACT180SAVEGAMEREQUESTEPISODEIDFIELD.number = 2
slot2.ACT180SAVEGAMEREQUESTEPISODEIDFIELD.index = 1
slot2.ACT180SAVEGAMEREQUESTEPISODEIDFIELD.label = 1
slot2.ACT180SAVEGAMEREQUESTEPISODEIDFIELD.has_default_value = false
slot2.ACT180SAVEGAMEREQUESTEPISODEIDFIELD.default_value = 0
slot2.ACT180SAVEGAMEREQUESTEPISODEIDFIELD.type = 5
slot2.ACT180SAVEGAMEREQUESTEPISODEIDFIELD.cpp_type = 1
slot2.ACT180SAVEGAMEREQUESTGAMEDATAFIELD.name = "gameData"
slot2.ACT180SAVEGAMEREQUESTGAMEDATAFIELD.full_name = ".Act180SaveGameRequest.gameData"
slot2.ACT180SAVEGAMEREQUESTGAMEDATAFIELD.number = 3
slot2.ACT180SAVEGAMEREQUESTGAMEDATAFIELD.index = 2
slot2.ACT180SAVEGAMEREQUESTGAMEDATAFIELD.label = 1
slot2.ACT180SAVEGAMEREQUESTGAMEDATAFIELD.has_default_value = false
slot2.ACT180SAVEGAMEREQUESTGAMEDATAFIELD.default_value = ""
slot2.ACT180SAVEGAMEREQUESTGAMEDATAFIELD.type = 9
slot2.ACT180SAVEGAMEREQUESTGAMEDATAFIELD.cpp_type = 9
slot2.ACT180SAVEGAMEREQUEST_MSG.name = "Act180SaveGameRequest"
slot2.ACT180SAVEGAMEREQUEST_MSG.full_name = ".Act180SaveGameRequest"
slot2.ACT180SAVEGAMEREQUEST_MSG.nested_types = {}
slot2.ACT180SAVEGAMEREQUEST_MSG.enum_types = {}
slot2.ACT180SAVEGAMEREQUEST_MSG.fields = {
	slot2.ACT180SAVEGAMEREQUESTACTIVITYIDFIELD,
	slot2.ACT180SAVEGAMEREQUESTEPISODEIDFIELD,
	slot2.ACT180SAVEGAMEREQUESTGAMEDATAFIELD
}
slot2.ACT180SAVEGAMEREQUEST_MSG.is_extendable = false
slot2.ACT180SAVEGAMEREQUEST_MSG.extensions = {}
slot2.ACT180EPISODENOEPISODEIDFIELD.name = "episodeId"
slot2.ACT180EPISODENOEPISODEIDFIELD.full_name = ".Act180EpisodeNO.episodeId"
slot2.ACT180EPISODENOEPISODEIDFIELD.number = 1
slot2.ACT180EPISODENOEPISODEIDFIELD.index = 0
slot2.ACT180EPISODENOEPISODEIDFIELD.label = 1
slot2.ACT180EPISODENOEPISODEIDFIELD.has_default_value = false
slot2.ACT180EPISODENOEPISODEIDFIELD.default_value = 0
slot2.ACT180EPISODENOEPISODEIDFIELD.type = 5
slot2.ACT180EPISODENOEPISODEIDFIELD.cpp_type = 1
slot2.ACT180EPISODENOISFINISHEDFIELD.name = "isFinished"
slot2.ACT180EPISODENOISFINISHEDFIELD.full_name = ".Act180EpisodeNO.isFinished"
slot2.ACT180EPISODENOISFINISHEDFIELD.number = 2
slot2.ACT180EPISODENOISFINISHEDFIELD.index = 1
slot2.ACT180EPISODENOISFINISHEDFIELD.label = 1
slot2.ACT180EPISODENOISFINISHEDFIELD.has_default_value = false
slot2.ACT180EPISODENOISFINISHEDFIELD.default_value = false
slot2.ACT180EPISODENOISFINISHEDFIELD.type = 8
slot2.ACT180EPISODENOISFINISHEDFIELD.cpp_type = 7
slot2.ACT180EPISODENOSTATUSFIELD.name = "status"
slot2.ACT180EPISODENOSTATUSFIELD.full_name = ".Act180EpisodeNO.status"
slot2.ACT180EPISODENOSTATUSFIELD.number = 3
slot2.ACT180EPISODENOSTATUSFIELD.index = 2
slot2.ACT180EPISODENOSTATUSFIELD.label = 1
slot2.ACT180EPISODENOSTATUSFIELD.has_default_value = false
slot2.ACT180EPISODENOSTATUSFIELD.default_value = 0
slot2.ACT180EPISODENOSTATUSFIELD.type = 5
slot2.ACT180EPISODENOSTATUSFIELD.cpp_type = 1
slot2.ACT180EPISODENOGAMESTRINGFIELD.name = "gameString"
slot2.ACT180EPISODENOGAMESTRINGFIELD.full_name = ".Act180EpisodeNO.gameString"
slot2.ACT180EPISODENOGAMESTRINGFIELD.number = 4
slot2.ACT180EPISODENOGAMESTRINGFIELD.index = 3
slot2.ACT180EPISODENOGAMESTRINGFIELD.label = 1
slot2.ACT180EPISODENOGAMESTRINGFIELD.has_default_value = false
slot2.ACT180EPISODENOGAMESTRINGFIELD.default_value = ""
slot2.ACT180EPISODENOGAMESTRINGFIELD.type = 9
slot2.ACT180EPISODENOGAMESTRINGFIELD.cpp_type = 9
slot2.ACT180EPISODENO_MSG.name = "Act180EpisodeNO"
slot2.ACT180EPISODENO_MSG.full_name = ".Act180EpisodeNO"
slot2.ACT180EPISODENO_MSG.nested_types = {}
slot2.ACT180EPISODENO_MSG.enum_types = {}
slot2.ACT180EPISODENO_MSG.fields = {
	slot2.ACT180EPISODENOEPISODEIDFIELD,
	slot2.ACT180EPISODENOISFINISHEDFIELD,
	slot2.ACT180EPISODENOSTATUSFIELD,
	slot2.ACT180EPISODENOGAMESTRINGFIELD
}
slot2.ACT180EPISODENO_MSG.is_extendable = false
slot2.ACT180EPISODENO_MSG.extensions = {}
slot2.ACT180STORYREQUESTACTIVITYIDFIELD.name = "activityId"
slot2.ACT180STORYREQUESTACTIVITYIDFIELD.full_name = ".Act180StoryRequest.activityId"
slot2.ACT180STORYREQUESTACTIVITYIDFIELD.number = 1
slot2.ACT180STORYREQUESTACTIVITYIDFIELD.index = 0
slot2.ACT180STORYREQUESTACTIVITYIDFIELD.label = 1
slot2.ACT180STORYREQUESTACTIVITYIDFIELD.has_default_value = false
slot2.ACT180STORYREQUESTACTIVITYIDFIELD.default_value = 0
slot2.ACT180STORYREQUESTACTIVITYIDFIELD.type = 5
slot2.ACT180STORYREQUESTACTIVITYIDFIELD.cpp_type = 1
slot2.ACT180STORYREQUESTEPISODEIDFIELD.name = "episodeId"
slot2.ACT180STORYREQUESTEPISODEIDFIELD.full_name = ".Act180StoryRequest.episodeId"
slot2.ACT180STORYREQUESTEPISODEIDFIELD.number = 2
slot2.ACT180STORYREQUESTEPISODEIDFIELD.index = 1
slot2.ACT180STORYREQUESTEPISODEIDFIELD.label = 1
slot2.ACT180STORYREQUESTEPISODEIDFIELD.has_default_value = false
slot2.ACT180STORYREQUESTEPISODEIDFIELD.default_value = 0
slot2.ACT180STORYREQUESTEPISODEIDFIELD.type = 5
slot2.ACT180STORYREQUESTEPISODEIDFIELD.cpp_type = 1
slot2.ACT180STORYREQUEST_MSG.name = "Act180StoryRequest"
slot2.ACT180STORYREQUEST_MSG.full_name = ".Act180StoryRequest"
slot2.ACT180STORYREQUEST_MSG.nested_types = {}
slot2.ACT180STORYREQUEST_MSG.enum_types = {}
slot2.ACT180STORYREQUEST_MSG.fields = {
	slot2.ACT180STORYREQUESTACTIVITYIDFIELD,
	slot2.ACT180STORYREQUESTEPISODEIDFIELD
}
slot2.ACT180STORYREQUEST_MSG.is_extendable = false
slot2.ACT180STORYREQUEST_MSG.extensions = {}
slot2.ACT180GAMEFINISHREPLYACTIVITYIDFIELD.name = "activityId"
slot2.ACT180GAMEFINISHREPLYACTIVITYIDFIELD.full_name = ".Act180GameFinishReply.activityId"
slot2.ACT180GAMEFINISHREPLYACTIVITYIDFIELD.number = 1
slot2.ACT180GAMEFINISHREPLYACTIVITYIDFIELD.index = 0
slot2.ACT180GAMEFINISHREPLYACTIVITYIDFIELD.label = 1
slot2.ACT180GAMEFINISHREPLYACTIVITYIDFIELD.has_default_value = false
slot2.ACT180GAMEFINISHREPLYACTIVITYIDFIELD.default_value = 0
slot2.ACT180GAMEFINISHREPLYACTIVITYIDFIELD.type = 5
slot2.ACT180GAMEFINISHREPLYACTIVITYIDFIELD.cpp_type = 1
slot2.ACT180GAMEFINISHREPLYEPISODEFIELD.name = "episode"
slot2.ACT180GAMEFINISHREPLYEPISODEFIELD.full_name = ".Act180GameFinishReply.episode"
slot2.ACT180GAMEFINISHREPLYEPISODEFIELD.number = 2
slot2.ACT180GAMEFINISHREPLYEPISODEFIELD.index = 1
slot2.ACT180GAMEFINISHREPLYEPISODEFIELD.label = 1
slot2.ACT180GAMEFINISHREPLYEPISODEFIELD.has_default_value = false
slot2.ACT180GAMEFINISHREPLYEPISODEFIELD.default_value = nil
slot2.ACT180GAMEFINISHREPLYEPISODEFIELD.message_type = slot2.ACT180EPISODENO_MSG
slot2.ACT180GAMEFINISHREPLYEPISODEFIELD.type = 11
slot2.ACT180GAMEFINISHREPLYEPISODEFIELD.cpp_type = 10
slot2.ACT180GAMEFINISHREPLY_MSG.name = "Act180GameFinishReply"
slot2.ACT180GAMEFINISHREPLY_MSG.full_name = ".Act180GameFinishReply"
slot2.ACT180GAMEFINISHREPLY_MSG.nested_types = {}
slot2.ACT180GAMEFINISHREPLY_MSG.enum_types = {}
slot2.ACT180GAMEFINISHREPLY_MSG.fields = {
	slot2.ACT180GAMEFINISHREPLYACTIVITYIDFIELD,
	slot2.ACT180GAMEFINISHREPLYEPISODEFIELD
}
slot2.ACT180GAMEFINISHREPLY_MSG.is_extendable = false
slot2.ACT180GAMEFINISHREPLY_MSG.extensions = {}
slot2.Act180EnterEpisodeReply = slot1.Message(slot2.ACT180ENTEREPISODEREPLY_MSG)
slot2.Act180EnterEpisodeRequest = slot1.Message(slot2.ACT180ENTEREPISODEREQUEST_MSG)
slot2.Act180EpisodeNO = slot1.Message(slot2.ACT180EPISODENO_MSG)
slot2.Act180EpisodePush = slot1.Message(slot2.ACT180EPISODEPUSH_MSG)
slot2.Act180GameFinishReply = slot1.Message(slot2.ACT180GAMEFINISHREPLY_MSG)
slot2.Act180GameFinishRequest = slot1.Message(slot2.ACT180GAMEFINISHREQUEST_MSG)
slot2.Act180SaveGameReply = slot1.Message(slot2.ACT180SAVEGAMEREPLY_MSG)
slot2.Act180SaveGameRequest = slot1.Message(slot2.ACT180SAVEGAMEREQUEST_MSG)
slot2.Act180StoryReply = slot1.Message(slot2.ACT180STORYREPLY_MSG)
slot2.Act180StoryRequest = slot1.Message(slot2.ACT180STORYREQUEST_MSG)
slot2.Get180InfosReply = slot1.Message(slot2.GET180INFOSREPLY_MSG)
slot2.Get180InfosRequest = slot1.Message(slot2.GET180INFOSREQUEST_MSG)

return slot2
