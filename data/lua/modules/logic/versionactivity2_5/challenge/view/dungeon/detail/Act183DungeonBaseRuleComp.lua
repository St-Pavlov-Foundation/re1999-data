module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonBaseRuleComp", package.seeall)

slot0 = class("Act183DungeonBaseRuleComp", Act183DungeonBaseComp)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._gobaseruleitem = gohelper.findChild(slot0.go, "#go_baseruleitem")
	slot0._baseRuleItemTab = slot0:getUserDataTb_()
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.updateInfo(slot0, slot1)
	uv0.super.updateInfo(slot0, slot1)

	slot0._baseRules = Act183Config.instance:getEpisodeAllRuleDesc(slot0._episodeId)
end

function slot0.checkIsVisible(slot0)
	return slot0._baseRules and #slot0._baseRules > 0
end

function slot0.show(slot0)
	uv0.super.show(slot0)
	slot0:createObjList(slot0._baseRules, slot0._baseRuleItemTab, slot0._gobaseruleitem, slot0._initBaseRuleItemFunc, slot0._refreshBaseRuleItemFunc, slot0._defaultItemFreeFunc)
end

function slot0._initBaseRuleItemFunc(slot0, slot1)
	slot1.txtdesc = gohelper.findChildText(slot1.go, "txt_desc")
	slot1.imageicon = gohelper.findChildImage(slot1.go, "image_icon")

	SkillHelper.addHyperLinkClick(slot1.txtdesc)
end

function slot0._refreshBaseRuleItemFunc(slot0, slot1, slot2, slot3)
	slot1.txtdesc.text = SkillHelper.buildDesc(slot2)

	Act183Helper.setRuleIcon(slot0._episodeId, slot3, slot1.imageicon)
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
end

return slot0
