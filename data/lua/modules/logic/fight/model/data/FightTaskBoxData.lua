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
		slot0.tasks[slot6.taskId] = slot0:newTask(slot6)
	end
end

function slot0.newTask(slot0, slot1)
	slot3 = {
		taskId = slot1.taskId,
		status = slot1.status,
		values = {}
	}

	for slot7, slot8 in ipairs(slot1.values) do
		table.insert(slot3.values, {
			index = slot8.index,
			progress = slot8.progress,
			maxProgress = slot8.maxProgress,
			finished = slot8.finished
		})
	end

	return slot3
end

return slot0
