module("modules.logic.fight.system.work.FightWorkStepBuff", package.seeall)

slot0 = class("FightWorkStepBuff", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0._buffUid = slot0.actEffectData.buff and slot1.uid
	slot0._buffId = slot1 and slot1.buffId
	slot0._entityId = slot0.actEffectData.targetId
	slot0._entityMO = FightDataHelper.entityMgr:getById(slot0._entityId)

	if not slot0._entityMO then
		return
	end

	slot0._oldBuffMO = FightHelper.deepCopySimpleWithMeta(slot0._entityMO:getBuffMO(slot0._buffUid))
end

function slot0.onStart(slot0)
	if not slot0._entityMO then
		slot0:onDone(true)

		return
	end

	if not FightHelper.getEntity(slot0._entityId) then
		slot0:onDone(true)

		return
	end

	if not slot1.buff then
		slot0:onDone(true)

		return
	end

	uv0.canPlayDormantBuffAni = FightBuffHelper.canPlayDormantBuffAni(slot0.actEffectData, slot0.fightStepData)

	if slot0.actEffectData.effectType == FightEnum.EffectType.BUFFADD or slot2 == FightEnum.EffectType.BUFFUPDATE then
		slot0._newBuffMO = slot0._entityMO:getBuffMO(slot0._buffUid)

		if not slot0._newBuffMO then
			slot0:onDone(true)

			return
		end
	end

	if slot2 == FightEnum.EffectType.BUFFADD then
		slot1.buff:addBuff(slot0._newBuffMO, false, slot0.fightStepData.stepUid)
	elseif slot2 == FightEnum.EffectType.BUFFDEL or slot2 == FightEnum.EffectType.BUFFDELNOEFFECT then
		slot1.buff:delBuff(slot0._buffUid)
	elseif slot2 == FightEnum.EffectType.BUFFUPDATE then
		slot1.buff:updateBuff(slot0._newBuffMO, slot0._oldBuffMO or slot0._newBuffMO, slot0.actEffectData)
	end

	FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, slot0._entityId, slot2, slot0._buffId, slot0._buffUid, slot0.actEffectData.configEffect, slot0.actEffectData.buff)

	if uv0.canPlayDormantBuffAni then
		slot0:com_registTimer(slot0._delayDone, 2 / FightModel.instance:getSpeed())

		return
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
