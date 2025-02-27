module("modules.logic.versionactivity2_6.xugouji.controller.XugoujiController", package.seeall)

slot0 = class("XugoujiController", BaseController)
slot1 = VersionActivity2_6Enum.ActivityId.Xugouji

function slot0.onInit(slot0)
	slot0._debugMode = PlayerPrefsHelper.getNumber("XugoujiDebugMode", 0) == 1
end

function slot0.reInit(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0._setGuideMode(slot0, slot1)
	Activity188Model.instance:setGameGuideMode(slot1)
end

function slot0.openXugoujiLevelView(slot0)
	slot0:registerCallback(XugoujiEvent.SetGameGuideMode, slot0._setGuideMode, slot0)

	if slot0:_checkCanPlayStory(ActivityModel.instance:getActMO(uv0) and slot1.config and slot1.config.storyId) then
		StoryController.instance:playStory(slot2, nil, slot0._requestActInfo, slot0)
	else
		slot0:_requestActInfo()
	end
end

function slot0._requestActInfo(slot0)
	Activity188Rpc.instance:sendGet188InfosRequest(VersionActivity2_6Enum.ActivityId.Xugouji, slot0._onReceivedActInfo, slot0)
end

function slot0._onReceivedActInfo(slot0)
	ViewMgr.instance:openView(ViewName.XugoujiLevelView)
end

function slot0.openXugoujiGameView(slot0)
	ViewMgr.instance:openView(ViewName.XugoujiGameView)
end

function slot0.openTaskView(slot0)
	ViewMgr.instance:openView(ViewName.XugoujiTaskView)
end

function slot0.openCardInfoView(slot0, slot1)
	slot0._lastCardInfoUId = cardUid

	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardInfo)
	ViewMgr.instance:openView(ViewName.XugoujiCardInfoView, {
		cardId = slot1 or Activity188Model.instance:getLastCardId()
	})
end

function slot0.openGameResultView(slot0, slot1)
	if slot0._isWaitingEventResult then
		slot0._isWaitingGameResult = true

		return
	end

	slot0._isWaitingGameResult = false

	slot0:dispatchEvent(XugoujiEvent.OnOpenGameResultView)
	ViewMgr.instance:openView(ViewName.XugoujiGameResultView, slot1)

	slot2 = slot0:getStatMo()

	slot2:setGameData(slot1.reason == XugoujiEnum.ResultEnum.Completed and 1 or 0, Activity188Model.instance:getRound(), Activity188Model.instance:getCurHP(), Activity188Model.instance:getEnemyHP(), Activity188Model.instance:getCurPairCount(), Activity188Model.instance:getEnemyPairCount())
	slot2:sendGameFinishStatData()
end

function slot0.enterEpisode(slot0, slot1)
	Activity188Model.instance:setCurActId(VersionActivity2_6Enum.ActivityId.Xugouji)

	slot0._curEnterEpisode = slot1

	Activity188Rpc.instance:sendAct188EnterEpisodeRequest(VersionActivity2_6Enum.ActivityId.Xugouji, slot1, slot0._onEnterGameReply, slot0)
	Activity188Rpc.instance:SetEpisodePushCallback(slot0._onEpisodeUpdate, slot0)
end

function slot0._onEnterGameReply(slot0)
	slot4 = slot0:getStatMo()

	slot4:reset()
	slot4:setBaseData(uv0, slot0._curEnterEpisode)

	if Activity188Config.instance:getGameCfg(uv0, Activity188Config.instance:getEpisodeCfg(uv0, slot0._curEnterEpisode).gameId) then
		slot0._lastCardInfoUId = -1

		XugoujiGameStepController.instance:clear()
		slot4:setBaseData(uv0, slot0._curEnterEpisode, slot3.id)
	end

	Activity188Model.instance:setCurEpisodeId(slot0._curEnterEpisode)
	slot0:dispatchEvent(XugoujiEvent.EnterEpisode, slot0._curEnterEpisode)
end

function slot0.restartEpisode(slot0)
	Activity188Rpc.instance:sendAct188EnterEpisodeRequest(VersionActivity2_6Enum.ActivityId.Xugouji, slot0._curEnterEpisode, slot0._onRestartGameReply, slot0)
	Activity188Rpc.instance:SetEpisodePushCallback(slot0._onEpisodeUpdate, slot0)
end

