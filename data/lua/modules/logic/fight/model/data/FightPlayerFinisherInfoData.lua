module("modules.logic.fight.model.data.FightPlayerFinisherInfoData", package.seeall)

slot0 = FightDataClass("FightPlayerFinisherInfoData")

function slot0.onConstructor(slot0, slot1)
	slot0.skills = {}

	for slot5, slot6 in ipairs(slot1.skills) do
		table.insert(slot0.skills, FightPlayerFinisherSkillInfoData.new(slot6))
	end

	slot0.roundUseLimit = slot1.roundUseLimit
end

return slot0
