module("modules.logic.fight.system.work.asfd.FightASFDFlow", package.seeall)

slot0 = class("FightASFDFlow", BaseFlow)
slot0.DelayWaitTime = 61

function slot0.ctor(slot0, slot1, slot2, slot3)
	slot0.stepMo = slot1
	slot0.curIndex = slot3
	slot0.asfdContext = slot0:getContext(slot1)
	slot0.nextStepMo = slot2
end

function slot0.createNormalSeq(slot0)
	slot1 = slot0.stepMo
	slot0._sequence = FlowSequence.New()

	slot0._sequence:addWork(FightWorkCreateASFDEmitter.New(slot1))
	FlowSequence.New():addWork(FightWorkMissileASFD.New(slot1, slot0.asfdContext))

	slot3 = FlowParallel.New()

	if slot0:checkNeedAddWaitDoneWork(slot0.nextStepMo) then
		slot2:addWork(FightWorkMissileASFDDone.New(slot1))
		slot3:addWork(FightWorkWaitASFDArrivedDone.New(slot1))
	end

	slot3:addWork(slot2)
	slot0._sequence:addWork(slot3)
	slot0._sequence:addWork(FightWorkASFDEffectFlow.New(slot1))

	if slot4 then
		slot0._sequence:addWork(FightWorkASFDDone.New(slot1))
	else
		slot0._sequence:addWork(FightWorkASFDContinueDone.New(slot1))
	end
end

function slot0.createPullOutSeq(slot0)
	slot0._sequence = FlowSequence.New()
	slot1 = FlowParallel.New()

	slot1:addWork(FightWorkASFDClearEmitter.New(slot0.stepMo))
	slot1:addWork(FightWorkASFDPullOut.New(slot0.stepMo))
	slot1:addWork(FightWorkASFDEffectFlow.New(slot0.stepMo))
	slot0._sequence:addWork(slot1)
	slot0._sequence:addWork(FightWorkASFDDone.New(slot0.stepMo))
end

function slot0.getContext(slot0, slot1)
	if FightASFDHelper.getStepContext(slot1, slot0.curIndex) then
		return slot2
	end

	logError("not found EMITTER FIGHT NOTIFY !!!")

	return {
		splitNum = 0,
		emitterAttackNum = 1,
		emitterAttackMaxNum = 2
	}
end

function slot0.checkNeedAddWaitDoneWork(slot0, slot1)
	if slot0:checkHasMonsterChangeEffectType(slot0.stepMo) then
		return true
	end

	if not slot1 then
		return true
	end

	if FightASFDHelper.isALFPullOutStep(slot1, slot0.curIndex) then
		return true
	end

	if not FightHelper.isASFDSkill(slot1.actId) then
		return true
	end

	return false
end

function slot0.checkHasMonsterChangeEffectType(slot0, slot1)
	if not slot1 then
		return false
	end

	for slot5, slot6 in ipairs(slot1.actEffectMOs) do
		if slot6.effectType == FightEnum.EffectType.MONSTERCHANGE then
			return true
		end

		if slot6.effectType == FightEnum.EffectType.FIGHTSTEP and slot0:checkHasMonsterChangeEffectType(slot6.cus_stepMO) then
			return true
		end
	end

	return false
end

function slot0.onStart(slot0)
	if FightASFDHelper.isALFPullOutStep(slot0.stepMo, slot0.curIndex) then
		slot0:createPullOutSeq()
	else
		slot0:createNormalSeq()
	end

	slot0._sequence:registerDoneListener(slot0._flowDone, slot0)
	slot0._sequence:start()
end

function slot0.hasDone(slot0)
	return not slot0._sequence or slot0._sequence.status ~= WorkStatus.Running
end

function slot0.stopSkillFlow(slot0)
	if slot0._sequence and slot0._sequence.status == WorkStatus.Running then
		slot0._sequence:stop()
		slot0._sequence:unregisterDoneListener(slot0._flowDone, slot0)

		slot0._sequence = nil
	end
end

function slot0._flowDone(slot0)
	if slot0._sequence then
		slot0._sequence:unregisterDoneListener(slot0._flowDone, slot0)

		slot0._sequence = nil
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._sequence then
		slot0._sequence:stop()
		slot0._sequence:unregisterDoneListener(slot0._flowDone, slot0)

		slot0._sequence = nil
	end
end

return slot0
