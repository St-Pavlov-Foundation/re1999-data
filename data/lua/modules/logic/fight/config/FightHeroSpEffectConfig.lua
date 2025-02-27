module("modules.logic.fight.config.FightHeroSpEffectConfig", package.seeall)

slot0 = class("FightHeroSpEffectConfig", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"fight_sp_effect_kkny_bear_damage",
		"fight_sp_effect_kkny_heal",
		"fight_sp_effect_kkny_bear_damage_hit",
		"fight_sp_effect_bkle",
		"fight_sp_effect_ly",
		"fight_sp_effect_alf",
		"fight_sp_effect_alf_timeline",
		"fight_sp_effect_alf_add_card",
		"fight_sp_effect_ddg"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
end

function slot0.getBKLEAddBuffEffect(slot0, slot1)
	if slot0.curSkin ~= slot1 then
		slot0.curSkin = slot1

		slot0:initBKLERandomList(slot1)
	end

	if #slot0.BKLEEffectList == 0 then
		slot0:initBKLERandomList(slot1)
	end

	if #slot0.BKLEEffectList <= 1 then
		return table.remove(slot0.BKLEEffectList, 1)
	end

	return table.remove(slot0.BKLEEffectList, math.random(1, slot2))
end

function slot0.initBKLERandomList(slot0, slot1)
	slot0.BKLEEffectList = slot0.BKLEEffectList or {}

	tabletool.clear(slot0.BKLEEffectList)

	for slot7, slot8 in pairs(FightStrUtil.instance:getSplitCache(lua_fight_sp_effect_bkle.configDict[slot1].path, "|")) do
		slot0.BKLEEffectList[slot7] = slot8
	end
end

function slot0.getLYEffectCo(slot0, slot1)
	return lua_fight_sp_effect_ly.configDict[slot1] or lua_fight_sp_effect_ly.configDict[1]
end

function slot0.getRandomAlfASFDMissileRes(slot0)
	if slot0.tempRandomList and #slot0.tempRandomList > 0 then
		slot0.tempRandomList = slot0.tempRandomList
	else
		slot0.tempRandomList = tabletool.copy(lua_fight_sp_effect_alf.configList)
	end

	return table.remove(slot0.tempRandomList, math.random(#slot0.tempRandomList))
end

slot0.instance = slot0.New()

return slot0
