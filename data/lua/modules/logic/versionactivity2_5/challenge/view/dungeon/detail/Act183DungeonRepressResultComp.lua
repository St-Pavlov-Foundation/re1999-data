module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonRepressResultComp", package.seeall)

slot0 = class("Act183DungeonRepressResultComp", Act183DungeonBaseComp)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._gohasrepress = gohelper.findChild(slot0.go, "#go_hasrepress")
	slot0._gounrepress = gohelper.findChild(slot0.go, "#go_unrepress")
	slot0._gorepressruleitem = gohelper.findChild(slot0.go, "#go_repressrules/#go_repressruleitem")
	slot0._gorepressheropos = gohelper.findChild(slot0.go, "#go_hasrepress/#go_repressheropos")
	slot0._repressRuleItemTab = slot0:getUserDataTb_()
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
	return slot0._status == Act183Enum.EpisodeStatus.Finished and slot0._episodeType == Act183Enum.EpisodeType.Sub and not Act183Helper.isLastPassEpisodeInType(slot0._episodeMo)
end

function slot0.show(slot0)
	uv0.super.show(slot0)
	gohelper.setActive(slot0._gohasrepress, false)
	gohelper.setActive(slot0._gounrepress, true)
	slot0:createObjList(slot0._baseRules, slot0._repressRuleItemTab, slot0._gorepressruleitem, slot0._initRepressRuleItemFunc, slot0._refreshRepressResultFunc, slot0._defaultItemFreeFunc)
end

function slot0._initRepressRuleItemFunc(slot0, slot1)
	slot1.txtdesc = gohelper.findChildText(slot1.go, "txt_desc")
	slot1.imageicon = gohelper.findChildImage(slot1.go, "image_icon")
	slot1.godisable = gohelper.findChild(slot1.go, "image_icon/go_disable")
	slot1.goescape = gohelper.findChild(slot1.go, "image_icon/go_escape")
	slot1.gorepressbg = gohelper.findChild(slot1.go, "#go_Disable")

	SkillHelper.addHyperLinkClick(slot1.txtdesc)
end

function slot0._refreshRepressResultFunc(slot0, slot1, slot2, slot3)
	slot5 = slot0._episodeMo:getRuleStatus(slot3) == Act183Enum.RuleStatus.Repress
	slot1.txtdesc.text = SkillHelper.buildDesc(slot2)

	gohelper.setActive(slot1.godisable, slot5)
	gohelper.setActive(slot1.gorepressbg, slot5)
	gohelper.setActive(slot1.goescape, not slot5)
	Act183Helper.setRuleIcon(slot0._episodeId, slot3, slot1.imageicon)

	if slot5 then
		slot7 = slot0._episodeMo:getRepressHeroMo():getHeroId()

		if not slot0._repressHeroItem then
			slot0._repressHeroItem = IconMgr.instance:getCommonHeroIconNew(slot0._gorepressheropos)

			slot0._repressHeroItem:isShowLevel(false)
		end

		slot0._repressHeroItem:onUpdateHeroId(slot7)
		gohelper.setActive(slot0._gohasrepress, true)
		gohelper.setActive(slot0._gounrepress, false)
	end
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
end

return slot0
