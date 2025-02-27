module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2SettleBattleInfoMO", package.seeall)

slot0 = pureTable("WeekwalkVer2SettleBattleInfoMO")

function slot0.init(slot0, slot1)
	slot0.battleId = slot1.battleId
	slot0.cupInfos = GameUtil.rpcInfosToMap(slot1.cupInfos or {}, WeekwalkVer2CupInfoMO, "index")
end

return slot0
