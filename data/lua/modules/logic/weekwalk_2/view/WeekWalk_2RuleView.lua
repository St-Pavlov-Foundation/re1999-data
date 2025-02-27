module("modules.logic.weekwalk_2.view.WeekWalk_2RuleView", package.seeall)

slot0 = class("WeekWalk_2RuleView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_icon")
	slot0._goruleitem = gohelper.findChild(slot0.viewGO, "rule/#go_ruleitem")
	slot0._goruleDescList = gohelper.findChild(slot0.viewGO, "rule/#go_ruleDescList")
	slot0._btnclose2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close2")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnclose2:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnclose2:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._childGoList = slot0:getUserDataTb_()
	slot0._rulesimagelineList = slot0:getUserDataTb_()
	slot0._info = WeekWalk_2Model.instance:getInfo()

	slot0._simagebg:LoadImage(ResUrl.getWeekWalkBg("full/guize_beijing.jpg"))
end

function slot0.onUpdateParam(slot0)
	if slot0._rulesimagelineList then
		for slot4, slot5 in pairs(slot0._rulesimagelineList) do
			rawset(slot0._rulesimagelineList, slot4, nil)
		end
	end

	if slot0._childGoList then
		for slot4, slot5 in pairs(slot0._childGoList) do
			gohelper.destroy(slot5)
			rawset(slot0._childGoList, slot4, nil)
		end
	end

	slot0:_refreshView()
end

function slot0.onOpen(slot0)
	slot0:_refreshView()
end

function slot0._refreshView(slot0)
	slot1 = nil

	if slot0.viewParam then
		slot1 = slot0.viewParam.issueId
	elseif slot0._info then
		slot1 = slot0._info.issueId
	end

	if not slot1 then
		logError("WeekWalk_2RuleView._refreshView, issueId can not be nil!")

		return
	end

	slot2 = lua_weekwalk_ver2_time.configDict[slot1]
	slot4 = nil

	slot0._simageicon:LoadImage((not false or ResUrl.getWeekWalkIconLangPath(slot2.ruleIcon)) and ResUrl.getWeekWalkBg("rule/" .. slot2.ruleIcon .. ".png"))

	if not string.nilorempty(slot2.ruleFront) then
		tabletool.addValues({}, GameUtil.splitString2(slot2.ruleFront, true, "|", "#"))
	end

	if not string.nilorempty(slot2.ruleRear) then
		tabletool.addValues(slot5, GameUtil.splitString2(slot2.ruleRear, true, "|", "#"))
	end

	for slot9, slot10 in ipairs(slot5) do
		if lua_rule.configDict[slot10[2]] then
			slot0:_setRuleDescItem(slot13, slot10[1])
		end

		if slot9 == #slot5 then
			gohelper.setActive(slot0._rulesimagelineList[slot9], false)
		end
	end
end

function slot0._addRuleItem(slot0, slot1, slot2)
	slot3 = gohelper.clone(slot0._goruletemp, slot0._gorulelist, slot1.id)

	table.insert(slot0._childGoList, slot3)
	gohelper.setActive(slot3, true)
	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot3, "#image_tagicon"), "wz_" .. slot2)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(gohelper.findChildImage(slot3, ""), slot1.icon)
end

function slot0._setRuleDescItem(slot0, slot1, slot2)
	slot3 = {
		"#BDF291",
		"#D05B4C",
		"#C7b376"
	}
	slot4 = gohelper.clone(slot0._goruleitem, slot0._goruleDescList, slot1.id)

	table.insert(slot0._childGoList, slot4)
	gohelper.setActive(slot4, true)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(gohelper.findChildImage(slot4, "icon"), slot1.icon)
	table.insert(slot0._rulesimagelineList, gohelper.findChild(slot4, "line"))
	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot4, "tag"), "wz_" .. slot2)

	gohelper.findChildText(slot4, "desc").text = string.format("<color=%s>[%s]</color>%s%s", slot3[slot2], luaLang("dungeon_add_rule_target_" .. slot2), string.gsub(slot1.desc, "%【(.-)%】", "<color=#FF906A>[%1]</color>"), "\n" .. HeroSkillModel.instance:getEffectTagDescFromDescRecursion(slot1.desc, slot3[1]))
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageicon:UnLoadImage()
end

return slot0
