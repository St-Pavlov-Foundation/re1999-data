module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2SettleHeroInfoMO", package.seeall)

slot0 = pureTable("WeekwalkVer2SettleHeroInfoMO")

function slot0.init(slot0, slot1)
	slot0.heroId = slot1.heroId
	slot0.allHarm = slot1.allHarm
	slot0.singleHighHarm = slot1.singleHighHarm
	slot0.allHurt = slot1.allHurt
	slot0.allHeal = slot1.allHeal
	slot0.allHealed = slot1.allHealed
	slot0.battleNum = slot1.battleNum
end

return slot0
