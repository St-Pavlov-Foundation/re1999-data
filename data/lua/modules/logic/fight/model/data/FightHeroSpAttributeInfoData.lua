module("modules.logic.fight.model.data.FightHeroSpAttributeInfoData", package.seeall)

slot0 = FightDataClass("FightHeroSpAttributeInfoData")

function slot0.onConstructor(slot0, slot1)
	slot0.uid = slot1.uid
	slot0.attribute = FightHeroSpAttributeData.New(slot1.attribute)
end

return slot0
