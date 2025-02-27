module("modules.logic.fight.system.work.FightWorkDeadlyPoisonContainer", package.seeall)

slot0 = class("FightWorkDeadlyPoisonContainer", FightStepEffectFlow)
slot0.existWrapDict = {}
slot0.targetDict = {}

function slot0.onStart(slot0)
	slot0.targetDict = {}

	for slot6, slot7 in ipairs(slot0._fightStepMO.actEffectMOs) do
		if not slot7:isDone() and slot0:getEffectType() == slot7.effectType then
			slot0:addEffectMo(slot7)
		end
	end

	tabletool.clear(uv0.existWrapDict)

	for slot6, slot7 in pairs(slot0.targetDict) do
		if FightHelper.getEntity(slot6) then
			for slot13, slot14 in pairs(slot7) do
				if slot14[1] > 0 then
					FightFloatMgr.instance:float(slot6, slot0:getFloatType(), slot8:isMySide() and -slot15 or slot15)

					if slot8.nameUI then
						slot8.nameUI:addHp(-slot15)
					end

					FightController.instance:dispatchEvent(FightEvent.OnHpChange, slot8, -slot15)

					if slot14[2] and not uv0.existWrapDict[slot6] then
						slot17, slot18 = slot0:getEffectRes()
						slot19 = slot8.effect:addHangEffect(slot17, slot18, nil, 1)

						FightRenderOrderMgr.instance:onAddEffectWrap(slot6, slot19)
						slot19:setLocalPos(0, 0, 0)

						uv0.existWrapDict[slot6] = true
					end
				end
			end
		end
	end

	slot0:onDone(true)
end

function slot0.getEffectRes(slot0)
	slot2 = slot0._fightStepMO.fromId and FightDataHelper.entityMgr:getById(slot1)
	slot3 = slot2 and slot2.skin
	slot5 = "v2a3_ddg/ddg_innate_02"
	slot6 = ModuleEnum.SpineHangPointRoot

	if slot3 and lua_fight_sp_effect_ddg.configDict[slot3] then
		slot5 = slot4.posionEffect
		slot6 = slot4.posionHang
	end

	return slot5, slot6
end

function slot0.addEffectMo(slot0, slot1)
	if not slot0.targetDict[slot1.targetId] then
		slot0.targetDict[slot2] = {}
	end

	if not slot3[tonumber(slot1.reserveId)] then
		slot3[slot4] = {
			slot1.effectNum,
			not string.nilorempty(slot1.reserveStr)
		}
	else
		slot6[1] = slot6[1] + slot1.effectNum
	end

	slot1:setDone()
end

function slot0.getEffectType(slot0)
	return FightEnum.EffectType.DEADLYPOISONORIGINDAMAGE
end

function slot0.getFloatType(slot0)
	return FightEnum.FloatType.damage_origin
end

return slot0
