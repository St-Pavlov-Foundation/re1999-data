module("modules.logic.fight.system.work.fightparamwork.FightParamChangeWork4", package.seeall)

slot0 = class("FightParamChangeWork4", FightParamWorkBase)

function slot0.onStart(slot0)
	FightController.instance:dispatchEvent(FightEvent.DoomsdayClock_OnAreaChange, slot0.currValue)
	slot0:com_registTimer(slot0._delayDone, FightDoomsdayClockView.RotateDuration)
end

return slot0
