module("modules.logic.fight.model.data.FightIndicatorInfoData", package.seeall)

slot0 = FightDataClass("FightIndicatorInfoData")

function slot0.onConstructor(slot0, slot1)
	slot0.inticatorId = slot1.inticatorId
	slot0.num = slot1.num
end

return slot0
