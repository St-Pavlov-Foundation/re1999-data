module("modules.logic.fight.entity.comp.specialeffect.FightEntityCustomSpecialEffect", package.seeall)

slot0 = class("FightEntityCustomSpecialEffect", FightEntitySpecialEffectBase)

function slot0.initClass(slot0)
	for slot5, slot6 in pairs(FightDataHelper.entityMgr:getAllEntityMO()) do
		if slot6.modelId == 3079 then
			slot0:newClass(FightEntitySpecialEffect3079_Buff)

			break
		end
	end

	slot0:newClass(FightEntitySpecialEffect3070_Ball)
	slot0:newClass(FightEntitySpecialEffectBuffLayer)
	slot0:newClass(FightEntitySpecialEffect3081_Ball)
	slot0:newClass(FightEntitySpecialEffectSeasonChangeHero)
	slot0:newClass(FightEntitySpecialEffectBuffLayerNaNa)
end

return slot0
