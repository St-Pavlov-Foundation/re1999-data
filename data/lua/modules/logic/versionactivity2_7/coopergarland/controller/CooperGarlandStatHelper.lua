module("modules.logic.versionactivity2_7.coopergarland.controller.CooperGarlandStatHelper", package.seeall)

slot0 = class("CooperGarlandStatHelper")

function slot0.ctor(slot0)
	slot0.episodeId = "0"
	slot0.failCount = 0
	slot0.resetCount = 0
	slot0.mapResetCount = 0
	slot0.episodeStartTime = 0
	slot0.gameStartTime = 0
	slot0.mapStartTime = 0
	slot0.resetStartTime = 0
end

function slot0.enterEpisode(slot0, slot1)
	slot0.episodeId = tostring(slot1)
	slot0.episodeStartTime = UnityEngine.Time.realtimeSinceStartup
end

function slot0.enterGame(slot0)
	slot0.failCount = 0
	slot0.resetCount = 0
	slot0.gameStartTime = UnityEngine.Time.realtimeSinceStartup
end

function slot0.setupMap(slot0)
	slot0.mapResetCount = 0
	slot0.mapStartTime = UnityEngine.Time.realtimeSinceStartup
	slot0.resetStartTime = UnityEngine.Time.realtimeSinceStartup
end

function slot0.sendEpisodeFinish(slot0)
	StatController.instance:track(StatEnum.EventName.Act192DungeonFinish, {
		[StatEnum.EventProperties.CooperGarland_ActId] = tostring(CooperGarlandModel.instance:getAct192Id()),
		[StatEnum.EventProperties.CooperGarland_EpisodeId] = slot0.episodeId,
		[StatEnum.EventProperties.CooperGarland_UseTime] = UnityEngine.Time.realtimeSinceStartup - slot0.episodeStartTime
	})
end

function slot0.sendGameFinish(slot0)
	StatController.instance:track(StatEnum.EventName.Act192GameFinish, {
		[StatEnum.EventProperties.CooperGarland_ActId] = tostring(CooperGarlandModel.instance:getAct192Id()),
		[StatEnum.EventProperties.CooperGarland_EpisodeId] = slot0.episodeId,
		[StatEnum.EventProperties.CooperGarland_GameId] = CooperGarlandGameModel.instance:getGameId(),
		[StatEnum.EventProperties.CooperGarland_IsJoystick] = CooperGarlandGameModel.instance:getIsJoystick(),
		[StatEnum.EventProperties.CooperGarland_UseTime] = UnityEngine.Time.realtimeSinceStartup - slot0.gameStartTime,
		[StatEnum.EventProperties.CooperGarland_FailTimes] = slot0.failCount,
		[StatEnum.EventProperties.CooperGarland_ResetTimes] = slot0.resetCount
	})
end

function slot0.sendGameExit(slot0, slot1)
	StatController.instance:track(StatEnum.EventName.Act192GameExit, {
		[StatEnum.EventProperties.CooperGarland_ActId] = tostring(CooperGarlandModel.instance:getAct192Id()),
		[StatEnum.EventProperties.CooperGarland_EpisodeId] = slot0.episodeId,
		[StatEnum.EventProperties.CooperGarland_GameId] = CooperGarlandGameModel.instance:getGameId(),
		[StatEnum.EventProperties.CooperGarland_IsJoystick] = CooperGarlandGameModel.instance:getIsJoystick(),
		[StatEnum.EventProperties.CooperGarland_BrowseTime] = UnityEngine.Time.realtimeSinceStartup - slot0.episodeStartTime,
		[StatEnum.EventProperties.CooperGarland_UseTime] = UnityEngine.Time.realtimeSinceStartup - slot0.gameStartTime,
		[StatEnum.EventProperties.CooperGarland_FailTimes] = slot0.failCount,
		[StatEnum.EventProperties.CooperGarland_ResetTimes] = slot0.resetCount,
		[StatEnum.EventProperties.CooperGarland_MapUseTime] = UnityEngine.Time.realtimeSinceStartup - slot0.mapStartTime,
		[StatEnum.EventProperties.CooperGarland_MapId] = CooperGarlandGameModel.instance:getMapId(),
		[StatEnum.EventProperties.CooperGarland_From] = slot1
	})
end

