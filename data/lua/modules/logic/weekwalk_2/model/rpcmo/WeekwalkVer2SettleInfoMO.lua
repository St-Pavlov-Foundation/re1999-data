module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2SettleInfoMO", package.seeall)

slot0 = pureTable("WeekwalkVer2SettleInfoMO")

function slot0.init(slot0, slot1)
	slot0.harmHero = WeekwalkVer2SettleHeroInfoMO.New()

	slot0.harmHero:init(slot1.harmHero)

	slot0.healHero = WeekwalkVer2SettleHeroInfoMO.New()

	slot0.healHero:init(slot1.healHero)

	slot0.hurtHero = WeekwalkVer2SettleHeroInfoMO.New()

	slot0.hurtHero:init(slot1.hurtHero)

	slot0.layerInfos = GameUtil.rpcInfosToMap(slot1.layerInfos, WeekwalkVer2SettleLayerInfoMO, "layerId")
end

return slot0
