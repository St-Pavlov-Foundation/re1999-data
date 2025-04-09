module("modules.logic.fight.entity.comp.skill.FightTLEventPlayEffectByOperation", package.seeall)

slot0 = class("FightTLEventPlayEffectByOperation", FightTimelineTrackItem)

function slot0.onTrackStart(slot0, slot1, slot2, slot3)
	slot0.curCount = 0
	slot0.operationWorkList = {}

	FightController.instance:registerCallback(FightEvent.OperationForPlayEffect, slot0.onOperationForPlayEffect, slot0)

	slot0.fightStepData = slot1
	slot0.paramsArr = slot3
	slot0.effectType = tonumber(slot0.paramsArr[1])

	if ({
		[-666.0] = "GMFightNuoDiKaXianJieAnNiu"
	})[slot0.effectType] then
		ViewMgr.instance:openView(slot5, {
			effectType = slot0.effectType,
			timeLimit = tonumber(slot0.paramsArr[4])
		})
	end

	slot0.sequenceFlow = FightWorkFlowSequence.New()

	slot0.timelineItem:addWork2FinishWork(slot0.sequenceFlow)
	slot0:buildOperationWorkList()
	TaskDispatcher.runDelay(slot0.playAllOperationWork, slot0, tonumber(slot0.paramsArr[3]))
	slot0.sequenceFlow:registWork(FightWorkFunction, slot0.clearEvent, slot0)

	if slot5 then
		slot0.sequenceFlow:registWork(FightWorkFunction, slot0.closeView, slot0, slot5)
	end

	if not string.nilorempty(slot0.paramsArr[6]) then
		slot0.sequenceFlow:registWork(FightWorkDelayTimer, tonumber(slot0.paramsArr[5]))
		slot0.sequenceFlow:registWork(FightWorkPlayFakeStepTimeline, slot6, slot1)
	end
end

function slot0.buildOperationWorkList(slot0)
	slot0.timelineDic = {}
	slot5 = "#"

	for slot5, slot6 in ipairs(GameUtil.splitString2(slot0.paramsArr[2], false, ",", slot5)) do
		slot0.timelineDic[tonumber(slot6[1])] = {}

		for slot12, slot13 in ipairs(string.split(slot6[2], "|")) do
			table.insert(slot0.timelineDic[slot7], slot13)
		end
	end

	for slot7, slot8 in ipairs(slot0.fightStepData.actEffect) do
		if slot8.effectType == slot0.effectType then
			table.insert(slot0.operationWorkList, slot0.sequenceFlow:registWork(FightWorkFlowParallel):registWork(FightWorkPlayEffectTimelineByOperation, slot8, slot0.paramsArr, slot0.fightStepData, slot0.timelineDic))
		end
	end
end

function slot0.clearEvent(slot0)
	TaskDispatcher.cancelTask(slot0.playAllOperationWork, slot0)
	FightController.instance:unregisterCallback(FightEvent.OperationForPlayEffect, slot0.onOperationForPlayEffect, slot0)
end

function slot0.onOperationForPlayEffect(slot0, slot1)
	if slot1 ~= slot0.effectType then
		return
	end

	slot0.curCount = slot0.curCount + 1

	if slot0.operationWorkList[slot0.curCount] then
		slot2:playTimeline()
	end
end

function slot0.playAllOperationWork(slot0)
	for slot4, slot5 in ipairs(slot0.operationWorkList) do
		slot5:playTimeline()
	end
end

function slot0.closeView(slot0, slot1)
	ViewMgr.instance:closeView(slot1, true)
end

function slot0.onTrackEnd(slot0)
end

function slot0.onDestructor(slot0)
end

return slot0
