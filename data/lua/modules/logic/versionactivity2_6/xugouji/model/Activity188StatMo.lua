module("modules.logic.versionactivity2_6.xugouji.model.Activity188StatMo", package.seeall)

slot0 = pureTable("Activity188StatMo")

function slot0.ctor(slot0)
	slot0.beginTime = Time.realtimeSinceStartup
end

function slot0.reset(slot0)
	slot0.beginTime = Time.realtimeSinceStartup
	slot0.result = nil
	slot0.episdoeId = nil
	slot0._gameId = nil
	slot0._actId = nil
	slot0._enemyPair = nil
	slot0._playerPair = nil
	slot0._enemyHp = nil
	slot0._playerHp = nil
	slot0._roundNum = nil
end

function slot0.setBaseData(slot0, slot1, slot2, slot3)
	slot0._actId = slot1 and slot1 or slot0._actId
	slot0._gameId = slot3 and slot3 or slot0._gameId
	slot0.episdoeId = slot2 and slot2 or slot0.episdoeId
end

function slot0.setGameData(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.result = slot1 and slot1 or slot0.result
	slot0._roundNum = slot2 and slot2 or slot0._roundNum
	slot0._playerHp = slot3 and slot3 or slot0._playerHp
	slot0._enemyHp = slot4 and slot4 or slot0._enemyHp
	slot0._playerPair = slot5 and slot5 or slot0._playerPair
	slot0._enemyPair = slot6 and slot6 or slot0._enemyPair
end

function slot0.sendDungeonFinishStatData(slot0)
	StatController.instance:track(StatEnum.EventName.Act188DungeonFinish, {
		[StatEnum.EventProperties.ActivityId] = tostring(slot0._actId),
		[StatEnum.EventProperties.EpisodeId] = tostring(slot0.episdoeId),
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - slot0.beginTime
	})
end

function slot0.sendGameFinishStatData(slot0)
	StatController.instance:track(StatEnum.EventName.Act188MapFinish, {
		[StatEnum.EventProperties.ActivityId] = tostring(slot0._actId),
		[StatEnum.EventProperties.MapId] = tostring(slot0._gameId),
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - slot0.beginTime,
		[StatEnum.EventProperties.Result] = slot0.result == 1 and "success" or "fail",
		[StatEnum.EventProperties.Act188GameObj] = {
			[StatEnum.EventProperties.RoundNum] = slot0._roundNum,
			[StatEnum.EventProperties.Act188GamePlayerHp] = slot0._playerHp,
			[StatEnum.EventProperties.Act188GameEnemyHp] = slot0._enemyHp,
			[StatEnum.EventProperties.Act188GamePlayerPair] = slot0._playerPair,
			[StatEnum.EventProperties.Act188GameEnemyPair] = slot0._enemyPair
		}
	})
end

function slot0.sendGameGiveUpStatData(slot0)
	StatController.instance:track(StatEnum.EventName.Act188MapGiveUp, {
		[StatEnum.EventProperties.ActivityId] = tostring(slot0._actId),
		[StatEnum.EventProperties.MapId] = tostring(slot0._gameId),
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - slot0.beginTime,
		[StatEnum.EventProperties.Act188GameObj] = {
			[StatEnum.EventProperties.RoundNum] = slot0._roundNum,
			[StatEnum.EventProperties.Act188GamePlayerHp] = slot0._playerHp,
			[StatEnum.EventProperties.Act188GameEnemyHp] = slot0._enemyHp,
			[StatEnum.EventProperties.Act188GamePlayerPair] = slot0._playerPair,
			[StatEnum.EventProperties.Act188GameEnemyPair] = slot0._enemyPair
		}
	})
end

return slot0
