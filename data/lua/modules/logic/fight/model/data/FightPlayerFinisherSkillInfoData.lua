module("modules.logic.fight.model.data.FightPlayerFinisherSkillInfoData", package.seeall)

slot0 = FightDataClass("FightPlayerFinisherSkillInfoData")

function slot0.onConstructor(slot0, slot1)
	slot0.skillId = slot1.skillId
	slot0.needPower = slot1.needPower
end

return slot0
