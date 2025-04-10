module("modules.logic.fight.model.data.FightParamData", package.seeall)

slot0 = FightDataClass("FightParamData")
slot0.ParamKey = {
	ProgressId = 2,
	DoomsdayClock_Range1 = 4,
	ACT191_CUR_HP_RATE = 12,
	DoomsdayClock_Range4 = 7,
	ACT191_HUNTING = 10,
	DoomsdayClock_Range3 = 6,
	ACT191_MIN_HP_RATE = 9,
	ACT191_COIN = 11,
	DoomsdayClock_Offset = 8,
	ProgressSkill = 1,
	DoomsdayClock_Value = 3,
	DoomsdayClock_Range2 = 5
}

function slot0.onConstructor(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0[slot6.key] = slot6.value
	end
end

function slot0.getKey(slot0, slot1)
	return slot0[slot1]
end

function slot0.isInit(slot0, slot1)
	return slot0.initDict[slot1]
end

function slot0.setInit(slot0, slot1)
end

return slot0
