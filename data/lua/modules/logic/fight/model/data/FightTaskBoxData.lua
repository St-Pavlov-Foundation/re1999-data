module("modules.logic.fight.model.data.FightTaskBoxData", package.seeall)

slot0 = FightDataClass("FightTaskBoxData")
slot0.TaskStatus = {
	Finished = 3,
	Running = 2,
	Init = 1
}

function slot0.onConstructor(slot0, slot1)
	slot0.tasks = {}

	for slot5, slot6 in ipairs(slot1.tasks) do
		slot0.tasks[slot6.taskId] = FightTaskData.New(slot6)
	end
end

return slot0
