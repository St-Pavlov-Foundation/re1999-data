module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2PrevSettleInfoMO", package.seeall)

slot0 = pureTable("WeekwalkVer2PrevSettleInfoMO")

function slot0.init(slot0, slot1)
	slot0.maxLayerId = slot1.maxLayerId
	slot0.maxBattleId = slot1.maxBattleId
	slot0.maxBattleIndex = slot1.maxBattleIndex
	slot0.show = slot1.show
	slot0.layerInfos = GameUtil.rpcInfosToMap(slot1.layerInfos, WeekwalkVer2PrevSettleLayerInfoMO, "layerIndex")
end

function slot0.getLayerPlatinumCupNum(slot0, slot1)
	return slot0.layerInfos[slot1] and slot2.platinumCupNum
end

function slot0.getTotalPlatinumCupNum(slot0)
	for slot5, slot6 in pairs(slot0.layerInfos) do
		slot1 = 0 + slot6.platinumCupNum
	end

	return slot1
end

return slot0