function slot0.sendMapArrive(slot0)
	StatController.instance:track(StatEnum.EventName.Act192MapArrive, {
		[StatEnum.EventProperties.CooperGarland_ActId] = tostring(CooperGarlandModel.instance:getAct192Id()),
		[StatEnum.EventProperties.CooperGarland_EpisodeId] = slot0.episodeId,
		[StatEnum.EventProperties.CooperGarland_GameId] = CooperGarlandGameModel.instance:getGameId(),
		[StatEnum.EventProperties.CooperGarland_IsJoystick] = CooperGarlandGameModel.instance:getIsJoystick(),
		[StatEnum.EventProperties.CooperGarland_MapId] = CooperGarlandGameModel.instance:getMapId(),
		[StatEnum.EventProperties.CooperGarland_MapUseTime] = UnityEngine.Time.realtimeSinceStartup - slot0.mapStartTime,
		[StatEnum.EventProperties.CooperGarland_RemoveComp] = CooperGarlandGameEntityMgr.instance:getRemoveCompList(),
		[StatEnum.EventProperties.CooperGarland_MapResetTimes] = slot0.mapResetCount
	})
end

function slot0.sendMapFail(slot0, slot1)
	slot0.failCount = slot0.failCount + 1

	StatController.instance:track(StatEnum.EventName.Act192MapFail, {
		[StatEnum.EventProperties.CooperGarland_ActId] = tostring(CooperGarlandModel.instance:getAct192Id()),
		[StatEnum.EventProperties.CooperGarland_EpisodeId] = slot0.episodeId,
		[StatEnum.EventProperties.CooperGarland_GameId] = CooperGarlandGameModel.instance:getGameId(),
		[StatEnum.EventProperties.CooperGarland_IsJoystick] = CooperGarlandGameModel.instance:getIsJoystick(),
		[StatEnum.EventProperties.CooperGarland_CompId] = slot1,
		[StatEnum.EventProperties.CooperGarland_MapId] = CooperGarlandGameModel.instance:getMapId(),
		[StatEnum.EventProperties.CooperGarland_UseTime] = UnityEngine.Time.realtimeSinceStartup - slot0.gameStartTime,
		[StatEnum.EventProperties.CooperGarland_MapUseTime] = UnityEngine.Time.realtimeSinceStartup - slot0.mapStartTime,
		[StatEnum.EventProperties.CooperGarland_ResetUseTime] = UnityEngine.Time.realtimeSinceStartup - slot0.resetStartTime,
		[StatEnum.EventProperties.CooperGarland_RemoveComp] = CooperGarlandGameEntityMgr.instance:getRemoveCompList()
	})
end

function slot0.sendMapReset(slot0, slot1)
	slot0.resetCount = slot0.resetCount + 1
	slot0.mapResetCount = slot0.mapResetCount + 1

	StatController.instance:track(StatEnum.EventName.Act192MapReset, {
		[StatEnum.EventProperties.CooperGarland_ActId] = tostring(CooperGarlandModel.instance:getAct192Id()),
		[StatEnum.EventProperties.CooperGarland_EpisodeId] = slot0.episodeId,
		[StatEnum.EventProperties.CooperGarland_GameId] = CooperGarlandGameModel.instance:getGameId(),
		[StatEnum.EventProperties.CooperGarland_IsJoystick] = CooperGarlandGameModel.instance:getIsJoystick(),
		[StatEnum.EventProperties.CooperGarland_MapId] = CooperGarlandGameModel.instance:getMapId(),
		[StatEnum.EventProperties.CooperGarland_UseTime] = UnityEngine.Time.realtimeSinceStartup - slot0.gameStartTime,
		[StatEnum.EventProperties.CooperGarland_MapUseTime] = UnityEngine.Time.realtimeSinceStartup - slot0.mapStartTime,
		[StatEnum.EventProperties.CooperGarland_ResetUseTime] = UnityEngine.Time.realtimeSinceStartup - slot0.resetStartTime,
		[StatEnum.EventProperties.CooperGarland_RemoveComp] = CooperGarlandGameEntityMgr.instance:getRemoveCompList(),
		[StatEnum.EventProperties.CooperGarland_From] = slot1
	})

	slot0.resetStartTime = UnityEngine.Time.realtimeSinceStartup
end

slot0.instance = slot0.New()

return slot0
