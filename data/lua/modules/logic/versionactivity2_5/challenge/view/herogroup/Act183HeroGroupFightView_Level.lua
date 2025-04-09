module("modules.logic.versionactivity2_5.challenge.view.herogroup.Act183HeroGroupFightView_Level", package.seeall)

slot0 = class("Act183HeroGroupFightView_Level", HeroGroupFightViewLevel)

function slot0.onInitView(slot0)
	uv0.super.onInitView(slot0)

	slot0._goadditioncontain = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/challenge_additioncontain")
	slot0._goadditionitem = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/challenge_additioncontain/targetList/#go_additionitem")
	slot0._goadditionstar1 = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/challenge_additioncontain/text/starcontainer/#go_star1")
	slot0._goadditionstar2 = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/challenge_additioncontain/text/starcontainer/#go_star2")
	slot0._goadditionstar3 = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/challenge_additioncontain/text/starcontainer/#go_star3")
	slot0._gochallenge = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege")
	slot0._gobaserulecontainer = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/basictxt")
	slot0._gobaserules = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/basictxt/Iconlist")
	slot0._gobaseruleItem = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/basictxt/Iconlist/#go_item")
	slot0._goescapecontainer = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/escapetxt")
	slot0._goescaperules = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/escapetxt/Iconlist")
	slot0._goescaperuleitem = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/escapetxt/Iconlist/#go_item")
	slot0._btnchallengetip = gohelper.findChildButton(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/title/#btn_info")
	slot0._btnchallengetip = gohelper.findChildButton(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/title/#btn_info")
	slot0._gochallengetips = gohelper.findChild(slot0.viewGO, "#go_container/#go_challengetips")
	slot0._btnclosechallengetips = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/#go_challengetips/#btn_closechallengetips")
	slot0._gochallengetipscontent = gohelper.findChild(slot0.viewGO, "#go_container/#go_challengetips/#scroll_challengetips/Viewport/Content")
	slot0._gochallengetiptitle = gohelper.findChild(slot0.viewGO, "#go_container/#go_challengetips/#scroll_challengetips/Viewport/Content/#go_tipitem/title")
	slot0._gochallengetipitem = gohelper.findChild(slot0.viewGO, "#go_container/#go_challengetips/#scroll_challengetips/Viewport/Content/#go_tipitem")
	slot0._gochallengedescitem = gohelper.findChild(slot0.viewGO, "#go_container/#go_challengetips/#scroll_challengetips/Viewport/Content/#go_tipitem/#txt_desc")
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0._activityId = Act183Model.instance:getActivityId()
	slot0._episodeId = HeroGroupModel.instance.episodeId
	slot0._episodeInfo = DungeonModel.instance:getEpisodeInfo(slot0._episodeId)
	slot0._episodeCo = Act183Config.instance:getEpisodeCo(slot0._episodeId)
	slot0._episodeMo = Act183Model.instance:getEpisodeMo(slot0._episodeCo.groupId, slot0._episodeId)
	slot0._groupEpisodeMo = Act183Model.instance:getGroupEpisodeMo(slot0._episodeCo.groupId)
	slot0._groupType = slot0._groupEpisodeMo:getGroupType()
	slot0._hardMode = slot0._groupType == Act183Enum.GroupType.HardMain
	slot0._conditionItemTab = slot0:getUserDataTb_()
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0._btnchallengetip:AddClickListener(slot0._btnchallengetipOnClick, slot0)
	slot0._btnclosechallengetips:AddClickListener(slot0._btnclosechallengetipsOnClick, slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
	slot0._btnchallengetip:RemoveClickListener()
	slot0._btnclosechallengetips:RemoveClickListener()
end

function slot0._btnchallengetipOnClick(slot0)
	gohelper.setActive(slot0._gochallengetips, true)
	slot0:refreshChallengeTips()
end

function slot0._btnclosechallengetipsOnClick(slot0)
	gohelper.setActive(slot0._gochallengetips, false)
end

function slot0._refreshUI(slot0)
	uv0.super._refreshUI(slot0)
	slot0:refreshChallengeRules()
	slot0:refreshFightConditions()
	gohelper.setActive(slot0._gohardEffect, slot0._hardMode)
end

function slot0._refreshTarget(slot0)
	uv0.super._refreshTarget(slot0)
	slot0:_refreshAdvanceStar2()
end

function slot0._refreshAdvanceStar2(slot0)
	slot2 = not string.nilorempty(DungeonConfig.instance:getEpisodeAdvancedCondition2Text(slot0._episodeId))

	gohelper.setActive(slot0._goplatinumcondition2, slot2)

	if not slot2 then
		return
	end

	slot0._txtplatinumcondition2.text = slot1
	slot3 = DungeonEnum.StarType.Ultra <= slot0._episodeInfo.star

	gohelper.setActive(slot0._goplatinumfinish2, slot3)
	gohelper.setActive(slot0._goplatinumunfinish2, not slot3)
	ZProj.UGUIHelper.SetColorAlpha(slot0._txtplatinumcondition2, slot3 and 1 or 0.63)
	slot0:_setStar(slot0._starList[3], slot3)
end

function slot0._initStars(slot0)
	if slot0._starList then
		return
	end

	slot1 = slot0:_getTotalConditionNum()

	for slot5 = 1, Act183Enum.EpisodeMaxStarNum do
		gohelper.setActive(slot0["_gostar" .. slot5], slot5 == slot1)
	end

	slot0._starList = slot0:getUserDataTb_()

	for slot6 = 1, slot1 do
		table.insert(slot0._starList, gohelper.findChildImage(slot0["_gostar" .. slot1], "star" .. slot6))
	end
end

function slot0._getTotalConditionNum(slot0)
	slot1 = {}

	table.insert(slot1, DungeonConfig.instance:getFirstEpisodeWinConditionText(slot0._episodeId))
	table.insert(slot1, DungeonConfig.instance:getEpisodeAdvancedConditionText(slot0._episodeId))

	slot6 = slot0._episodeId

	table.insert(slot1, DungeonConfig.instance:getEpisodeAdvancedCondition2Text(slot6))

	for slot6, slot7 in ipairs(slot1) do
		if not string.nilorempty(slot7) then
			slot2 = 0 + 1
		end
	end

	return slot2
end

function slot0.refreshFightConditions(slot0)
	slot3 = (slot0._episodeMo:getConditionIds() and #slot1 or 0) > 0

	gohelper.setActive(slot0._goadditioncontain, slot3)

	if not slot3 then
		return
	end

	slot4 = {}
	slot5 = {}

	if slot1 then
		for slot9, slot10 in ipairs(slot1) do
			slot12 = slot0._episodeMo:isConditionPass(slot10)
			slot0:_getOrCreateConditionItem(slot9).txtcontent.text = Act183Config.instance:getConditionCo(slot10) and slot13.decs1 or ""

			Act183Helper.setEpisodeConditionStar(slot11.imagestar, slot12, nil, true)
			gohelper.setActive(slot11.viewGO, true)

			slot5[slot9] = slot12
			slot4[slot11] = true
		end
	end

	for slot9, slot10 in pairs(slot0._conditionItemTab) do
		if not slot4[slot10] then
			gohelper.setActive(slot10.viewGO, false)
		end
	end

	slot0:refreshFightConditionTitleStar(slot2, slot5)
end

function slot0.refreshFightConditionTitleStar(slot0, slot1, slot2)
	if not slot0["_goadditionstar" .. slot1] then
		return
	end

	for slot7 = 1, slot1 do
		if not gohelper.isNil(gohelper.findChildImage(slot3, "star" .. slot7)) then
			Act183Helper.setEpisodeConditionStar(slot8, slot2[slot7])
		end
	end

	gohelper.setActive(slot3, true)
end

function slot0._getOrCreateConditionItem(slot0, slot1)
	if not slot0._conditionItemTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.cloneInPlace(slot0._goadditionitem, "fightcondition_" .. slot1)
		slot2.txtcontent = gohelper.findChildText(slot2.viewGO, "#txt_normalcondition")
		slot2.imagestar = gohelper.findChildImage(slot2.viewGO, "#image_star")
		slot0._conditionItemTab[slot1] = slot2
	end

	return slot2
end

function slot0.refreshChallengeRules(slot0)
	slot0._baseRuleDescList = Act183Config.instance:getEpisodeAllRuleDesc(slot0._episodeId)
	slot0._hasBaseRule = (slot0._baseRuleDescList and #slot0._baseRuleDescList or 0) > 0

	gohelper.setActive(slot0._gobaserulecontainer, slot0._hasBaseRule)

	if slot0._hasBaseRule then
		gohelper.CreateObjList(slot0, slot0._refreshBaseRuleItem, slot0._baseRuleDescList, slot0._gobaserules, slot0._gobaseruleItem)
	end

	slot2 = slot0._episodeMo and slot0._episodeMo:getEpisodeType()
	slot0._escapeRules = slot0._groupEpisodeMo:getEscapeRules(slot0._episodeId)
	slot0._canGetRule = slot0._escapeRules and #slot0._escapeRules > 0

	gohelper.setActive(slot0._goescapecontainer, slot0._canGetRule)

	if slot0._canGetRule then
		gohelper.CreateObjList(slot0, slot0._refreshEscapeRuleItem, slot0._escapeRules, slot0._goescaperules, slot0._goescaperuleitem)
	end

	gohelper.setActive(slot0._gochallenge, slot0._hasBaseRule or slot0._canGetRule)
end

function slot0._refreshBaseRuleItem(slot0, slot1, slot2, slot3)
	Act183Helper.setRuleIcon(slot0._episodeId, slot3, gohelper.findChildImage(slot1, "icon"))
end

function slot0._refreshEscapeRuleItem(slot0, slot1, slot2, slot3)
	Act183Helper.setRuleIcon(slot2.episodeId, slot2.ruleIndex, gohelper.findChildImage(slot1, "icon"))
end

function slot0.refreshChallengeTips(slot0)
	if slot0._initChallengeTipsDone then
		return
	end

	slot0:_refreshBaseRuleTipContents()
	slot0:_refreshEscapeRuleTipContents()

	slot0._initChallengeTipsDone = true
end

function slot0._refreshBaseRuleTipContents(slot0)
	if not slot0._hasBaseRule then
		return
	end

	slot0._gobaseruletipitem = gohelper.cloneInPlace(slot0._gochallengetipitem, "baseruleitem")
	slot4 = "p_v2a5_challenge_herogroupview_basictxt"

	slot0:_refreshTipTitle(slot0._gobaseruletipitem, slot4)

	for slot4, slot5 in ipairs(slot0._baseRuleDescList) do
		slot6 = gohelper.clone(slot0._gochallengedescitem, slot0._gobaseruletipitem, "item_" .. slot4)
		slot7 = gohelper.onceAddComponent(slot6, gohelper.Type_TextMesh)
		slot7.text = SkillHelper.buildDesc(slot5)

		SkillHelper.addHyperLinkClick(slot7)
		Act183Helper.setRuleIcon(slot0._episodeId, slot4, gohelper.findChildImage(slot6, "image_icon"))
		gohelper.setActive(slot6, true)
	end

	gohelper.setActive(slot0._gobaseruletipitem, true)
end

function slot0._refreshEscapeRuleTipContents(slot0)
	if not slot0._canGetRule then
		return
	end

	slot0._goescaperuletipitem = gohelper.cloneInPlace(slot0._gochallengetipitem, "escaperuleitem")
	slot4 = "p_v2a5_challenge_herogroupview_escapetxt"

	slot0:_refreshTipTitle(slot0._goescaperuletipitem, slot4)

	for slot4, slot5 in ipairs(slot0._escapeRules) do
		slot6 = gohelper.clone(slot0._gochallengedescitem, slot0._goescaperuletipitem, "item_" .. slot4)
		slot7 = gohelper.onceAddComponent(slot6, gohelper.Type_TextMesh)
		slot7.text = SkillHelper.buildDesc(slot5.ruleDesc)

		SkillHelper.addHyperLinkClick(slot7)
		Act183Helper.setRuleIcon(slot5.episodeId, slot5.ruleIndex, gohelper.findChildImage(slot6, "image_icon"))
		gohelper.setActive(slot6, true)
	end

	gohelper.setActive(slot0._goescaperuletipitem, true)
end

function slot0._refreshTipTitle(slot0, slot1, slot2)
	gohelper.findChildText(slot1, "title/txt_name").text = luaLang(slot2)
end

return slot0
