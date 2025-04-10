module("modules.logic.fight.system.work.FightParallelPlaySameSkillStep", package.seeall)

slot0 = class("FightParallelPlaySameSkillStep", BaseWork)

function slot0.ctor(slot0, slot1, slot2)
	slot0.fightStepData = slot1
	slot0.preStepData = slot2

	FightController.instance:registerCallback(FightEvent.ParallelPlaySameSkillCheck, slot0._parallelPlaySameSkillCheck, slot0)
end

function slot0.onStart(slot0)
	slot0:onDone(true)
end

function slot0._parallelPlaySameSkillCheck(slot0, slot1)
	if slot1 ~= slot0.preStepData then
		return
	end

	if slot0.fightStepData.fromId == slot0.preStepData.fromId and slot0.fightStepData.actId == slot0.preStepData.actId and slot0.fightStepData.toId == slot0.preStepData.toId then
		FightController.instance:dispatchEvent(FightEvent.ParallelPlaySameSkillDoneThis, slot1)
	end
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.ParallelPlaySameSkillCheck, slot0._parallelPlaySameSkillCheck, slot0)
end

return slot0
