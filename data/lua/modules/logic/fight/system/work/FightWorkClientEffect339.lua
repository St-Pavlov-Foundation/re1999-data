module("modules.logic.fight.system.work.FightWorkClientEffect339", package.seeall)

slot0 = class("FightWorkClientEffect339", FightEffectBase)

function slot0.onStart(slot0)
	if not slot0["clientEffect" .. slot0.actEffectData.effectNum] then
		if isDebugBuild then
			logError("客户端未处理表现 ： " .. tostring(slot1))
		end

		return slot0:onDone(true)
	end

	slot0:com_registWorkDoneFlowSequence():registWork(Work2FightWork, FunctionWork, slot2, slot0)

	if uv0.ClientEffectWaitTime[slot1] then
		slot3:registWork(Work2FightWork, TimerWork, slot4)
	end

	slot3:start()
end

function slot0.clientEffect1(slot0)
	FightController.instance:dispatchEvent(FightEvent.DoomsdayClock_OnBroken)
end

function slot0.clientEffect2(slot0)
	FightController.instance:dispatchEvent(FightEvent.DoomsdayClock_OnClear)
end

slot0.ClientEffectEnum = {
	DoomsdayClock = 1,
	DoomsdayClockClear = 2
}
slot0.ClientEffectWaitTime = {
	[slot0.ClientEffectEnum.DoomsdayClock] = 0.5,
	[slot0.ClientEffectEnum.DoomsdayClockClear] = 0.2
}

return slot0
