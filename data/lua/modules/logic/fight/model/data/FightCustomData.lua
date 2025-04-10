module("modules.logic.fight.model.data.FightCustomData", package.seeall)

slot0 = FightDataClass("FightCustomData")
slot0.CustomDataType = {
	Act191 = 3,
	WeekwalkVer2 = 2,
	Act183 = 1
}
slot1 = {
	[slot0.CustomDataType.Act183] = true,
	[slot0.CustomDataType.Act191] = true
}

function slot0.onConstructor(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0[slot6.type] = uv0[slot6.type] and cjson.decode(slot6.data) or slot6.data
	end
end

return slot0
