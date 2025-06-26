module("modules.logic.versionactivity3_0.common.EnterActivityViewOnExitFightSceneHelper3_0", package.seeall)

local var_0_0 = EnterActivityViewOnExitFightSceneHelper

function var_0_0.activate()
	return
end

function var_0_0.enterActivity13000(arg_2_0, arg_2_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivityDungeonAterFight13000, arg_2_0, arg_2_1)
end

function var_0_0.checkFightAfterStory13000(arg_3_0, arg_3_1, arg_3_2)
	if (var_0_0.recordMO and var_0_0.recordMO.fightResult) ~= 1 then
		return
	end

	local var_3_0 = DungeonModel.instance.curSendEpisodeId

	if not var_3_0 then
		return
	end

	local var_3_1 = DungeonConfig.instance:getEpisodeCO(var_3_0)

	if not var_3_1 or var_3_1.type ~= DungeonEnum.EpisodeType.Season then
		return
	end

	local var_3_2 = Activity104Model.instance:getBattleFinishLayer()
	local var_3_3 = Activity104Model.instance:getCurSeasonId()

	if Activity104Model.instance:isEpisodeAfterStory(var_3_3, var_3_2) then
		return
	end

	local var_3_4 = SeasonConfig.instance:getSeasonEpisodeCo(var_3_3, var_3_2)

	if not var_3_4 or var_3_4.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(var_3_4.afterStoryId, nil, arg_3_0, arg_3_1, arg_3_2)

	return true
end

function var_0_0._enterActivityDungeonAterFight13000(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.episodeId
	local var_4_1 = arg_4_1.exitFightGroup

	if not var_4_0 then
		return
	end

	local var_4_2 = Activity104Model.instance:getBattleFinishLayer()
	local var_4_3 = Activity104Model.instance:getCurSeasonId()
	local var_4_4 = var_0_0.recordMO and var_0_0.recordMO.fightResult
	local var_4_5 = DungeonConfig.instance:getEpisodeCO(var_4_0)
	local var_4_6 = var_4_5 and var_4_5.type
	local var_4_7 = Activity104Model.instance:canPlayStageLevelup(var_4_4, var_4_6, var_4_1, var_4_3, var_4_2)
	local var_4_8
	local var_4_9
	local var_4_10 = Activity104Model.instance:canMarkFightAfterStory(var_4_4, var_4_6, var_4_1, var_4_3, var_4_2)

	if var_4_10 then
		Activity104Rpc.instance:sendMarkEpisodeAfterStoryRequest(var_4_3, var_4_2)
	end

	if var_4_5 then
		if not var_4_4 or var_4_4 == -1 or var_4_4 == 0 then
			if var_4_6 == DungeonEnum.EpisodeType.Season then
				var_4_8 = Activity104Enum.JumpId.Market
				var_4_9 = {
					tarLayer = var_4_2
				}
			elseif var_4_6 == DungeonEnum.EpisodeType.SeasonRetail then
				var_4_8 = Activity104Enum.JumpId.Retail
			elseif var_4_6 == DungeonEnum.EpisodeType.SeasonSpecial then
				var_4_8 = Activity104Enum.JumpId.Discount
				var_4_9 = {
					defaultSelectLayer = var_4_2,
					directOpenLayer = var_4_2
				}
			end
		elseif var_4_4 == 1 then
			if not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU) or not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount) then
				if var_4_6 == DungeonEnum.EpisodeType.Season then
					if not var_4_7 then
						local var_4_11 = var_4_2 + 1

						if SeasonConfig.instance:getSeasonEpisodeCo(var_4_3, var_4_11) then
							var_4_8 = Activity104Enum.JumpId.Market
							var_4_9 = {
								tarLayer = var_4_11
							}
						end
					end
				elseif var_4_6 == DungeonEnum.EpisodeType.SeasonRetail then
					var_4_8 = Activity104Enum.JumpId.Retail
				elseif var_4_6 == DungeonEnum.EpisodeType.SeasonSpecial then
					var_4_8 = Activity104Enum.JumpId.Discount
				end
			end

			if var_4_10 and var_4_2 == 1 then
				var_4_8 = nil
				var_4_9 = nil
			end
		elseif var_4_6 == DungeonEnum.EpisodeType.SeasonSpecial then
			var_4_8 = Activity104Enum.JumpId.Discount
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", var_4_0))
	end

	local var_4_12 = Activity104Enum.ViewName.MainView
	local var_4_13 = SeasonViewHelper.getViewName(var_4_3, var_4_12, true)

	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_4_13)

	local function var_4_14()
		Activity104Controller.instance:openSeasonMainView({
			levelUpStage = var_4_7,
			jumpId = var_4_8,
			jumpParam = var_4_9
		})
	end

	VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(var_4_14, nil, var_4_3, true)
end

