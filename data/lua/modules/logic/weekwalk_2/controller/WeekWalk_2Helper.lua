module("modules.logic.weekwalk_2.controller.WeekWalk_2Helper", package.seeall)

slot0 = class("WeekWalk_2Helper")

function slot0.setCupIcon(slot0, slot1)
	UISpriteSetMgr.instance:setWeekWalkSprite(slot0, "weekwalkheart_star" .. (slot1 and slot1.result or 0))
end

function slot0.setCupEffect(slot0, slot1)
	if not slot0 then
		return
	end

	uv0.setCupEffectByResult(slot0, slot1 and slot1.result or WeekWalk_2Enum.CupType.None)
end

function slot0.setCupEffectByResult(slot0, slot1)
	for slot8 = 1, slot0.transform.childCount do
		slot9 = slot2:GetChild(slot8 - 1)

		gohelper.setActive(slot9, slot9.name == "star0" .. slot1)
	end
end

return slot0
