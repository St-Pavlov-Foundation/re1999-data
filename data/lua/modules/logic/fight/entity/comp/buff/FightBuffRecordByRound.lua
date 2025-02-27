module("modules.logic.fight.entity.comp.buff.FightBuffRecordByRound", package.seeall)

slot0 = class("FightBuffRecordByRound")

function slot0.onBuffStart(slot0, slot1, slot2)
	slot0.entity = slot1

	FightController.instance:registerCallback(FightEvent.ALF_AddRecordCardData, slot0.onUpdateRecordCard, slot0)
	slot0:onUpdateRecordCard(slot2)
end

function slot0.onUpdateRecordCard(slot0, slot1)
	if slot0.entity.heroCustomComp and slot0.entity.heroCustomComp:getCustomComp() then
		slot4:setCacheRecordSkillList(FightStrUtil.instance:getSplitToNumberCache(slot1 and slot1.actCommonParams or "", "#"))
	end

	FightController.instance:dispatchEvent(FightEvent.ALF_AddRecordCardUI)
end

function slot0.onBuffEnd(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	FightController.instance:unregisterCallback(FightEvent.ALF_AddRecordCardData, slot0.onUpdateRecordCard, slot0)
end

function slot0.dispose(slot0)
	slot0:clear()
end

return slot0
