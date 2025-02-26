module("modules.logic.fight.entity.comp.buff.FightBuffSubBuff", package.seeall)

slot0 = class("FightBuffSubBuff")

function slot0.onBuffStart(slot0, slot1, slot2)
	slot0.entity = slot1
	slot0.entityId = slot1.id
	slot0.existCount = 0
	slot0.effectList = {}

	FightController.instance:registerCallback(FightEvent.ASFD_PullOut, slot0.pullOutAllEffect, slot0)
	slot0:tryCreateALFResidualEffect(slot2)
end

function slot0.onBuffUpdate(slot0, slot1)
	slot0:tryCreateALFResidualEffect(slot1)
end

function slot0.tryCreateALFResidualEffect(slot0, slot1)
	while slot0.existCount < slot1.layer do
		slot3 = nil
		slot3 = (not FightDataHelper.ASFDDataMgr:popEntityResidualData(slot0.entityId) or not slot2.missileRes or lua_fight_sp_effect_alf.configDict[slot2.missileRes]) and FightHeroSpEffectConfig.instance:getRandomAlfASFDMissileRes()

		if not string.nilorempty(slot3 and slot3.residualRes) then
			slot5 = slot0.entity.effect:addHangEffect(slot4, ModuleEnum.SpineHangPoint.mountbody)

			FightRenderOrderMgr.instance:addEffectWrapByOrder(slot0.entityId, slot5, FightRenderOrderMgr.MaxOrder)
			slot5:setLocalPos(0, 0, 0)

			slot6 = slot2 and slot2.startPos
			slot7 = slot2 and slot2.endPos
			slot8 = nil
			slot8 = (not slot6 or not slot7 or FightASFDHelper.getZRotation(slot6.x, slot6.y, slot7.x, slot7.y)) and math.random(-30, 30)

			transformhelper.setLocalRotation(slot5.containerGO.transform, 0, 0, slot8)
			table.insert(slot0.effectList, {
				slot5,
				slot3,
				slot8
			})
		end

		slot0.existCount = slot0.existCount + 1
	end
end

function slot0.pullOutAllEffect(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.effectList) do
		slot7 = slot6[1]
		slot8 = slot6[2]
		slot9 = slot6[3]

		if slot0.entity then
			slot0.entity.effect:removeEffect(slot7)
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0.entityId, slot7)

		if slot8 then
			slot10 = slot0.entity.effect:addHangEffect(slot8.pullOutRes, ModuleEnum.SpineHangPoint.mountbody, nil, 1)

			slot10:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:addEffectWrapByOrder(slot0.entityId, slot10, FightRenderOrderMgr.MaxOrder)
			transformhelper.setLocalRotation(slot10.containerGO.transform, 0, 0, slot9)
			slot0:playAudio(slot8.audioId)
		end
	end

	tabletool.clear(slot0.effectList)
end

function slot0.playAudio(slot0, slot1)
	if not slot1 then
		return
	end

	if slot1 ~= 0 then
		AudioMgr.instance:trigger(slot1)
	end
end

function slot0.clear(slot0)
	slot4 = FightEvent.ASFD_PullOut
	slot5 = slot0.pullOutAllEffect

	FightController.instance:unregisterCallback(slot4, slot5, slot0)

	for slot4, slot5 in ipairs(slot0.effectList) do
		slot6 = slot5[1]

		if slot0.entity then
			slot0.entity.effect:removeEffect(slot6)
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0.entityId, slot6)
	end
end

function slot0.onBuffEnd(slot0)
	slot0:clear()
end

function slot0.dispose(slot0)
	slot0:clear()
end

return slot0
