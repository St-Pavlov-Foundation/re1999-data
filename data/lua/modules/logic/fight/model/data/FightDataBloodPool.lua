module("modules.logic.fight.model.data.FightDataBloodPool", package.seeall)

slot0 = FightDataClass("FightDataBloodPool")

function slot0.onConstructor(slot0, slot1)
	slot0.value = slot1 and slot1.value or 0
	slot0.max = slot1 and slot1.max or 0
end

function slot0.changeMaxValue(slot0, slot1)
	slot0.max = slot0.max + slot1
end

function slot0.changeValue(slot0, slot1)
	slot0.value = slot0.value + slot1
end

return slot0
