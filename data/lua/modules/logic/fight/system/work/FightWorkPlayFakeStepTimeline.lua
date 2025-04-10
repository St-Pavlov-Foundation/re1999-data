module("modules.logic.fight.system.work.FightWorkPlayFakeStepTimeline", package.seeall)

slot0 = class("FightWorkPlayFakeStepTimeline", FightWorkItem)

function slot0.onConstructor(slot0, slot1, slot2)
	slot0.timelineName = slot1
	slot0.fightStepData = slot2
	slot0.SAFETIME = 30
end

function slot0.onStart(slot0)
	slot0:com_registFightEvent(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, LuaEventSystem.Low)

	if not FightHelper.getEntity(slot0.fightStepData.fromId) then
		slot0:onDone(true)

		return
	end

	slot1.skill:playTimeline(slot0.timelineName, slot0.fightStepData)
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2, slot3)
	if slot3 == slot0.fightStepData then
		slot0:onDone(true)
	end
end

return slot0
