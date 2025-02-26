module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2PrevSettleInfoMO", package.seeall)

slot0 = pureTable("WeekwalkVer2PrevSettleInfoMO")

function slot0.init(slot0, slot1)
	slot0.maxLayerId = slot1.maxLayerId
	slot0.maxBattleId = slot1.maxBattleId
	slot0.show = slot1.show
	slot0.layerInfos = GameUtil.rpcInfosToMap(slot1.layerInfos, WeekwalkVer2PrevSettleLayerInfoMO, "layerIndex")
end

function slot0.getLayerPlatinumCupNum(slot0, slot1)
	return slot0.layerInfos[slot1] and slot2.platinumCupNum
end

return slot0
