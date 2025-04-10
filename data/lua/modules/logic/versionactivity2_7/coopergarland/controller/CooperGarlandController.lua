module("modules.logic.versionactivity2_7.coopergarland.controller.CooperGarlandController", package.seeall)

slot0 = class("CooperGarlandController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.getAct192Info(slot0, slot1, slot2, slot3)
	if not CooperGarlandModel.instance:isAct192Open(slot3) then
		return
	end

	Activity192Rpc.instance:sendGetAct192InfoRequest(CooperGarlandModel.instance:getAct192Id(), slot1, slot2)
end

function slot0.onGetAct192Info(slot0, slot1)
	CooperGarlandModel.instance:updateAct192Info(slot1)
	slot0:dispatchEvent(CooperGarlandEvent.OnAct192InfoUpdate)
end

function slot0.saveGameProgress(slot0, slot1, slot2, slot3)
	if not CooperGarlandModel.instance:isAct192Open(slot3) then
		return
	end

	if not CooperGarlandModel.instance:isUnlockEpisode(CooperGarlandModel.instance:getAct192Id(), slot1) then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		return
	end

	Activity192Rpc.instance:sendAct192FinishEpisodeRequest(slot5, slot1, tostring(slot2), slot0._onSaveGameProgress, slot0)
end

function slot0._onSaveGameProgress(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	slot4 = slot3.activityId
	slot5 = slot3.episodeId

	CooperGarlandModel.instance:updateAct192Episode(slot4, slot5, CooperGarlandModel.instance:isFinishedEpisode(slot4, slot5), slot3.progress)
end

function slot0.finishEpisode(slot0, slot1, slot2)
	if not CooperGarlandModel.instance:isAct192Open(slot2) then
		return
	end

	if not CooperGarlandModel.instance:isUnlockEpisode(CooperGarlandModel.instance:getAct192Id(), slot1) then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		return
	end

	if CooperGarlandModel.instance:isFinishedEpisode(slot4, slot1) then
		slot0:_playStoryClear(slot1)

		if CooperGarlandConfig.instance:isExtraEpisode(slot4, slot1) then
			slot0:saveGameProgress(slot1, CooperGarlandEnum.Const.DefaultGameProgress, true)
		end
	else
		Activity192Rpc.instance:sendAct192FinishEpisodeRequest(slot4, slot1, nil, slot0.onFinishEpisode, slot0)
	end
end

function slot0.onFinishEpisode(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	slot4 = slot3.activityId

	CooperGarlandModel.instance:updateAct192Episode(slot4, slot3.episodeId, true, slot3.progress)

	if slot4 == CooperGarlandModel.instance:getAct192Id() then
		slot0:_playStoryClear(slot5)
	end

	slot0:dispatchEvent(CooperGarlandEvent.FirstFinishEpisode, slot4, slot5)
end

function slot0._playStoryClear(slot0, slot1)
	if not CooperGarlandModel.instance:isFinishedEpisode(CooperGarlandModel.instance:getAct192Id(), slot1) then
		return
	end

	if CooperGarlandConfig.instance:getStoryClear(slot2, slot1) and slot4 ~= 0 then
		StoryController.instance:playStory(slot4, nil, slot0.openResultView, slot0, {
			isWin = true,
			episodeId = slot1
		})
	else
		slot0:openResultView({
			isWin = true,
			episodeId = slot1
		})
	end
end

function slot0.clickEpisode(slot0, slot1, slot2)
	if not CooperGarlandModel.instance:isAct192Open(true) then
		return
	end

	if not CooperGarlandModel.instance:isUnlockEpisode(slot1, slot2) then
		GameFacade.showToast(ToastEnum.Activity142PreEpisodeNotClear)

		return
	end

	slot0:dispatchEvent(CooperGarlandEvent.OnClickEpisode, slot1, slot2)
end

function slot0.afterClickEpisode(slot0, slot1, slot2)
	if not slot1 or not slot2 or slot1 ~= CooperGarlandModel.instance:getAct192Id() then
		return
	end

	CooperGarlandStatHelper.instance:enterEpisode(slot2)

	if CooperGarlandConfig.instance:getStoryBefore(slot1, slot2) and slot4 ~= 0 then
		StoryController.instance:playStory(slot4, nil, slot0._enterGame, slot0, {
			episodeId = slot2
		})

		return
	end

	slot0:_enterGame({
		episodeId = slot2
	})
end

function slot0.openLevelView(slot0)
	slot0:getAct192Info(slot0._realOpenLevelView, slot0, true)
end

function slot0._realOpenLevelView(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.CooperGarlandLevelView)
end

function slot0.openTaskView(slot0)
	CooperGarlandTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity192
	}, slot0._realOpenTaskView, slot0)
end

function slot0._realOpenTaskView(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	CooperGarlandTaskListModel.instance:init()
	ViewMgr.instance:openView(ViewName.CooperGarlandTaskView)
end

function slot0.openResultView(slot0, slot1)
	if slot1 and slot1.isWin then
		CooperGarlandStatHelper.instance:sendEpisodeFinish()
	end

	slot3 = slot1 and slot1.episodeId

	if not CooperGarlandModel.instance:getAct192Id() or not slot3 then
		return
	end

	if not CooperGarlandConfig.instance:isGameEpisode(slot2, slot3) then
		return
	end

	ViewMgr.instance:openView(ViewName.CooperGarlandResultView, {
		episodeId = slot3,
		isWin = slot1.isWin
	})
end

function slot0._enterGame(slot0, slot1)
	if CooperGarlandConfig.instance:isGameEpisode(CooperGarlandModel.instance:getAct192Id(), slot1 and slot1.episodeId) then
		CooperGarlandStatHelper.instance:enterGame()
		CooperGarlandGameModel.instance:enterGameInitData(slot3)
		CooperGarlandGameEntityMgr.instance:enterMap()
		ViewMgr.instance:openView(ViewName.CooperGarlandGameView)
	else
		slot0:finishEpisode(slot3, true)
	end
end

function slot0.resetJoystick(slot0)
	slot0:dispatchEvent(CooperGarlandEvent.ResetJoystick)
end

function slot0.resetPanelBalance(slot0, slot1, slot2)
	slot0:changePanelBalance(0, 0, slot1, slot2)
end

function slot0.changePanelBalance(slot0, slot1, slot2, slot3, slot4)
	slot0:dispatchEvent(CooperGarlandEvent.ChangePanelAngle, slot1, slot2, slot3 or 0, slot4)
end

function slot0.changeRemoveMode(slot0)
	if not CooperGarlandGameModel.instance:getIsRemoveMode() and (not CooperGarlandGameModel.instance:getRemoveCount() or slot3 <= 0) then
		GameFacade.showToast(ToastEnum.CooperGarlandRemoveCountNotEnough)

		return
	end

	slot0:setStopGame(slot2)
	CooperGarlandGameModel.instance:setRemoveMode(slot2)
	slot0:dispatchEvent(CooperGarlandEvent.OnRemoveModeChange)
end

function slot0.changeControlMode(slot0)
	slot0:resetJoystick()
	slot0:resetPanelBalance(0, true)
	CooperGarlandGameModel.instance:setControlMode(CooperGarlandGameModel.instance:getControlMode() % CooperGarlandEnum.Const.JoystickModeLeft + 1)
	slot0:dispatchEvent(CooperGarlandEvent.OnChangeControlMode)
end

function slot0.removeComponent(slot0, slot1, slot2)
	if not CooperGarlandGameModel.instance:getIsRemoveMode() then
		return
	end

	if not CooperGarlandGameModel.instance:getRemoveCount() or slot4 <= 0 then
		return
	end

	if CooperGarlandConfig.instance:getMapComponentType(slot1, slot2) == CooperGarlandEnum.ComponentType.Hole or slot5 == CooperGarlandEnum.ComponentType.Spike then
		CooperGarlandGameEntityMgr.instance:removeComp(slot2)
		CooperGarlandGameModel.instance:setRemoveCount(slot4 - 1)
		slot0:dispatchEvent(CooperGarlandEvent.OnRemoveComponent, slot2)
	end
end

function slot0.enterNextRound(slot0)
	slot2 = CooperGarlandGameModel.instance:getGameRound() + 1

	if CooperGarlandConfig.instance:isExtraEpisode(CooperGarlandModel.instance:getAct192Id(), CooperGarlandGameModel.instance:getEpisodeId()) then
		slot0:saveGameProgress(slot4, slot2, true)
	end

	CooperGarlandGameModel.instance:changeRound(slot2)
	CooperGarlandGameEntityMgr.instance:changeMap()
	slot0:dispatchEvent(CooperGarlandEvent.OnEnterNextRound)
end

function slot0.resetGame(slot0)
	CooperGarlandGameModel.instance:resetGameData()
	CooperGarlandGameEntityMgr.instance:resetMap()
	slot0:dispatchEvent(CooperGarlandEvent.OnResetGame)
end

function slot0.exitGame(slot0)
	CooperGarlandGameEntityMgr.instance:clearAllMap()
	CooperGarlandGameModel.instance:clearAllData()
	ViewMgr.instance:closeView(ViewName.CooperGarlandGameView)
end

function slot0.setStopGame(slot0, slot1)
	if CooperGarlandGameModel.instance:getIsStopGame() == slot1 then
		return
	end

	CooperGarlandGameModel.instance:setIsStopGame(slot1)
	slot0:resetJoystick()
	slot0:resetPanelBalance(0, true)
	CooperGarlandGameEntityMgr.instance:checkBallFreeze(true)
	slot0:dispatchEvent(CooperGarlandEvent.OnGameStopChange)
end

function slot0.triggerEnterComponent(slot0, slot1, slot2)
	if not CooperGarlandGameEntityMgr.instance:isBallCanTriggerComp() then
		return
	end

	slot4 = nil

	if CooperGarlandConfig.instance:getMapComponentType(slot1, slot2) == CooperGarlandEnum.ComponentType.End then
		slot4 = AudioEnum2_7.CooperGarland.play_ui_yuzhou_ball_fall

		slot0:_ballArrivesEnd()
	elseif slot6 == CooperGarlandEnum.ComponentType.Hole or slot6 == CooperGarlandEnum.ComponentType.Spike then
		slot4 = slot6 == CooperGarlandEnum.ComponentType.Hole and slot5.play_ui_yuzhou_ball_trap or slot5.play_ui_yuzhou_ball_spikes

		CooperGarlandGameEntityMgr.instance:playBallDieVx()
		slot0:_gameFail(slot2)
	elseif slot6 == CooperGarlandEnum.ComponentType.Key then
		slot0:_ballKeyChange(true)

		slot4 = slot5.play_ui_yuzhou_ball_star

		CooperGarlandGameEntityMgr.instance:removeComp(slot2)
	elseif slot6 == CooperGarlandEnum.ComponentType.Story then
		slot0:_triggerStory(CooperGarlandConfig.instance:getMapComponentExtraParams(slot1, slot2))
	end

	if slot4 then
		AudioMgr.instance:trigger(slot4)
	end
end

function slot0.triggerExitComponent(slot0, slot1, slot2)
	slot3 = CooperGarlandConfig.instance:getMapComponentType(slot1, slot2)
end

function slot0._ballArrivesEnd(slot0)
	slot0:setStopGame(true)
	CooperGarlandStatHelper.instance:sendMapArrive()

	if CooperGarlandConfig.instance:getMaxRound(CooperGarlandGameModel.instance:getGameId()) <= CooperGarlandGameModel.instance:getGameRound() then
		CooperGarlandStatHelper.instance:sendGameFinish()
		slot0:dispatchEvent(CooperGarlandEvent.PlayFinishEpisodeStarVX)
	else
		slot0:dispatchEvent(CooperGarlandEvent.PlayEnterNextRoundAnim)
	end
end

function slot0._gameFail(slot0, slot1)
	slot0:setStopGame(true)
	CooperGarlandStatHelper.instance:sendMapFail(slot1)
	slot0:openResultView({
		isWin = false,
		episodeId = CooperGarlandGameModel.instance:getEpisodeId()
	})
end

function slot0._ballKeyChange(slot0, slot1)
	CooperGarlandGameModel.instance:setBallHasKey(slot1)
	slot0:dispatchEvent(CooperGarlandEvent.OnBallKeyChange)
end

function slot0._triggerStory(slot0, slot1)
	if not (slot1 and tonumber(slot1)) then
		return
	end

	if not GuideModel.instance:isGuideRunning(slot2) or GuideController.instance:isForbidGuides() then
		return
	end

	slot0:setStopGame(true)
	slot0:dispatchEvent(CooperGarlandEvent.triggerGuideDialogue, slot2)
end

slot0.instance = slot0.New()

return slot0
