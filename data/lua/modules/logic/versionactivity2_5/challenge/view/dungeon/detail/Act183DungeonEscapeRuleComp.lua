module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonEscapeRuleComp", package.seeall)

slot0 = class("Act183DungeonEscapeRuleComp", Act183DungeonBaseComp)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._goescaperuleitem = gohelper.findChild(slot0.go, "#go_escaperules/#go_escaperuleitem")
	slot0._escapeRuleItemTab = slot0:getUserDataTb_()
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.updateInfo(slot0, slot1)
	uv0.super.updateInfo(slot0, slot1)

	slot0._escapeRules = slot0._groupEpisodeMo:getEscapeRules(slot0._episodeId)
	slot0._maxPassOrder = slot0._groupEpisodeMo:findMaxPassOrder()
end

function slot0.checkIsVisible(slot0)
	return slot0._escapeRules and #slot0._escapeRules > 0
end

function slot0.show(slot0)
	uv0.super.show(slot0)

	slot0._hasPlayRefreshAnimRuleIds = Act183Helper.getHasPlayRefreshAnimRuleIdsInLocal(slot0._episodeId)
	slot0._hasPlayRefreshAnimRuleIdMap = Act183Helper.listToMap(slot0._hasPlayRefreshAnimRuleIds)
	slot0._needFocusEscapeRule = false
	slot0._needFocusMinRuleIndex = 100

	slot0:createObjList(slot0._escapeRules, slot0._escapeRuleItemTab, slot0._goescaperuleitem, slot0._initEscapeRuleItemFunc, slot0._refreshEscapeRuleItemFunc, slot0._defaultItemFreeFunc)

	if slot0._needFocusEscapeRule then
		slot0.mgr:focus(uv0, slot0._needFocusMinRuleIndex)
	end

	Act183Helper.saveHasPlayRefreshAnimRuleIdsInLocal(slot0._episodeId, slot0._hasPlayRefreshAnimRuleIds)
end

function slot0._initEscapeRuleItemFunc(slot0, slot1)
	slot1.txtdesc = gohelper.findChildText(slot1.go, "txt_desc")
	slot1.imageicon = gohelper.findChildImage(slot1.go, "image_icon")
	slot1.anim = gohelper.onceAddComponent(slot1.go, gohelper.Type_Animator)

	SkillHelper.addHyperLinkClick(slot1.txtdesc)
end

function slot0._refreshEscapeRuleItemFunc(slot0, slot1, slot2, slot3)
	slot1.txtdesc.text = SkillHelper.buildDesc(slot2.ruleDesc)

	Act183Helper.setRuleIcon(slot2.episodeId, slot2.ruleIndex, slot1.imageicon)

	slot9 = slot0._maxPassOrder and slot2.passOrder == slot0._maxPassOrder and not (slot0._hasPlayRefreshAnimRuleIdMap[string.format("%s_%s", slot4, slot5)] ~= nil)

	slot1.anim:Play(slot9 and "in" or "idle", 0, 0)

	if slot9 then
		slot0._hasPlayRefreshAnimRuleIdMap[slot7] = true

		table.insert(slot0._hasPlayRefreshAnimRuleIds, slot7)

		slot0._needFocusEscapeRule = true
		slot0._needFocusMinRuleIndex = slot3 < slot0._needFocusMinRuleIndex and slot3 or slot0._needFocusMinRuleIndex
	end
end

function slot0.focus(slot0, slot1)
	if not slot0._escapeRuleItemTab[slot1 or 1] then
		return 0
	end

	for slot7 = 1, #slot0._escapeRuleItemTab do
		if slot1 <= slot7 then
			break
		end

		slot2 = slot2 + recthelper.getHeight(slot0._escapeRuleItemTab[slot7].go.transform)
	end

	return slot2
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
end

return slot0
