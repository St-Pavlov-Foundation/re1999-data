module("modules.logic.fight.model.data.FightTaskData", package.seeall)

slot0 = FightDataClass("FightTaskData")

function slot0.onConstructor(slot0, slot1)
	slot0.taskId = slot1.taskId
	slot0.status = slot1.status
	slot0.values = {}

	for slot5, slot6 in ipairs(slot1.values) do
		table.insert(slot0.values, FightTaskValueData.New(slot6))
	end
end

return slot0
