module("modules.logic.fight.fightcomponent.FightWorkParallelComponent", package.seeall)

slot0 = class("FightWorkParallelComponent", FightBaseClass)

function slot0.onConstructor(slot0)
	slot0.workParallel = {}
	slot0.callback = nil
	slot0.callbackHandle = nil
	slot0.finishCount = 0
end

function slot0.registFinishCallback(slot0, slot1, slot2)
	slot0.callback = slot1
	slot0.callbackHandle = slot2
end

function slot0.clearFinishCallback(slot0)
	slot0.callback = nil
	slot0.callbackHandle = nil
end

function slot0.addWork(slot0, slot1, slot2)
	slot0:addWorkList({
		slot1
	}, slot2)
end

function slot0.addWorkList(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		slot7:registFinishCallback(slot0._onWorkFinish, slot0)
		table.insert(slot0.workParallel, {
			work = slot7,
			context = slot2
		})
	end

	for slot6, slot7 in ipairs(slot1) do
		slot7:start(slot2)
	end
end

function slot0._onWorkFinish(slot0)
	slot0.finishCount = slot0.finishCount + 1

	if slot0.finishCount == #slot0.workParallel and slot0.callback then
		slot0.callback(slot0.callbackHandle)
	end
end

function slot0.onDestructor(slot0)
	for slot4 = #slot0.workParallel, 1, -1 do
		slot0.workParallel[slot4].work:disposeSelf()
	end

	slot0:clearFinishCallback()
end

return slot0
