module("modules.logic.fight.model.data.FightEmitterInfoData", package.seeall)

slot0 = FightDataClass("FightEmitterInfoData")

function slot0.onConstructor(slot0, slot1)
	slot0.energy = slot1.energy
end

return slot0
