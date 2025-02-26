module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2PrevSettleLayerInfoMO", package.seeall)

slot0 = pureTable("WeekwalkVer2PrevSettleLayerInfoMO")

function slot0.init(slot0, slot1)
	slot0.layerId = slot1.layerId
	slot0.platinumCupNum = slot1.platinumCupNum
	slot0.layerIndex = lua_weekwalk_ver2.configDict[slot0.layerId] and slot2.layer or 0
end

return slot0
