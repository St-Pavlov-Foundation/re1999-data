module("modules.logic.fight.model.data.FightBuffInfoData", package.seeall)

slot0 = FightDataClass("FightBuffInfoData")

function slot0.onConstructor(slot0, slot1)
	slot0.buffId = slot1.buffId
	slot0.duration = slot1.duration
	slot0.uid = slot1.uid
	slot0.exInfo = slot1.exInfo
	slot0.fromUid = slot1.fromUid
	slot0.count = slot1.count
	slot0.actCommonParams = slot1.actCommonParams
	slot0.layer = slot1.layer
	slot0.type = slot1.type
end

return slot0
