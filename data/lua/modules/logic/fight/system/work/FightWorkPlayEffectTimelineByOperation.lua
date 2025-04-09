module("modules.logic.fight.system.work.FightWorkPlayEffectTimelineByOperation", package.seeall)

slot0 = class("FightWorkPlayEffectTimelineByOperation", FightWorkItem)

function slot0.onConstructor(slot0, slot1, slot2, slot3, slot4)
	slot0.actEffectData = slot1
	slot0.param = slot2
	slot0.originFightStepData = slot3
	slot0.SAFETIME = 30
	slot0.timelineDic = slot4
end

function slot0.onStart(slot0)
	slot0:com_registFightEvent(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, LuaEventSystem.Low)
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2, slot3)
	if slot3 == slot0.fightStepData then
		slot0:onDone(true)
	end
end

function slot0.sortTimelineDic(slot0, slot1, slot2)
	return slot1.count < slot2.count
end

function slot0.playTimeline(slot0)
	if slot0.played then
		return
	end

	slot0.played = true
	slot1 = {
		actId = 0,
		actEffect = {
			slot0.actEffectData
		},
		fromId = slot0.originFightStepData.fromId,
		toId = slot0.actEffectData.targetId,
		actType = FightEnum.ActType.SKILL,
		stepUid = FightTLEventEntityVisible.latestStepUid or 0
	}
	slot0.param.count = (slot0.param.count or 0) + 1
	slot3 = {}

	for slot7, slot8 in pairs(slot0.timelineDic) do
		table.insert(slot3, {
			count = slot7,
			timelineList = slot8
		})
	end

	table.sort(slot3, uv0.sortTimelineDic)

	slot4 = nil

	for slot8, slot9 in ipairs(slot3) do
		if slot2 <= slot9.count and #slot9.timelineList > 0 then
			slot4 = slot9.timelineList[math.random(1, #slot9.timelineList)]
		end
	end

	if not slot4 then
		slot0:onDone(true)

		return
	end

	if not FightHelper.getEntity("0") then
		slot0:onDone(true)

		return
	end

	slot0.fightStepData = slot1
	slot1.playerOperationCountForPlayEffectTimeline = slot2
	slot6 = slot5.skill:registTimelineWork(slot4, slot1)
	slot6.skipAfterTimelineFunc = true

	slot6:start()
end

return slot0
