module("modules.logic.fight.view.cardeffect.FightCardPlayEffect", package.seeall)

slot0 = class("FightCardPlayEffect", BaseWork)
slot1 = 1

function slot0.onStart(slot0, slot1)
	slot0._dt = 0.033 * uv0 / FightModel.instance:getUISpeed()
	slot0._tweenParamList = nil

	uv1.super.onStart(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_FightPlayCard)

	slot3 = table.remove(slot1.handCardItemList, slot1.from)

	table.insert(slot1.handCardItemList, slot3)
	FightViewHandCard.refreshCardIndex(slot1.handCardItemList)
	slot3:setASFDActive(false)

	if slot3._cardItem then
		slot3._cardItem:setHeatRootVisible(false)
	end

	slot0._cardInfoMO = slot3.cardInfoMO:clone()
	slot0._clonePlayCardGO = gohelper.cloneInPlace(slot3.go)

	gohelper.setActive(slot3.go, false)
	slot3:updateItem(#slot1.handCardItemList, nil)
	slot0:_addTrailEffect(slot0._clonePlayCardGO.transform)

	slot5 = true
	slot6 = false

	if slot0.context.needDiscard then
		slot5 = false
		slot6 = true
	end

	slot7 = false

	if slot1.dissolveCardIndexsAfterPlay and #slot8 > 0 then
		slot5 = false
		slot7 = true
	end

	slot9 = false

	if slot5 then
		slot9 = FightCardDataHelper.canCombineCardListForPerformance(FightDataHelper.handCardMgr.handCard) or false
	end

	if slot9 then
		slot0._stepCount = 1
	elseif slot6 or slot7 then
		slot0._stepCount = 2
	elseif FightDataHelper.operationDataMgr:isCardOpEnd() and #FightDataHelper.operationDataMgr:getOpList() > 0 then
		slot0._stepCount = 2
	else
		slot0._stepCount = 1
	end

	FightController.instance:unregisterCallback(FightEvent.PlayCardFlayFinish, slot0._onPlayCardFlayFinish, slot0)

	if slot0._stepCount == 2 then
		FightController.instance:registerCallback(FightEvent.PlayCardFlayFinish, slot0._onPlayCardFlayFinish, slot0)
	end

	slot0._main_flow = FlowSequence.New()

	FlowSequence.New():addWork(FunctionWork.New(function ()
		FightController.instance:dispatchEvent(FightEvent.ShowPlayCardFlyEffect, uv0._cardInfoMO, uv0._clonePlayCardGO, uv0.context.fightBeginRoundOp)
	end))

	slot11 = false

	if FightCardDataHelper.isNoCostSpecialCard(slot0._cardInfoMO) then
		slot11 = true
	end

	if FightCardDataHelper.isSkill3(slot0._cardInfoMO) then
		slot11 = true
	end

	slot12 = slot0.context.fightBeginRoundOp

	if not FightCardDataHelper.checkIsBigSkillCostActPoint(slot12.belongToEntityId, slot12.skillId) then
		slot11 = true
	end

	if slot11 then
		slot10:addWork(slot0:_buildNoActCostMoveFlow())
	end

	slot10:addWork(WorkWaitSeconds.New(slot0._dt * 1))

	if slot9 then
		slot10:addWork(FunctionWork.New(function ()
			uv0:_playShrinkFlow()
		end))
		slot10:addWork(WorkWaitSeconds.New(slot0._dt * 6))
	else
		slot10:addWork(slot0:_startShrinkFlow())
	end

	slot0._main_flow:addWork(slot10)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 10 / FightModel.instance:getUISpeed())
	slot0._main_flow:registerDoneListener(slot0._onPlayCardDone, slot0)
	slot0._main_flow:start(slot1)
end

function slot0._onPlayCardFlayFinish(slot0, slot1)
	if slot1 == slot0.context.fightBeginRoundOp then
		slot0:_checkDone()
	end
end

function slot0._delayDone(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	logError("出牌流程超过了10秒,可能卡住了,先强制结束")

	slot0._stepCount = 1

	slot0:_onPlayCardDone()
	slot0:onStop()
end

function slot0._onPlayCardDone(slot0)
	slot0._main_flow:unregisterDoneListener(slot0._onPlayCardDone, slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	slot0:_checkDone()
end

function slot0._checkDone(slot0)
	slot0._stepCount = slot0._stepCount - 1

	if slot0._stepCount <= 0 then
		slot0:onDone(true)
	end
end

function slot0._addTrailEffect(slot0, slot1)
	if GMFightShowState.cards then
		slot2 = ResUrl.getUIEffect(FightPreloadViewWork.ui_kapaituowei)
		slot0._tailEffectGO = gohelper.clone(FightHelper.getPreloadAssetItem(slot2):GetResource(slot2), slot1.gameObject)
		slot0._tailEffectGO.name = FightPreloadViewWork.ui_kapaituowei
	end
end

function slot0._buildNoActCostMoveFlow(slot0)
	slot1 = FlowSequence.New()
	slot2 = FlowParallel.New()
	slot3, slot4 = FightViewPlayCard.getMaxItemCount()
	slot5 = slot0.context.view.viewContainer.fightViewPlayCard._playCardItemList
	slot6 = slot0.context.view.viewContainer.fightViewPlayCard:getShowIndex(slot0.context.fightBeginRoundOp)

	if FightViewPlayCard.VisibleCount >= slot3 then
		for slot10 = 1, #slot5 do
			slot11 = slot5[slot10].tr

			if slot6 < slot10 then
				slot12 = slot10 + 1
			end

			slot2:addWork(TweenWork.New({
				type = "DOAnchorPosX",
				tr = slot11,
				to = FightViewPlayCard.calcCardPosX(slot12, slot3),
				t = slot0._dt * 3
			}))
		end
	end

	slot1:addWork(slot2)
	slot1:addWork(FunctionWork.New(function ()
		FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	end))

	return slot1
end

function slot0._playShrinkFlow(slot0)
	slot0._shrinkFlow = slot0:_startShrinkFlow()

	slot0._shrinkFlow:start()
end

function slot0._startShrinkFlow(slot0)
	FlowSequence.New():addWork(WorkWaitSeconds.New(slot0._dt * 2))

	slot2 = FlowParallel.New()

	for slot7, slot8 in ipairs(slot0.context.handCardItemList) do
		if slot8.go.activeInHierarchy and slot0.context.from <= slot7 then
			slot10 = FightViewHandCard.calcCardPosX(slot7)
			slot11 = FlowSequence.New()

			if (1 + 1) * slot0._dt > 0 then
				slot11:addWork(WorkWaitSeconds.New(slot12))
			end

			slot11:addWork(TweenWork.New({
				type = "DOAnchorPosX",
				tr = slot8.tr,
				to = slot10,
				t = slot0._dt * 5,
				ease = EaseType.OutQuart
			}))
			slot2:addWork(slot11)
		end
	end

	slot1:addWork(slot2)

	return slot1
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.PlayCardFlayFinish, slot0._onPlayCardFlayFinish, slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)

	if slot0._main_flow then
		slot0._main_flow:stop()

		slot0._main_flow = nil
	end

	if slot0._shrinkFlow then
		slot0._shrinkFlow:stop()

		slot0._shrinkFlow = nil
	end
end

return slot0
