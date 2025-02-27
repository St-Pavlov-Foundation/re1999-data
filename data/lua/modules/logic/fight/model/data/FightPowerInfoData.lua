module("modules.logic.fight.model.data.FightPowerInfoData", package.seeall)

slot0 = FightDataClass("FightPowerInfoData")

function slot0.onConstructor(slot0, slot1)
	slot0.powerId = slot1.powerId
	slot0.num = slot1.num
	slot0.max = slot1.max
end

return slot0
