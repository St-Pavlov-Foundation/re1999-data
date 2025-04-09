module("modules.logic.fight.system.work.FightWorkEffectDamage", package.seeall)

slot0 = class("FightWorkEffectDamage", FightEffectBase)

function slot0.onStart(slot0)
	if FightHelper.getEntity(slot0.actEffectData.targetId) and slot0.actEffectData.effectNum > 0 then
		slot3 = slot1:isMySide() and -slot2 or slot2
		slot4 = slot0:getFloatType()

		if slot0.actEffectData.configEffect == 30006 then
			slot4 = FightEnum.FloatType.damage
		end

		FightFloatMgr.instance:float(slot1.id, slot4, slot3)

		if slot1.nameUI then
			slot1.nameUI:addHp(-slot2)
		end

		FightController.instance:dispatchEvent(FightEvent.OnHpChange, slot1, -slot2)
	end

	slot0:onDone(true)
end

function slot0.getFloatType(slot0)
	if FightHelper.isRestrain(slot0.fightStepData.fromId, slot0.actEffectData.targetId) then
		if slot0.actEffectData.effectType == FightEnum.EffectType.DAMAGE then
			return FightEnum.FloatType.restrain
		elseif slot0.actEffectData.effectType == FightEnum.EffectType.CRIT then
			return FightEnum.FloatType.crit_restrain
		end
	elseif slot0.actEffectData.effectType == FightEnum.EffectType.DAMAGE then
		return FightEnum.FloatType.damage
	elseif slot0.actEffectData.effectType == FightEnum.EffectType.CRIT then
		return FightEnum.FloatType.crit_damage
	end

	return FightEnum.FloatType.damage
end

return slot0
