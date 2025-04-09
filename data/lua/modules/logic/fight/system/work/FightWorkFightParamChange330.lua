module("modules.logic.fight.system.work.FightWorkFightParamChange330", package.seeall)

slot0 = class("FightWorkFightParamChange330", FightEffectBase)

function slot0.onStart(slot0)
	slot0.sequenceFlow = slot0:com_registWorkDoneFlowSequence()
	slot0.param = FightDataHelper.fieldMgr.param

	for slot5, slot6 in ipairs(GameUtil.splitString2(slot0.actEffectData.reserveStr, true)) do
		slot7 = slot6[1]

		if slot0["processIdFunc" .. slot7] then
			slot11(slot0, slot7, slot0.param[slot7] - slot6[2], slot9, slot8)
		else
			slot0.sequenceFlow:registWork(FightWorkSendEvent, FightEvent.UpdateFightParam, slot7, slot10, slot9, slot8)
		end
	end

	slot0.sequenceFlow:start()
end

function slot0.processIdFunc3(slot0, slot1, slot2, slot3, slot4)
	FightController.instance:dispatchEvent(FightEvent.DoomsdayClock_OnValueChange, slot2, slot3, slot4)
end

function slot0.processIdFunc4(slot0, slot1, slot2, slot3, slot4)
	FightController.instance:dispatchEvent(FightEvent.DoomsdayClock_OnAreaChange, slot3)
end

function slot0.processIdFunc5(slot0, slot1, slot2, slot3, slot4)
	FightController.instance:dispatchEvent(FightEvent.DoomsdayClock_OnAreaChange, slot3)
end

function slot0.processIdFunc6(slot0, slot1, slot2, slot3, slot4)
	FightController.instance:dispatchEvent(FightEvent.DoomsdayClock_OnAreaChange, slot3)
end

function slot0.processIdFunc7(slot0, slot1, slot2, slot3, slot4)
	FightController.instance:dispatchEvent(FightEvent.DoomsdayClock_OnAreaChange, slot3)
end

function slot0.processIdFunc8(slot0, slot1, slot2, slot3, slot4)
	FightController.instance:dispatchEvent(FightEvent.DoomsdayClock_OnAreaChange, slot3)
end

function slot0.processIdFunc9(slot0, slot1, slot2, slot3, slot4)
	FightController.instance:dispatchEvent(FightEvent.UpdateFightParam, slot1, slot2, slot3, slot4)
end

function slot0.clearWork(slot0)
end

return slot0
