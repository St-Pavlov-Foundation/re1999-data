module("modules.logic.fight.fightcomponent.FightWorkComponent", package.seeall)

slot0 = class("FightWorkComponent", FightBaseClass)

function slot0.onConstructor(slot0)
	slot0.workList = {}
end

function slot0.registWork(slot0, slot1, ...)
	slot2 = slot0:newClass(slot1, ...)

	table.insert(slot0.workList, slot2)
	slot2:registFinishCallback(slot0.onOneWorkFinish, slot0)

	return slot2
end

function slot0.playWork(slot0, slot1, ...)
	slot2 = slot0:newClass(slot1, ...)

	table.insert(slot0.workList, slot2)
	slot2:registFinishCallback(slot0.onOneWorkFinish, slot0)

	return slot2:start()
end

function slot0.addWork(slot0, slot1)
	table.insert(slot0.workList, slot1)
	slot1:registFinishCallback(slot0.onOneWorkFinish, slot0)

	return slot1
end

function slot0.onOneWorkFinish(slot0)
	slot0:com_registSingleTimer(slot0.clearDeadWork, 1)
end

function slot0.clearDeadWork(slot0)
	for slot4 = #slot0.workList, 1, -1 do
		if slot0.workList[slot4].IS_DISPOSED then
			table.remove(slot0.workList, slot4)
		end
	end
end

function slot0.getWorkList(slot0)
	return slot0.workList
end

function slot0.getAliveWorkList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.workList) do
		if not slot6.WORKFINISHED and not slot6.IS_DISPOSED then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.disposeAllWork(slot0)
	slot0:disposeObjectList(slot0.workList)
	slot0:onOneWorkFinish()
end

function slot0.onDestructor(slot0)
	slot0:disposeObjectList(slot0.workList)

	slot0.workList = nil
end

return slot0
