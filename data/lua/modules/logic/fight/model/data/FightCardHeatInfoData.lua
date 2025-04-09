module("modules.logic.fight.model.data.FightCardHeatInfoData", package.seeall)

slot0 = FightDataClass("FightCardHeatInfoData")

function slot0.onConstructor(slot0, slot1)
	slot0.values = {}

	for slot5, slot6 in ipairs(slot1.values) do
		table.insert(slot0.values, FightCardHeatValueData.New(slot6))
	end
end

return slot0
