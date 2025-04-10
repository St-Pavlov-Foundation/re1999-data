module("modules.logic.fight.system.work.fightparamwork.FightParamChangeWork9", package.seeall)

slot0 = class("FightParamChangeWork9", FightParamWorkBase)

function slot0.onStart(slot0)
	FightController.instance:dispatchEvent(FightEvent.UpdateFightParam, slot0.keyId, slot0.oldValue, slot0.currValue, slot0.offset)
	slot0:onDone(true)
end

return slot0
