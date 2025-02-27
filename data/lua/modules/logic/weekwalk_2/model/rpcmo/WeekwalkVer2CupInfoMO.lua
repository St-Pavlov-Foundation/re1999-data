module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2CupInfoMO", package.seeall)

slot0 = pureTable("WeekwalkVer2CupInfoMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.result = slot1.result
	slot0.config = lua_weekwalk_ver2_cup.configDict[slot0.id]
	slot0.index = slot0.config.cupNo
end

return slot0
