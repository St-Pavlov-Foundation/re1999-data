module("modules.logic.weekwalk_2.controller.WeekWalk_2Controller", package.seeall)

slot0 = class("WeekWalk_2Controller", BaseController)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.onInitFinish(slot0)
end

function slot0.clear(slot0)
	slot0._requestTask = false
	slot0._requestTimes = 0
	slot0._maxRequestTimes = 3
end

function slot0.addConstEvents(slot0)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, slot0._refreshTaskData, slot0)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, slot0._refreshTaskData, slot0)
	uv0.instance:registerCallback(WeekWalk_2Event.OnGetInfo, slot0.startCheckTime, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0, LuaEventSystem.Low)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseView, slot0)
	FightController.instance:registerCallback(FightEvent.OnBreakResultViewClose, slot0._onBreakResultViewClose, slot0)
end

function slot0._onBreakResultViewClose(slot0, slot1)
	if DungeonModel.instance.curSendEpisodeId and DungeonConfig.instance:getEpisodeCO(slot2) and slot3.type == DungeonEnum.EpisodeType.WeekWalk_2 and WeekWalk_2Model.instance:getSettleInfo() then
		slot1.isBreak = true
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 ~= ViewName.FightSuccView then
		return
	end

	if DungeonModel.instance.curSendEpisodeId and DungeonConfig.instance:getEpisodeCO(slot2) and slot3.type == DungeonEnum.EpisodeType.WeekWalk_2 and WeekWalk_2Model.instance:getSettleInfo() then
		uv0.instance:openWeekWalk_2HeartResultView()
	end
end

function slot0._onDailyRefresh(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		return
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.WeekWalk_2
	})
	Weekwalk_2Rpc.instance:sendWeekwalkVer2GetInfoRequest()
end

function slot0.startCheckTime(slot0)
	TaskDispatcher.runRepeat(slot0._checkTime, slot0, 1)
end

function slot0.stopCheckTime(slot0)
	TaskDispatcher.cancelTask(slot0._checkTime, slot0)
end

function slot0._checkTime(slot0)
	if not WeekWalk_2Model.instance:getInfo() or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.WeekWalk) then
		slot0:stopCheckTime()

		return
	end

	if slot1.endTime > 0 and slot2 - ServerTime.now() <= 0 then
		slot0:stopCheckTime()
		slot0:_recordRequestTimes()

		if slot0._maxRequestTimes < slot0._requestTimes then
			logError("sendWeekwalkVer2GetInfoRequest too many times")

			return
		end

		slot0:requestTask(true)
		Weekwalk_2Rpc.instance:sendWeekwalkVer2GetInfoRequest()

		return
	end

	slot0:_clearRequestTimes()
end

function slot0._recordRequestTimes(slot0)
	slot0._requestTimes = slot0._requestTimes or 0
	slot0._requestTimes = slot0._requestTimes + 1
end

function slot0._clearRequestTimes(slot0)
	slot0._requestTimes = 0
end

function slot0.requestTask(slot0, slot1)
	if slot0._requestTask and not slot1 then
		return
	end

	slot0._requestTask = true

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.WeekWalk_2
	})
end

function slot0._refreshTaskData(slot0)
	WeekWalk_2TaskListModel.instance:updateTaskList()
	slot0:dispatchEvent(WeekWalk_2Event.OnWeekwalkTaskUpdate)
end

function slot0.enterWeekwalk_2Fight(slot0, slot1, slot2)
	if not slot1 then
		logError("enterWeekwalk_2Fight elementId nil")
	end

	WeekWalk_2Model.instance:setBattleElementId(slot1)

	slot3 = WeekWalk_2Enum.episodeId
	DungeonModel.instance.curLookEpisodeId = slot3

	DungeonFightController.instance:enterFightByBattleId(DungeonConfig.instance:getEpisodeCO(slot3).chapterId, slot3, slot2)
end

function slot0.openWeekWalk_2HeartLayerView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.WeekWalk_2HeartLayerView, slot1, slot2)
end

function slot0.openWeekWalk_2HeartView(slot0, slot1, slot2)
	if not (slot1 or {}).mapId then
		slot3 = FightModel.instance:getBattleId()

		FightModel.instance:clearBattleId()

		slot1.mapId = WeekWalk_2Model.instance:getCurMapId()
	end

	if slot1.mapId then
		WeekWalk_2Model.instance:setCurMapId(slot1.mapId)
	end

	ViewMgr.instance:openView(ViewName.WeekWalk_2HeartView, slot1, slot2)
end

function slot0.openWeekWalk_2HeartBuffView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.WeekWalk_2HeartBuffView, slot1, slot2)
end

function slot0.openWeekWalk_2HeartResultView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.WeekWalk_2HeartResultView, slot1, slot2)
end

function slot0.openWeekWalk_2ResetView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.WeekWalk_2ResetView, slot1, slot2)
end

function slot0.openWeekWalk_2LayerRewardView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.WeekWalk_2LayerRewardView, slot1, slot2)
end

function slot0.openWeekWalk_2RuleView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.WeekWalk_2RuleView, slot1, slot2)
end

function slot0.openWeekWalk_2DeepLayerNoticeView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.WeekWalk_2DeepLayerNoticeView, slot1, slot2)
end

function slot0.checkOpenWeekWalk_2DeepLayerNoticeView(slot0, slot1, slot2)
	if not WeekWalk_2Model.instance:getInfo() or not slot3.isPopSettle then
		return
	end

	if WeekWalkEnum.FirstDeepLayer <= WeekWalkModel.instance:getMaxLayerId() or GuideController.instance:isForbidGuides() or GuideModel.instance:isGuideFinish(GuideEnum.GuideId.WeekWalkDeep) then
		slot0:openWeekWalk_2DeepLayerNoticeView()
	end
end

function slot0.jumpWeekWalkHeartLayerView(slot0, slot1, slot2)
	slot0._jumpCallback = slot1
	slot0._jumpCallbackTarget = slot2

	module_views_preloader.preloadMultiView(slot0._preloadCallback, slot0, {
		ViewName.DungeonView,
		ViewName.WeekWalk_2HeartLayerView
	}, {
		DungeonEnum.dungeonweekwalk_2viewPath
	})
end

function slot0._preloadCallback(slot0)
	WeekWalkModel.instance:setSkipShowSettlementView(true)
	DungeonModel.instance:changeCategory(DungeonEnum.ChapterType.WeekWalk)
	DungeonController.instance:enterDungeonView()
	TaskDispatcher.runDelay(slot0._delayOpenLayerView, slot0, 0)

	slot0._jumpCallback = nil
	slot0._jumpCallbackTarget = nil

	if slot0._jumpCallback then
		slot1(slot0._jumpCallbackTarget)
	end
end

function slot0._delayOpenLayerView(slot0)
	uv0.instance:openWeekWalk_2HeartLayerView()
end

function slot0.hasOnceActionKey(slot0, slot1)
	return PlayerPrefsHelper.hasKey(uv0._getKey(slot0, slot1))
end

function slot0.setOnceActionKey(slot0, slot1)
	PlayerPrefsHelper.setNumber(uv0._getKey(slot0, slot1), 1)
end

function slot0._getKey(slot0, slot1)
	return string.format("%s%s_%s_%s", PlayerPrefsKey.WeekWalk_2OnceAnim, PlayerModel.instance:getPlayinfo().userId, slot0, slot1)
end

slot0.instance = slot0.New()

return slot0
