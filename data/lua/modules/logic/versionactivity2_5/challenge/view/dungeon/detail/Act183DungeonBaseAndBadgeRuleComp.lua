module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonBaseAndBadgeRuleComp", package.seeall)

slot0 = class("Act183DungeonBaseAndBadgeRuleComp", Act183DungeonBaseComp)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._gobadgerules = gohelper.findChild(slot0.go, "#go_badgerules")
	slot0._gobaserules = gohelper.findChild(slot0.go, "#go_baserules")
	slot0._badgeRuleComp = MonoHelper.addLuaComOnceToGo(slot0._gobadgerules, Act183DungeonBadgeRuleComp)
	slot0._baseRuleComp = MonoHelper.addLuaComOnceToGo(slot0._gobaserules, Act183DungeonBaseRuleComp)
	slot0._badgeRuleComp.container = slot0
	slot0._baseRuleComp.container = slot0
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.updateInfo(slot0, slot1)
	uv0.super.updateInfo(slot0, slot1)
	slot0._badgeRuleComp:updateInfo(slot1)
	slot0._baseRuleComp:updateInfo(slot1)
end

function slot0.refresh(slot0)
	uv0.super.refresh(slot0)
	slot0._badgeRuleComp:refresh()
	slot0._baseRuleComp:refresh()
end

function slot0.checkIsVisible(slot0)
	return slot0._badgeRuleComp:checkIsVisible() or slot0._baseRuleComp:checkIsVisible()
end

function slot0.focus(slot0, slot1)
	if slot1 then
		return slot0._badgeRuleComp:focus()
	end

	return slot0._baseRuleComp:focus()
end

return slot0
