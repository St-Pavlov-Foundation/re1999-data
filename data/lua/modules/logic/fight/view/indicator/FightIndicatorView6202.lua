module("modules.logic.fight.view.indicator.FightIndicatorView6202", package.seeall)

slot0 = class("FightIndicatorView6202", FightIndicatorView)

function slot0.initView(slot0, slot1, slot2, slot3)
	uv0.super.initView(slot0, slot1, slot2, slot3)

	slot0.totalIndicatorNum = 4
end

function slot0.getCardConfig(slot0)
	return Season123Config.instance:getSeasonEquipCo(slot0:getCardId())
end

function slot0.getCardId(slot0)
	return 200042
end

return slot0
