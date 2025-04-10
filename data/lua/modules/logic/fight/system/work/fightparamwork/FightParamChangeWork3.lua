module("modules.logic.fight.system.work.fightparamwork.FightParamChangeWork3", package.seeall)

slot0 = class("FightParamChangeWork3", FightParamWorkBase)

function slot0.onStart(slot0)
	FightController.instance:dispatchEvent(FightEvent.DoomsdayClock_OnValueChange, slot0.oldValue, slot0.currValue, slot0.offset)
	slot0:com_registTimer(slot0._delayDone, FightDoomsdayClockView.ZhiZhenTweenDuration)
end

return slot0
