module("modules.logic.sp01.enter.controller.EnterActivityViewOnExitFightSceneHelper2_9", package.seeall)

local var_0_0 = EnterActivityViewOnExitFightSceneHelper

function var_0_0.activate()
	return
end

local function var_0_1(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.episodeId
	local var_2_1 = arg_2_1.episodeCo

	if not var_2_1 then
		return
	end

	if var_0_0.sequence then
		var_0_0.sequence:destroy()

		var_0_0.sequence = nil
	end

	local var_2_2 = false

	if var_2_1.chapterId == VersionActivity2_3DungeonEnum.DungeonChapterId.ElementFight then
		DungeonMapModel.instance.lastElementBattleId = var_2_0
		var_2_0 = VersionActivity2_3DungeonModel.instance:getLastEpisodeId()

		if var_2_0 then
			VersionActivity2_3DungeonModel.instance:setLastEpisodeId(nil)
		else
			var_2_0 = DungeonConfig.instance:getActivityElementFightEpisodeToNormalEpisodeId(var_2_1, VersionActivity2_3DungeonEnum.DungeonChapterId.Story)
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_3DungeonMapView)
	elseif DungeonModel.instance.curSendEpisodePass then
		var_2_2 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_3DungeonMapView)
	else
		var_2_2 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity2_3DungeonMapLevelView)
	end

	local var_2_3 = FlowSequence.New()

	var_2_3:addWork(OpenViewWork.New({
		openFunction = function()
			ViewMgr.instance:openView(ViewName.V2a3_ReactivityEnterview)
		end
	}))
	var_2_3:registerDoneListener(function()
		if var_2_2 then
			VersionActivity2_3DungeonController.instance:openVersionActivityDungeonMapView(nil, var_2_0, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_3DungeonMapLevelView, {
					episodeId = var_2_0
				})
			end, nil)
		else
			VersionActivity2_3DungeonController.instance:openVersionActivityDungeonMapView(nil, var_2_0)
		end
	end)
	var_2_3:start()

	var_0_0.sequence = var_2_3
end

function var_0_0.enterActivity130502(arg_6_0, arg_6_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivity130502, arg_6_0, arg_6_1)
end

function var_0_0._enterActivity130502(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.episodeId

	if not arg_7_1.episodeCo then
		return
	end

	if var_0_0.sequence then
		var_0_0.sequence:destroy()

		var_0_0.sequence = nil
	end

	local var_7_1 = false
	local var_7_2 = ViewName.VersionActivity2_9DungeonMapLevelView
	local var_7_3 = ViewName.VersionActivity2_9DungeonMapView
	local var_7_4 = ViewName.VersionActivity2_9EnterView

	if DungeonModel.instance.curSendEpisodePass then
		var_7_1 = false

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_7_3)
	else
		var_7_1 = true

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_7_2)
	end

	local var_7_5 = FlowSequence.New()

	var_7_5:addWork(OpenViewWork.New({
		openFunction = VersionActivity2_9EnterController.directOpenVersionActivityEnterView,
		openFunctionObj = VersionActivity2_9EnterController.instance,
		waitOpenViewName = var_7_4
	}))
	var_7_5:registerDoneListener(function()
		if var_7_1 then
			VersionActivity2_9DungeonController.instance:openVersionActivityDungeonMapView(nil, var_7_0, function()
				ViewMgr.instance:openView(var_7_2, {
					episodeId = var_7_0
				})
			end, nil)
		else
			VersionActivity2_9DungeonController.instance:openVersionActivityDungeonMapView(nil, var_7_0)
		end
	end)
	var_7_5:start()

	var_0_0.sequence = var_7_5
end

function var_0_0.enterActivity12302(arg_10_0, arg_10_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_1, arg_10_0, arg_10_1)
end

function var_0_0.enterActivity130504(arg_11_0, arg_11_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0._enterActivity130504, arg_11_0, arg_11_1)
end

function var_0_0._enterActivity130504(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.episodeCo.type == DungeonEnum.EpisodeType.Assassin2Stealth

	if var_0_0.sequence then
		var_0_0.sequence:destroy()

		var_0_0.sequence = nil
	end

	local var_12_1 = AssassinOutsideModel.instance:isAct195Open(true)
	local var_12_2 = {}

	if var_12_1 then
		local var_12_3 = ViewName.AssassinMapView

		if var_12_0 then
			var_12_2.fightReturnStealthGame = true
			var_12_3 = ViewName.AssassinStealthGameView
		else
			local var_12_4 = AssassinOutsideModel.instance:getEnterFightQuest()
			local var_12_5 = AssassinConfig.instance:getQuestMapId(var_12_4)

			if var_12_5 then
				var_12_3 = ViewName.AssassinQuestMapView
			end

			var_12_2.questMapId = var_12_5
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_12_3)
	end

	local var_12_6 = ViewName.VersionActivity2_9EnterView
	local var_12_7 = FlowSequence.New()

	var_12_7:addWork(OpenViewWork.New({
		openFunction = VersionActivity2_9EnterController.directOpenVersionActivityEnterView,
		openFunctionObj = VersionActivity2_9EnterController.instance,
		waitOpenViewName = var_12_6
	}))
	var_12_7:registerDoneListener(function()
		AssassinController.instance:openAssassinMapView(var_12_2)
	end)
	var_12_7:start()

	var_0_0.sequence = var_12_7
end

function var_0_0.enterActivity130505(arg_14_0, arg_14_1)
	local var_14_0 = DungeonModel.instance.curSendEpisodeId
	local var_14_1, var_14_2 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(var_14_0)

	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_14_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.V1a4_BossRushMainView)
		VersionActivity2_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			BossRushController.instance:openMainView({
				isOpenLevelDetail = true,
				stage = var_14_1,
				layer = var_14_2
			})
		end, nil, BossRushConfig.instance:getActivityId(), true, true)
	end)
end

function var_0_0.enterActivity130507(arg_17_0, arg_17_1)
	var_0_0.enterVersionActivityDungeonCommon(var_0_0.enterActivityDungeonAterFight130507, arg_17_0, arg_17_1)
end

function var_0_0.enterActivityDungeonAterFight130507(arg_18_0, arg_18_1)
	if var_0_0.sequence then
		var_0_0.sequence:destroy()

		var_0_0.sequence = nil
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.OdysseyDungeonView)

	local var_18_0 = ViewName.VersionActivity2_9EnterView
	local var_18_1 = FlowSequence.New()

	var_18_1:addWork(OpenViewWork.New({
		openFunction = VersionActivity2_9EnterController.directOpenVersionActivityEnterView,
		openFunctionObj = VersionActivity2_9EnterController.instance,
		waitOpenViewName = var_18_0
	}))
	var_18_1:registerDoneListener(function()
		OdysseyDungeonController.instance:openDungeonView()
	end)
	var_18_1:start()

	var_0_0.sequence = var_18_1
end

return var_0_0
