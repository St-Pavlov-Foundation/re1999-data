module("modules.logic.fight.model.data.FightBloodPoolData", package.seeall)

slot0 = FightDataClass("FightBloodPoolData")

function slot0.onConstructor(slot0, slot1)
	slot0.value = slot1.value
	slot0.max = slot1.max
end

return slot0
