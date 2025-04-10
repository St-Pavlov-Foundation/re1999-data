module("modules.logic.fight.view.cardeffect.FightCardResetEffect", package.seeall)

slot0 = class("FightCardResetEffect", BaseWork)
slot2 = 1 * 0.033

function slot0.onStart(slot0, slot1)
	TaskDispatcher.runDelay(slot0.onDelayDone, slot0, 1)

	slot0._dt = uv0 / FightModel.instance:getUISpeed()
	slot0.flow = FightWorkFlowSequence.New()

	slot0.flow:registWork(FightWorkSendEvent, FightEvent.CorrectHandCardScale)

	slot3 = slot0.context.view.viewContainer.fightViewHandCard._handCardItemList

	if slot1.curIndex2OriginHandCardIndex then
		for slot8, slot9 in ipairs(slot3) do
			slot11 = slot9.cardInfoMO

			if slot1.curIndex2OriginHandCardIndex[slot8] then
				slot2:registWork(FightWorkFlowParallel):registWork(FightTweenWork, {
					type = "DOAnchorPos",
					toy = 0,
					tr = slot9.go.transform,
					tox = FightViewHandCard.calcCardPosX(slot12),
					t = slot0._dt * 4
				})
			end
		end
	end

	slot2:registWork(FightWorkSendEvent, FightEvent.UpdateHandCards)
	slot2:registFinishCallback(slot0._onWorkDone, slot0)
	slot2:start()
end

function slot0.onDelayDone(slot0)
	FightController.instance:dispatchEvent(FightEvent.UpdateHandCards)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0.onDelayDone, slot0)

	if slot0.flow then
		slot0.flow:disposeSelf()

		slot0.flow = nil
	end
end

function slot0._onWorkDone(slot0)
	slot0:onDone(true)
end

return slot0
