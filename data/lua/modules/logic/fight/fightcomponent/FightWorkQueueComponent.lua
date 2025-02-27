module("modules.logic.fight.fightcomponent.FightWorkQueueComponent", package.seeall)

slot0 = class("FightWorkQueueComponent", FightBaseClass)

function slot0.onConstructor(slot0)
	slot0.workQueue = {}
	slot0.callback = nil
	slot0.callbackHandle = nil
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
	slot3 = false

	if #slot0.workQueue == 0 then
		slot3 = true
	end

	for slot7, slot8 in ipairs(slot1) do
		slot8:registFinishCallback(slot0._onWorkFinish, slot0)
		table.insert(slot0.workQueue, {
			work = slot8,
			context = slot2
		})
	end

	if slot3 then
		slot0:_onWorkFinish()
	end
end

function slot0._onWorkFinish(slot0)
	if table.remove(slot0.workQueue, 1) then
		return slot2.work:start(slot2.context)
	elseif slot0.callback then
		slot0.callback(slot0.callbackHandle)
	end
end

function slot0.onDestructor(slot0)
	for slot4 = #slot0.workQueue, 1, -1 do
		slot0.workQueue[slot4].work:disposeSelf()
	end

	slot0:clearFinishCallback()
end

return slot0
