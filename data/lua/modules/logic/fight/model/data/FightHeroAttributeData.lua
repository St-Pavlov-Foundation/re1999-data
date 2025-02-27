module("modules.logic.fight.model.data.FightHeroAttributeData", package.seeall)

slot0 = FightDataClass("FightHeroAttributeData")

function slot0.onConstructor(slot0, slot1)
	slot0.hp = slot1.hp
	slot0.attack = slot1.attack
	slot0.defense = slot1.defense
	slot0.mdefense = slot1.mdefense
	slot0.technic = slot1.technic
	slot0.multiHpIdx = slot1.multiHpIdx
	slot0.multiHpNum = slot1.multiHpNum
end

return slot0
