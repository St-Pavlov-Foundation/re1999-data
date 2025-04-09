module("modules.logic.fight.mgr.FightBuffTypeId2EffectMgr", package.seeall)

slot0 = class("FightBuffTypeId2EffectMgr", FightBaseClass)

function slot0.onConstructor(slot0)
	slot0.effectDic = {}
	slot0.refCounter = {}

	slot0:com_registFightEvent(FightEvent.AddEntityBuff, slot0._onAddEntityBuff)
	slot0:com_registFightEvent(FightEvent.RemoveEntityBuff, slot0._onRemoveEntityBuff)
	slot0:com_registFightEvent(FightEvent.OnFightReconnectLastWork, slot0._onFightReconnectLastWork)
	slot0:com_registFightEvent(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart)
	slot0:com_registFightEvent(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish)
	slot0:com_registFightEvent(FightEvent.OnRoundSequenceFinish, slot0._onOnRoundSequenceFinish)
end

function slot0._isValid(slot0, slot1)
	if not lua_skill_buff.configDict[slot1] then
		return
	end

	if not lua_fight_buff_type_id_2_scene_effect.configDict[slot2.typeId] then
		return
	end

	return true, slot2
end

function slot0._onAddEntityBuff(slot0, slot1, slot2)
	slot3, slot4 = slot0:_isValid(slot2.buffId)

	if not slot3 then
		return
	end

	slot0:addBuff(slot1, slot4.typeId)
end

function slot0._onRemoveEntityBuff(slot0, slot1, slot2)
	slot3, slot4 = slot0:_isValid(slot2.buffId)

	if not slot3 then
		return
	end

	slot0:deleteBuff(slot4.typeId)
end

function slot0.addBuff(slot0, slot1, slot2)
	slot3 = (slot0.refCounter[slot2] or 0) + 1
	slot0.refCounter[slot2] = slot3

	if slot3 == 1 then
		slot0:addEffect(slot1, slot2)
	end
end

function slot0.deleteBuff(slot0, slot1)
	slot2 = (slot0.refCounter[slot1] or 0) - 1
	slot0.refCounter[slot1] = slot2

	if slot2 <= 0 then
		slot0:releaseEffect(slot1)
	end
end

function slot0.addEffect(slot0, slot1, slot2)
	if not FightHelper.getEntity(FightEntityScene.MySideId) then
		return
	end

	if not lua_fight_buff_type_id_2_scene_effect.configDict[slot2] then
		return
	end

	slot5 = slot4.effect

	if slot4.reverseX == 1 and FightDataHelper.entityMgr:getById(slot1) and slot8:isEnemySide() then
		slot7 = -(slot4.pos[1] or 0)
	end

	slot10 = slot3.effect:addGlobalEffect(slot5)

	slot10:setLocalPos(slot7, slot6[2] or 0, slot6[3] or 0)

	slot0.effectDic[slot2] = slot10
end

function slot0.releaseEffect(slot0, slot1)
	if not slot0.effectDic[slot1] then
		return
	end

	if not FightHelper.getEntity(FightEntityScene.MySideId) then
		return
	end

	slot3.effect:removeEffect(slot2)

	slot0.effectDic[slot1] = nil
end

function slot0._onFightReconnectLastWork(slot0)
	for slot5, slot6 in pairs(FightDataHelper.entityMgr:getAllEntityData()) do
		for slot11, slot12 in pairs(slot6:getBuffDic()) do
			slot0:_onAddEntityBuff(slot5, slot12)
		end
	end
end

function slot0._onSkillPlayStart(slot0, slot1, slot2)
	if slot1:getMO() and FightCardDataHelper.isBigSkill(slot2) then
		slot0:_hideEffect()
	end
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2)
	if slot1:getMO() and FightCardDataHelper.isBigSkill(slot2) then
		slot0:_showEffect()
	end
end

function slot0._hideEffect(slot0)
	for slot4, slot5 in pairs(slot0.effectDic) do
		slot5:setActive(false, "FightBuffTypeId2EffectMgr")
	end
end

function slot0._showEffect(slot0)
	for slot4, slot5 in pairs(slot0.effectDic) do
		slot5:setActive(true, "FightBuffTypeId2EffectMgr")
	end
end

function slot0._onOnRoundSequenceFinish(slot0)
	if tabletool.len(slot0.refCounter) <= 0 then
		return
	end

	slot1 = {}

	for slot6, slot7 in pairs(FightDataHelper.entityMgr:getAllEntityData()) do
		for slot12, slot13 in pairs(slot7:getBuffDic()) do
			if lua_skill_buff.configDict[slot13.buffId] and lua_fight_buff_type_id_2_scene_effect.configDict[slot14.typeId] then
				slot1[slot14.typeId] = (slot1[slot14.typeId] or 0) + 1
			end
		end
	end

	if FightDataUtil.findDiff(slot0.refCounter, slot1) then
		slot0:releaseAllEffect()

		slot0.refCounter = {}

		slot0:_onFightReconnectLastWork()
	end
end

function slot0.releaseAllEffect(slot0)
	for slot4, slot5 in pairs(slot0.effectDic) do
		slot0:releaseEffect(slot4)
	end
end

function slot0.onDestructor(slot0)
end

return slot0
