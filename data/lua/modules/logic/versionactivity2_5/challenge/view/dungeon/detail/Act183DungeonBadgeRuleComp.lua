module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonBadgeRuleComp", package.seeall)

slot0 = class("Act183DungeonBadgeRuleComp", Act183DungeonBaseComp)

function slot0.init(slot0, slot1, slot2)
	uv0.super.init(slot0, slot1, slot2)

	slot0._gobadgeruleitem = gohelper.findChild(slot0.go, "#go_badgeruleitem")
	slot0._badgeRuleItemTab = slot0:getUserDataTb_()

	slot0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateSelectBadgeNum, slot0._onUpdateSelectBadgeNum, slot0)
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.updateInfo(slot0, slot1)
	uv0.super.updateInfo(slot0, slot1)

	slot0._baseRules = Act183Config.instance:getEpisodeAllRuleDesc(slot0._episodeId)
	slot0._useBadgeNum = slot0._episodeMo:getUseBadgeNum()
	slot0._readyUseBadgeNum = slot0._useBadgeNum or 0
	slot0._isNeedPlayBadgeAnim = false
end

function slot0.checkIsVisible(slot0)
	return slot0._readyUseBadgeNum > 0
end

function slot0.show(slot0)
	uv0.super.show(slot0)
	slot0:createObjList({
		Act183Config.instance:getBadgeCo(slot0._activityId, slot0._readyUseBadgeNum)
	}, slot0._badgeRuleItemTab, slot0._gobadgeruleitem, slot0._initBadgeRuleItemFunc, slot0._refreshBadgeRuleItemFunc, slot0._defaultItemFreeFunc)
end

function slot0._initBadgeRuleItemFunc(slot0, slot1)
	slot1.txtdesc = gohelper.findChildText(slot1.go, "txt_desc")
	slot1.anim = gohelper.onceAddComponent(slot1.go, gohelper.Type_Animator)

	SkillHelper.addHyperLinkClick(slot1.txtdesc)
end

function slot0._refreshBadgeRuleItemFunc(slot0, slot1, slot2, slot3)
	slot1.txtdesc.text = SkillHelper.buildDesc(slot2.decs)

	if slot0._isNeedPlayBadgeAnim then
		slot1.anim:Play("in", 0, 0)
	end
end

function slot0._onUpdateSelectBadgeNum(slot0, slot1, slot2)
	if slot0._episodeId ~= slot1 then
		return
	end

	slot0._readyUseBadgeNum = slot2
	slot0._isNeedPlayBadgeAnim = true

	slot0.container:refresh()
	slot0.container.mgr:focus(Act183DungeonBaseAndBadgeRuleComp)
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
end

return slot0
