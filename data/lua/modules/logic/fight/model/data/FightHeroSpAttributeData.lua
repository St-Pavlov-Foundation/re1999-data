module("modules.logic.fight.model.data.FightHeroSpAttributeData", package.seeall)

slot0 = FightDataClass("FightHeroSpAttributeData")

function slot0.onConstructor(slot0, slot1)
	slot0.revive = slot1.revive
	slot0.heal = slot1.heal
	slot0.absorb = slot1.absorb
	slot0.defenseIgnore = slot1.defenseIgnore
	slot0.clutch = slot1.clutch
	slot0.finalAddDmg = slot1.finalAddDmg
	slot0.finalDropDmg = slot1.finalDropDmg
	slot0.normalSkillRate = slot1.normalSkillRate
	slot0.playAddRate = slot1.playAddRate
	slot0.playDropRate = slot1.playDropRate
	slot0.dizzyResistances = slot1.dizzyResistances
	slot0.sleepResistances = slot1.sleepResistances
	slot0.petrifiedResistances = slot1.petrifiedResistances
	slot0.frozenResistances = slot1.frozenResistances
	slot0.disarmResistances = slot1.disarmResistances
	slot0.forbidResistances = slot1.forbidResistances
	slot0.sealResistances = slot1.sealResistances
	slot0.cantGetExskillResistances = slot1.cantGetExskillResistances
	slot0.delExPointResistances = slot1.delExPointResistances
	slot0.stressUpResistances = slot1.stressUpResistances
	slot0.controlResilience = slot1.controlResilience
	slot0.delExPointResilience = slot1.delExPointResilience
	slot0.stressUpResilience = slot1.stressUpResilience
	slot0.charmResistances = slot1.charmResistances
	slot0.reboundDmg = slot1.reboundDmg
	slot0.extraDmg = slot1.extraDmg
	slot0.reuseDmg = slot1.reuseDmg
	slot0.bigSkillRate = slot1.bigSkillRate
end

return slot0
