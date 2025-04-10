module("modules.logic.fight.system.work.fightparamwork.FightParamWorkBase", package.seeall)

slot0 = class("FightParamWorkBase", FightWorkItem)

function slot0.onAwake(slot0, slot1, slot2, slot3, slot4)
	slot0.keyId = slot1
	slot0.oldValue = slot2
	slot0.currValue = slot3
	slot0.offset = slot4
end

function slot0.onStart(slot0)
	slot0:onDone(true)
end

return slot0
