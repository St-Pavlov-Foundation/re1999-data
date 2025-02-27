module("modules.logic.fight.model.data.FightSummonedInfoData", package.seeall)

slot0 = FightDataClass("FightSummonedInfoData")

function slot0.onConstructor(slot0, slot1)
	slot0.summonedId = slot1.summonedId
	slot0.level = slot1.level
	slot0.uid = slot1.uid
	slot0.fromUid = slot1.fromUid
end

return slot0
