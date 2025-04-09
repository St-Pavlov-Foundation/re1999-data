module("modules.logic.fight.entity.comp.skill.FightTLEventPlayServerEffect", package.seeall)

slot0 = class("FightTLEventPlayServerEffect", FightTimelineTrackItem)

function slot0.onTrackStart(slot0, slot1, slot2, slot3)
	slot0._list = {}
	slot0.fightStepData = slot1

	if slot3[1] == "1" then
		slot0:_playEffect(FightEnum.EffectType.SUMMONEDDELETE)
	end

	if slot3[2] == "1" then
		slot0:_playEffect(FightEnum.EffectType.MAGICCIRCLEDELETE)
	end

	if slot3[3] == "1" then
		slot0:_playEffect(FightEnum.EffectType.MAGICCIRCLEADD)
	end

	if slot3[4] == "1" then
		slot0:_playEffect(FightEnum.EffectType.MOVE)
	end

	if slot3[5] == "1" then
		slot0:_playEffect(FightEnum.EffectType.MOVEFRONT)
	end

	if slot3[6] == "1" then
		slot0:_playEffect(FightEnum.EffectType.MOVEBACK)
	end

	if slot3[7] == "1" then
		slot0:_playEffect(FightEnum.EffectType.AVERAGELIFE)
	end

	if slot3[8] == "1" then
		slot0:_playEffect(FightEnum.EffectType.BUFFADD)
	end

	if slot3[9] == "1" then
		slot0:_playEffect(FightEnum.EffectType.BUFFDEL)
	end

	if not string.nilorempty(slot3[10]) then
		for slot7, slot8 in ipairs(slot0.fightStepData.actEffect) do
			if slot8.effectType == FightEnum.EffectType.BUFFADD and lua_skill_buff.configDict[slot8.buff.buddId] and lua_skill_bufftype.configDict[slot10.typeId] and slot11.type == tonumber(slot3[10]) then
				slot12 = FightWork2Work.New(FightStepBuilder.ActEffectWorkCls[FightEnum.EffectType.BUFFADD], slot0.fightStepData, slot8)

				slot12:onStart()
				table.insert(slot0._list, slot12)
			end
		end
	end

	if not string.nilorempty(slot3[11]) then
		for slot7, slot8 in ipairs(slot0.fightStepData.actEffect) do
			if slot8.effectType == FightEnum.EffectType.BUFFDEL and lua_skill_buff.configDict[slot8.buff.buddId] and lua_skill_bufftype.configDict[slot10.typeId] and slot11.type == tonumber(slot3[11]) then
				slot12 = FightWork2Work.New(FightStepBuilder.ActEffectWorkCls[FightEnum.EffectType.BUFFDEL], slot0.fightStepData, slot8)

				slot12:onStart()
				table.insert(slot0._list, slot12)
			end
		end
	end
end

function slot0._playEffect(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.fightStepData.actEffect) do
		if slot6.effectType == slot1 then
			slot7 = FightWork2Work.New(FightStepBuilder.ActEffectWorkCls[slot1], slot0.fightStepData, slot6)

			slot7:onStart()
			table.insert(slot0._list, slot7)
		end
	end
end

function slot0.onTrackEnd(slot0)
end

function slot0.onDestructor(slot0)
	if slot0._list then
		for slot4, slot5 in ipairs(slot0._list) do
			slot5:onStop()
		end

		slot0._list = nil
	end
end

return slot0
