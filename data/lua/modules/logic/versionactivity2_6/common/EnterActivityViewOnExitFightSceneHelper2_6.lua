module("modules.logic.versionactivity2_6.common.EnterActivityViewOnExitFightSceneHelper2_6", package.seeall)

slot0 = EnterActivityViewOnExitFightSceneHelper

function slot0.activate()
end

function slot0.enterActivity12210(slot0, slot1)
	uv0.enterVersionActivityDungeonCommon(uv0._enterActivityDungeonAterFight12210, slot0, slot1)
end

function slot0.enterActivity12606(slot0, slot1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_6EnterView)
		VersionActivity2_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , VersionActivity2_6Enum.ActivityId.DiceHero, true)
	end)
end

function slot0.enterActivity12605(slot0, slot1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_6EnterView)
		VersionActivity2_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , VersionActivity2_6Enum.ActivityId.Xugouji, true)
	end)
end

function slot0.enterActivity12617(slot0, slot1)
	slot3, slot4 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(DungeonModel.instance.curSendEpisodeId)
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(slot0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function ()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = uv0,
				layer = uv1
			})
		end, nil, BossRushConfig.instance:getActivityId())
	end)
end

function slot0.enterActivity12618(slot0, slot1)
	uv0.enterVersionActivityDungeonCommon(uv0._enterActivityDungeonAterFight12618, slot0, slot1)
end

function slot0._enterActivityDungeonAterFight12618(slot0, slot1)
	slot3 = slot1.exitFightGroup

	if not slot1.episodeId then
		return
	end

	if not Season166Model.instance:getBattleContext() then
		return false
	end

	slot5 = slot4.trainId
	slot7 = slot4.actId
	slot8 = uv0.recordMO and uv0.recordMO.fightResult
	slot11, slot12 = nil

	if slot9 then
		if not slot8 or slot8 == -1 or slot8 == 0 then
			if (DungeonConfig.instance:getEpisodeCO(slot2) and slot9.type) == DungeonEnum.EpisodeType.Season166Base then
				slot11 = Season166Enum.JumpId.BaseSpotEpisode
				slot12 = {
					baseId = slot4.baseId
				}
			elseif slot10 == DungeonEnum.EpisodeType.Season166Train then
				slot11 = Season166Enum.JumpId.TrainEpisode
				slot12 = {
					trainId = slot5
				}
			elseif slot10 == DungeonEnum.EpisodeType.Season166Teach then
				slot11 = Season166Enum.JumpId.TeachView
			end
		elseif slot8 == 1 then
			if slot10 == DungeonEnum.EpisodeType.Season166Base then
				slot11 = Season166Enum.JumpId.MainView
			elseif slot10 == DungeonEnum.EpisodeType.Season166Train then
				slot11 = Season166Enum.JumpId.TrainView
			elseif slot10 == DungeonEnum.EpisodeType.Season166Teach then
				slot11 = Season166Enum.JumpId.TeachView
			end
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", slot2))
	end

	VersionActivity2_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		Season166Controller.instance:openSeasonView({
			actId = uv0,
			jumpId = uv1,
			jumpParam = uv2
		})
	end, nil, VersionActivity2_6Enum.ActivityId.Season)
end

return slot0
