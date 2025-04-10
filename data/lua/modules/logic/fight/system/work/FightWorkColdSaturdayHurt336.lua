module("modules.logic.fight.system.work.FightWorkColdSaturdayHurt336", package.seeall)

slot0 = class("FightWorkColdSaturdayHurt336", FightEffectBase)

function slot0.onStart(slot0)
	slot2 = slot0.actEffectData.targetId
	slot3 = slot0.actEffectData.effectNum

	if not FightHelper.getEntity(slot0.actEffectData.reserveStr) then
		slot0:onDone(true)

		return
	end

	if not FightHelper.getEntity(slot2) then
		slot0:onDone(true)

		return
	end

	slot8 = FightStepData.New(FightDef_pb.FightStep())
	slot8.isFakeStep = true
	slot8.fromId = slot1
	slot8.toId = slot2
	slot8.actType = FightEnum.ActType.SKILL

	table.insert(slot8.actEffect, slot0.actEffectData)

	slot10 = {}

	for slot14, slot15 in pairs(lua_fight_she_fa_ignite.configDict[slot4:getMO().skin] or lua_fight_she_fa_ignite.configDict[0]) do
		table.insert(slot10, slot15)
	end

	table.sort(slot10, uv0.sortConfig)

	for slot14, slot15 in ipairs(slot10) do
		if slot3 <= slot15.layer then
			slot9 = slot15

			break
		end
	end

	slot0:playWorkAndDone(slot4.skill:registTimelineWork(slot9.timeline, slot8))
end

function slot0.sortConfig(slot0, slot1)
	return slot0.layer < slot1.layer
end

return slot0
