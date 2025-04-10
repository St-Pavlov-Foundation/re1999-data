module("modules.logic.versionactivity2_5.challenge.view.result.Act183SettlementSubEpisodeItem", package.seeall)

slot0 = class("Act183SettlementSubEpisodeItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._imageindex = gohelper.findChildImage(slot1, "image_index")
	slot0._imagestar = gohelper.findChildImage(slot1, "image_star")
	slot0._gobadgebg = gohelper.findChild(slot1, "mask")
	slot0._txtbadgenum = gohelper.findChildText(slot1, "txt_badgenum")
	slot0._imageruleicon1 = gohelper.findChildImage(slot1, "rules/go_rule1/image_icon")
	slot0._gorepress1 = gohelper.findChild(slot1, "rules/go_rule1/go_repress")
	slot0._goescape1 = gohelper.findChild(slot1, "rules/go_rule1/go_escape")
	slot0._imageruleicon2 = gohelper.findChildImage(slot1, "rules/go_rule2/image_icon")
	slot0._gorepress2 = gohelper.findChild(slot1, "rules/go_rule2/go_repress")
	slot0._goescape2 = gohelper.findChild(slot1, "rules/go_rule2/go_escape")
	slot0._imageicon = gohelper.findChildImage(slot1, "image_episode")
	slot0._goherocontainer = gohelper.findChild(slot1, "heros")
	slot0._gorules1 = gohelper.findChild(slot1, "rules")
	slot0._gorules2 = gohelper.findChild(slot1, "rules2")
	slot0._gorepress1_v2 = gohelper.findChild(slot1, "rules2/go_rule1/go_repress")
	slot0._goescape1_v2 = gohelper.findChild(slot1, "rules2/go_rule1/go_escape")
	slot0._imageruleicon2_v2 = gohelper.findChildImage(slot1, "rules2/go_rule2/image_icon")
	slot0._gorepress2_v2 = gohelper.findChild(slot1, "rules2/go_rule2/go_repress")
	slot0._goepisodestaritem = gohelper.findChild(slot1, "episodestars/go_episodestaritem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._herogroupComp = MonoHelper.addLuaComOnceToGo(slot0._goherocontainer, Act183SettlementSubEpisodeHeroComp)
end

function slot0.setHeroTemplate(slot0, slot1)
	if slot0._herogroupComp then
		slot0._herogroupComp:setHeroTemplate(slot1)
	end
end

function slot0.onUpdateMO(slot0, slot1, slot2)
	slot4 = slot2:getUseBadgeNum()

	UISpriteSetMgr.instance:setChallengeSprite(slot0._imageindex, "v2a5_challenge_result_level_" .. slot2:getPassOrder())

	slot0._txtbadgenum.text = slot4

	gohelper.setActive(slot0._txtbadgenum.gameObject, slot4 > 0)
	gohelper.setActive(slot0._gobadgebg, slot4 > 0)

	slot5 = slot2:getEpisodeId()

	Act183Helper.setRuleIcon(slot5, 1, slot0._imageruleicon1)
	Act183Helper.setRuleIcon(slot5, 2, slot0._imageruleicon2)
	Act183Helper.setSubEpisodeResultIcon(slot5, slot0._imageicon)
	slot0:refreshRepressIcon(slot2)
	slot0:refreshHeroGroup(slot2)
	slot0:refreshEpisodeStars(slot2)
	Act183Helper.setEpisodeConditionStar(slot0._imagestar, slot2:isAllConditionPass(), nil)
	gohelper.setActive(slot0.go, true)
end

function slot0.refreshRepressIcon(slot0, slot1)
	slot2 = slot1:getRuleStatus(1)
	slot3 = slot1:getRuleStatus(2)

	if (slot1:getHeroMos() and #slot4 or 0) == 5 then
		gohelper.setActive(slot0._gorepress1_v2, slot2 == Act183Enum.RuleStatus.Repress)
		gohelper.setActive(slot0._gorepress2_v2, slot3 == Act183Enum.RuleStatus.Repress)
		gohelper.setActive(slot0._goescape1_v2, slot2 == Act183Enum.RuleStatus.Escape)
		gohelper.setActive(slot0._goescape2_v2, slot3 == Act183Enum.RuleStatus.Escape)
	else
		gohelper.setActive(slot0._gorepress1, slot2 == Act183Enum.RuleStatus.Repress)
		gohelper.setActive(slot0._gorepress2, slot3 == Act183Enum.RuleStatus.Repress)
		gohelper.setActive(slot0._goescape1, slot2 == Act183Enum.RuleStatus.Escape)
		gohelper.setActive(slot0._goescape2, slot3 == Act183Enum.RuleStatus.Escape)
	end

	gohelper.setActive(slot0._gorules1, not slot6)
	gohelper.setActive(slot0._gorules2, slot6)
end

function slot0.refreshEpisodeStars(slot0, slot1)
	for slot7 = 1, slot1:getTotalStarCount() do
		slot9 = gohelper.onceAddComponent(gohelper.cloneInPlace(slot0._goepisodestaritem, "star_" .. slot7), gohelper.Type_Image)

		UISpriteSetMgr.instance:setCommonSprite(slot9, "zhuxianditu_pt_xingxing_001", true)
		SLFramework.UGUI.GuiHelper.SetColor(slot9, slot7 <= slot1:getFinishStarCount() and "#F77040" or "#87898C")
		gohelper.setActive(slot8, true)
	end
end

function slot0.refreshHeroGroup(slot0, slot1)
	if slot0._herogroupComp then
		slot0._herogroupComp:onUpdateMO(slot1)
	end
end

function slot0.onDestroy(slot0)
end

return slot0
