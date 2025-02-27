module("modules.logic.fight.model.data.FightAssistBossSkillInfoData", package.seeall)

slot0 = FightDataClass("FightAssistBossSkillInfoData")

function slot0.onConstructor(slot0, slot1)
	slot0.skillId = slot1.skillId
	slot0.needPower = slot1.needPower
	slot0.powerLow = slot1.powerLow
	slot0.powerHigh = slot1.powerHigh
end

return slot0
