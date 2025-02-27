module("modules.logic.versionactivity2_6.dicehero.model.fight.DiceHeroFightDiceMo", package.seeall)

slot0 = pureTable("DiceHeroFightDiceMo")

function slot0.init(slot0, slot1, slot2)
	slot0.index = slot2
	slot0.uid = slot1.uid
	slot0.status = slot1.status
	slot0.suitId = slot1.suitId
	slot0.num = slot1.num
	slot0.diceId = slot1.diceId
	slot0.deleted = slot1.deleted
end

return slot0