function slot0._onRestartGameReply(slot0)
	Activity188Model.instance:setCurEpisodeId(slot0._curEnterEpisode)
	XugoujiGameStepController.instance:clear()

	slot3 = slot0:getStatMo()

	slot3:reset()
	slot3:setBaseData(uv0, slot0._curEnterEpisode, Activity188Config.instance:getGameCfg(uv0, Activity188Model.instance:getCurGameId()).id)
	XugoujiGameStepController.instance:insertStepListClient({
		{
			stepType = XugoujiEnum.GameStepType.GameReStart
		},
		{
			stepType = XugoujiEnum.GameStepType.UpdateInitialCard
		}
	})
	slot0:dispatchEvent(XugoujiEvent.GameRestart)
end

function slot0.finishStoryPlay(slot0)
	Activity188Rpc.instance:sendAct188StoryRequest(VersionActivity2_6Enum.ActivityId.Xugouji, Activity188Model.instance:getCurEpisodeId(), slot0._onEpisodeUpdate, slot0)
	uv0.instance:getStatMo():sendDungeonFinishStatData()
end

function slot0.selectCardItem(slot0, slot1)
	if Activity188Model.instance:getCurTurnOperateTime() == 0 then
		return
	end

	if Activity188Model.instance:isHpZero() then
		return
	end

	if slot1 == Activity188Model.instance:getCurCardUid() then
		return
	end

	Activity188Model.instance:setCurTurnOperateTime(slot2 - 1, false)
	slot0:dispatchEvent(XugoujiEvent.OperateTimeUpdated)
	Activity188Model.instance:setCurCardUid(slot1)
	Activity188Rpc.instance:sendAct188ReverseCardRequest(uv0, slot0._curEnterEpisode, slot1, slot0._onOperateCardReply, slot0)
end

function slot0._onOperateCardReply(slot0, slot1, slot2)
	slot0:dispatchEvent(XugoujiEvent.OperateCard, Activity188Model.instance:getCurCardUid())
end

function slot0.manualExitGame(slot0)
	XugoujiGameStepController.instance:disposeAllStep()
	slot0:dispatchEvent(XugoujiEvent.ManualExitGame)
end

function slot0.sendExitGameStat(slot0)
	slot1 = slot0:getStatMo()

	slot1:setGameData(nil, Activity188Model.instance:getRound(), Activity188Model.instance:getCurHP(), Activity188Model.instance:getEnemyHP(), Activity188Model.instance:getCurPairCount(), Activity188Model.instance:getEnemyPairCount())
	slot1:sendGameGiveUpStatData()
	slot1:sendDungeonFinishStatData()
end

function slot0.gameResultOver(slot0)
	slot0:dispatchEvent(XugoujiEvent.ExitGame)
end

function slot0._onEpisodeUpdate(slot0)
	slot0:dispatchEvent(XugoujiEvent.EpisodeUpdate)
end

function slot0._checkCanPlayStory(slot0, slot1)
	if slot1 and slot1 ~= 0 and not StoryModel.instance:isStoryHasPlayed(slot1) then
		return true
	end

	return false
end

function slot0.checkOptionChoosed(slot0, slot1)
	if not slot0._optionDescRecord then
		slot0._optionDescRecord = {}
		slot0._optionDescRecordStr = ""
		slot0._optionDescRecordStr = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_2LoperaOptionDesc, "")

		for slot6, slot7 in pairs(string.splitToNumber(slot0._optionDescRecordStr, ",")) do
			slot0._optionDescRecord[slot7] = true
		end
	end

	return slot0._optionDescRecord[slot1]
end

function slot0.saveOptionChoosed(slot0, slot1)
	slot0._optionDescRecord[slot1] = true

	if string.nilorempty(slot0._optionDescRecordStr) then
		slot0._optionDescRecordStr = slot1
	else
		slot0._optionDescRecordStr = slot0._optionDescRecordStr .. "," .. slot1
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_2LoperaOptionDesc, slot0._optionDescRecordStr)
end

function slot0.getStatMo(slot0)
	if not slot0.statMo then
		slot0.statMo = Activity188StatMo.New()
	end

	return slot0.statMo
end

function slot0.setDebugMode(slot0, slot1)
	slot0._debugMode = slot1
end

function slot0.isDebugMode(slot0)
	return slot0._debugMode
end

slot0.instance = slot0.New()

return slot0
