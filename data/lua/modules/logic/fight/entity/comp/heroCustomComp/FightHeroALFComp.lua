module("modules.logic.fight.entity.comp.heroCustomComp.FightHeroALFComp", package.seeall)

slot0 = class("FightHeroALFComp", FightHeroCustomCompBase)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0.alfTimeLineCo = lua_fight_sp_effect_alf_timeline.configDict[slot0.entity:getMO().skin]

	if not slot0.alfTimeLineCo then
		logError("阿莱夫插牌timeline未配置，skinId : " .. tostring(slot2.skin))
	end
end

function slot0.addEventListeners(slot0)
	FightController.instance:registerCallback(FightEvent.AfterAddUseCardContainer, slot0.onAfterAddUseCardOnContainer, slot0)
end

function slot0.removeEventListeners(slot0)
	FightController.instance:unregisterCallback(FightEvent.AfterAddUseCardContainer, slot0.onAfterAddUseCardOnContainer, slot0)
end

slot0.ALFSkillDict = {
	[31130152.0] = true,
	[31130153.0] = true,
	[31130154.0] = true,
	[31130151.0] = true
}
slot0.CardAddEffect = "ui/viewres/fight/card_alf.prefab"

function slot0.onAfterAddUseCardOnContainer(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot0.alfTimeLineCo then
		return
	end

	slot4 = 0

	for slot8, slot9 in ipairs(slot1.actEffectMOs) do
		if slot9.effectType == FightEnum.EffectType.ADDUSECARD and uv0.ALFSkillDict[slot9.effectNum1] then
			slot2 = 0 + 1
			slot4 = slot9.effectNum1
		end
	end

	slot5 = nil

	if slot2 == 2 then
		slot5 = slot0.alfTimeLineCo.timeline_2
	elseif slot2 == 3 then
		slot5 = slot0.alfTimeLineCo.timeline_3
	elseif slot2 == 4 then
		slot5 = slot0.alfTimeLineCo.timeline_4
	end

	if string.nilorempty(slot5) then
		return
	end

	slot1.fromId = slot0.entity.id
	slot1.actId = slot4

	slot0.entity.skill:playTimeline(slot5, slot1)
end

function slot0.setCacheRecordSkillList(slot0, slot1)
	slot0.cacheSkillList = slot1
end

function slot0.getCacheSkillList(slot0)
	return slot0.cacheSkillList
end

return slot0
