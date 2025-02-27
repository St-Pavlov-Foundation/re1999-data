module("modules.logic.fight.model.data.FightEnhanceInfoBoxData", package.seeall)

slot0 = FightDataClass("FightEnhanceInfoBoxData")

function slot0.onConstructor(slot0, slot1)
	slot0.uid = slot1.uid
	slot0.canUpgradeIds = {}
	slot0.upgradedOptions = {}

	for slot5, slot6 in ipairs(slot1.canUpgradeIds) do
		slot0.canUpgradeIds[slot6] = slot6
	end

	for slot5, slot6 in ipairs(slot1.upgradedOptions) do
		slot0.upgradedOptions[slot6] = slot6
	end
end

return slot0
