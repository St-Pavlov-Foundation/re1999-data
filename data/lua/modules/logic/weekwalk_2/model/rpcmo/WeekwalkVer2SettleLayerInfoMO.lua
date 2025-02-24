module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2SettleLayerInfoMO", package.seeall)

slot0 = pureTable("WeekwalkVer2SettleLayerInfoMO")

function slot0.init(slot0, slot1)
	slot0.layerId = slot1.layerId
	slot0.battleInfos = GameUtil.rpcInfosToMap(slot1.battleInfos, WeekwalkVer2SettleBattleInfoMO, "battleId")
	slot0.config = lua_weekwalk_ver2.configDict[slot0.layerId]
	slot0.sceneConfig = lua_weekwalk_ver2_scene.configDict[slot0.config.sceneId]
end

return slot0
