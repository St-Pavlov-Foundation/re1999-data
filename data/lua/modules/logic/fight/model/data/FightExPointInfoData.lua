module("modules.logic.fight.model.data.FightExPointInfoData", package.seeall)

slot0 = FightDataClass("FightExPointInfoData")

function slot0.onConstructor(slot0, slot1)
	slot0.uid = slot1.uid
	slot0.exPoint = slot1.exPoint
	slot0.powerInfos = {}

	for slot5, slot6 in ipairs(slot1.powerInfos) do
		table.insert(slot0.powerInfos, FightPowerInfoData.New(slot6))
	end

	slot0.currentHp = slot1.currentHp
end

return slot0
