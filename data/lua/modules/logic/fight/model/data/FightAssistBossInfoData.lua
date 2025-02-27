module("modules.logic.fight.model.data.FightAssistBossInfoData", package.seeall)

slot0 = FightDataClass("FightAssistBossInfoData")

function slot0.onConstructor(slot0, slot1)
	slot0.skills = {}

	for slot5, slot6 in ipairs(slot1.skills) do
		table.insert(slot0.skills, FightAssistBossSkillInfoData.new(slot6))
	end

	slot0.currCd = slot1.currCd
	slot0.cdCfg = slot1.cdCfg
	slot0.formId = slot1.formId
	slot0.roundUseLimit = slot1.roundUseLimit
	slot0.exceedUseFree = slot1.exceedUseFree
	slot0.params = slot1.params
end

return slot0
