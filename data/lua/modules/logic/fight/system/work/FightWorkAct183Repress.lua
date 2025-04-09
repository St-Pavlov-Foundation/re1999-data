module("modules.logic.fight.system.work.FightWorkAct183Repress", package.seeall)

slot0 = class("FightWorkAct183Repress", BaseWork)

function slot0.onStart(slot0, slot1)
	if not DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) or slot2.type ~= DungeonEnum.EpisodeType.Act183 then
		slot0:onDone(true)

		return
	end

	if not Act183Model.instance:getBattleFinishedInfo() or not slot3.win then
		slot0:onDone(true)

		return
	end

	if ActivityHelper.getActivityStatus(slot3.activityId) ~= ActivityEnum.ActivityStatus.Normal then
		slot0:onDone(true)

		return
	end

	if not Act183Helper.isLastPassEpisodeInGroup(slot3.episodeMo) then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
		Act183Controller.instance:openAct183RepressView(slot3)

		return
	end

	slot0:onDone(true)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.Act183RepressView then
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
end

return slot0