function var_0_0.enterFightAgain13000()
	local var_6_0 = DungeonModel.instance.curSendEpisodeId
	local var_6_1 = DungeonConfig.instance:getEpisodeCO(var_6_0)
	local var_6_2 = Activity104Model.instance:getCurSeasonId()
	local var_6_3 = Activity104Model.instance:getBattleFinishLayer()

	if var_6_1.type == DungeonEnum.EpisodeType.SeasonRetail then
		var_6_3 = 0

		return false
	end

	if FightController.instance:isReplayMode(var_6_0) and not var_6_3 then
		if var_6_1.type == DungeonEnum.EpisodeType.Season then
			local var_6_4 = SeasonConfig.instance:getSeasonEpisodeCos(var_6_2)

			for iter_6_0, iter_6_1 in pairs(var_6_4) do
				if iter_6_1.episodeId == var_6_0 then
					var_6_3 = iter_6_1.layer

					break
				end
			end
		elseif var_6_1.type == DungeonEnum.EpisodeType.SeasonRetail then
			var_6_3 = 0
		elseif var_6_1.type == DungeonEnum.EpisodeType.SeasonSpecial then
			local var_6_5 = SeasonConfig.instance:getSeasonSpecialCos(var_6_2)

			for iter_6_2, iter_6_3 in pairs(var_6_5) do
				if iter_6_3.episodeId == var_6_0 then
					var_6_3 = iter_6_3.layer

					break
				end
			end
		end

		Activity104Model.instance:setBattleFinishLayer(var_6_3)
	end

	GameSceneMgr.instance:closeScene(nil, nil, nil, true)
	Activity104Model.instance:enterAct104Battle(var_6_0, var_6_3)

	return true
end

function var_0_0._enterActivityDungeonAterFight12618(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.episodeId
	local var_7_1 = arg_7_1.exitFightGroup

	if not var_7_0 then
		return
	end

	local var_7_2 = Season166Model.instance:getBattleContext()

	if not var_7_2 then
		return false
	end

	local var_7_3 = var_7_2.trainId
	local var_7_4 = var_7_2.baseId
	local var_7_5 = var_7_2.actId
	local var_7_6 = var_0_0.recordMO and var_0_0.recordMO.fightResult
	local var_7_7 = DungeonConfig.instance:getEpisodeCO(var_7_0)
	local var_7_8 = var_7_7 and var_7_7.type
	local var_7_9
	local var_7_10

	if var_7_7 then
		if not var_7_6 or var_7_6 == -1 or var_7_6 == 0 then
			if var_7_8 == DungeonEnum.EpisodeType.Season166Base then
				var_7_9 = Season166Enum.JumpId.BaseSpotEpisode
				var_7_10 = {
					baseId = var_7_4
				}
			elseif var_7_8 == DungeonEnum.EpisodeType.Season166Train then
				var_7_9 = Season166Enum.JumpId.TrainEpisode
				var_7_10 = {
					trainId = var_7_3
				}
			elseif var_7_8 == DungeonEnum.EpisodeType.Season166Teach then
				var_7_9 = Season166Enum.JumpId.TeachView
			end
		elseif var_7_6 == 1 then
			if var_7_8 == DungeonEnum.EpisodeType.Season166Base then
				var_7_9 = Season166Enum.JumpId.MainView
			elseif var_7_8 == DungeonEnum.EpisodeType.Season166Train then
				var_7_9 = Season166Enum.JumpId.TrainView
			elseif var_7_8 == DungeonEnum.EpisodeType.Season166Teach then
				var_7_9 = Season166Enum.JumpId.TeachView
			end
		end
	else
		logError(string.format("找不到对应关卡表,id:%s", var_7_0))
	end

	VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Season166Controller.instance:openSeasonView({
			actId = var_7_5,
			jumpId = var_7_9,
			jumpParam = var_7_10
		})
	end, nil, VersionActivity3_0Enum.ActivityId.Season)
end

function var_0_0.enterActivity13016(arg_9_0, arg_9_1)
	local var_9_0 = DungeonModel.instance.curSendEpisodeId
	local var_9_1, var_9_2 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(var_9_0)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_9_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = var_9_1,
				layer = var_9_2
			})
		end, nil, BossRushConfig.instance:getActivityId(), true)
	end)
end

function var_0_0.enterActivity13015(arg_12_0, arg_12_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(arg_12_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity3_0EnterView)

		local var_13_0 = ActivityConfig.instance:getActivityCo(VersionActivity3_0Enum.ActivityId.KaRong)

		if DungeonModel.instance.lastSendEpisodeId == var_13_0.tryoutEpisode then
			VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity3_0Enum.ActivityId.KaRong, true)
		else
			local function var_13_1()
				RoleActivityController.instance:enterActivity(VersionActivity3_0Enum.ActivityId.KaRong)
			end

			VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(var_13_1, nil, VersionActivity3_0Enum.ActivityId.KaRong, true)
		end
	end)
end

function var_0_0.enterActivity13011(arg_15_0, arg_15_1)
	DungeonModel.instance.lastSendEpisodeId = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(arg_15_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity3_0EnterView)

		local var_16_0 = ActivityConfig.instance:getActivityCo(VersionActivity3_0Enum.ActivityId.MaLiAnNa)

		if DungeonModel.instance.lastSendEpisodeId == var_16_0.tryoutEpisode then
			VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity3_0Enum.ActivityId.MaLiAnNa, true)
		else
			local function var_16_1()
				RoleActivityController.instance:enterActivity(VersionActivity3_0Enum.ActivityId.MaLiAnNa)
			end

			VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(var_16_1, nil, VersionActivity3_0Enum.ActivityId.MaLiAnNa, true)
		end
	end)
end

return var_0_0
