module("modules.logic.fight.system.work.FightWorkFightParamChange330", package.seeall)

slot0 = class("FightWorkFightParamChange330", FightEffectBase)
slot0.tempWorkKeyDict = {}

function slot0.onStart(slot0)
	slot0.sequenceFlow = slot0:com_registWorkDoneFlowSequence()
	slot0.param = FightDataHelper.fieldMgr.param

	tabletool.clear(uv0.tempWorkKeyDict)

	for slot6, slot7 in ipairs(GameUtil.splitString2(slot0.actEffectData.reserveStr, true)) do
		slot8 = slot7[1]
		slot11 = slot0.param[slot8] - slot7[2]

		if not (uv0.Param2WorkKey[slot8] and slot2[slot12]) then
			if slot12 then
				slot2[slot12] = true
			end

			if uv0.Key2Work[slot8] then
				slot0.sequenceFlow:registWork(slot14, slot8, slot11, slot10, slot9)
			else
				slot0.sequenceFlow:registWork(FightWorkSendEvent, FightEvent.UpdateFightParam, slot8, slot11, slot10, slot9)
			end
		end
	end

	slot0.sequenceFlow:start()
end

slot0.Key2Work = {
	[FightParamData.ParamKey.DoomsdayClock_Value] = FightParamChangeWork3,
	[FightParamData.ParamKey.DoomsdayClock_Range1] = FightParamChangeWork4,
	[FightParamData.ParamKey.DoomsdayClock_Range2] = FightParamChangeWork4,
	[FightParamData.ParamKey.DoomsdayClock_Range3] = FightParamChangeWork4,
	[FightParamData.ParamKey.DoomsdayClock_Range4] = FightParamChangeWork4,
	[FightParamData.ParamKey.DoomsdayClock_Offset] = FightParamChangeWork4,
	[FightParamData.ParamKey.ACT191_MIN_HP_RATE] = FightParamChangeWork9
}
slot1 = 0
slot0.WorkKey = {
	DoomsDayClockAreaChangeKey = function ()
		uv0 = uv0 + 1

		return uv0
	end()
}
slot0.Param2WorkKey = {
	[FightParamData.ParamKey.DoomsdayClock_Range1] = slot0.WorkKey.DoomsDayClockAreaChangeKey,
	[FightParamData.ParamKey.DoomsdayClock_Range2] = slot0.WorkKey.DoomsDayClockAreaChangeKey,
	[FightParamData.ParamKey.DoomsdayClock_Range3] = slot0.WorkKey.DoomsDayClockAreaChangeKey,
	[FightParamData.ParamKey.DoomsdayClock_Range4] = slot0.WorkKey.DoomsDayClockAreaChangeKey,
	[FightParamData.ParamKey.DoomsdayClock_Offset] = slot0.WorkKey.DoomsDayClockAreaChangeKey
}

return slot0
