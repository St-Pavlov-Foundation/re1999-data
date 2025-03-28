module("modules.logic.seasonver.act123.view1_9.Season123_1_9HeroGroupFightViewRule", package.seeall)

slot0 = class("Season123_1_9HeroGroupFightViewRule", BaseView)

function slot0.onInitView(slot0)
	slot0._gorules = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/#go_rules")
	slot0._goimagenormal = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/#go_rules/title/text/#image_normalicondition")
	slot0._goimagerare = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/#go_rules/title/text/#image_rarecondition")
	slot0._goruleitem = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/#go_rules/rulelist/#go_ruleitem")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/#go_rules/rulelist/#go_ruleitem/image_normal")
	slot0._gorare = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/#go_rules/rulelist/#go_ruleitem/image_rare")
	slot0._txtruleinfo = gohelper.findChildText(slot0.viewGO, "#go_container/infocontain/#go_rules/rulelist/#go_ruleitem/txt_ruleinfo")
	slot0._goadditionRule = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/#go_additionRule")
	slot0._goruletemp = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/#go_additionRule/#go_ruletemp")
	slot0._imagetagicon = gohelper.findChildImage(slot0.viewGO, "#go_container/infocontain/#go_additionRule/#go_ruletemp/#image_tagicon")
	slot0._gorulelist = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/#go_additionRule/#go_rulelist")
	slot0._btnadditionRuleclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/infocontain/#go_additionRule/#go_rulelist/#btn_additionRuleclick")
	slot0._gocontainer2 = gohelper.findChild(slot0.viewGO, "#go_container2")
	slot0._goruledesc = gohelper.findChild(slot0.viewGO, "#go_container2/#go_ruledesc")
	slot0._btncloserule = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container2/#go_ruledesc/#btn_closerule")
	slot0._goruleitem2 = gohelper.findChild(slot0.viewGO, "#go_container2/#go_ruledesc/bg/#go_ruleitem")
	slot0._goruleDescList = gohelper.findChild(slot0.viewGO, "#go_container2/#go_ruledesc/bg/#go_ruleDescList")
	slot0._btnenemy = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/infocontain/enemycontain/enemytitle/txten/#btn_enemy")
	slot0._enemylist = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/infocontain/enemycontain/enemyList/#go_enemyteam/enemyList")
	slot0._txtrecommendlevel = gohelper.findChildText(slot0.viewGO, "#go_container/infocontain/enemycontain/recommendtxt/#txt_recommendLevel")
	slot0._goenemyteam = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/enemycontain/enemyList/#go_enemyteam")
	slot0._gorecommendattr = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/enemycontain/#go_recommendAttr")
	slot0._goattritem = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/enemycontain/#go_recommendAttr/attrlist/#go_attritem")
	slot0._txtrecommonddes = gohelper.findChildTextMesh(slot0.viewGO, "#go_container/infocontain/enemycontain/#go_recommendAttr/#txt_recommonddes")
	slot0._btnadditionruledetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/infocontain/#go_additionRule/#go_additionruletips/tips/#btn_additionruledetail")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnadditionRuleclick:AddClickListener(slot0._btnadditionRuleOnClick, slot0)
	slot0._btncloserule:AddClickListener(slot0._btncloseruleOnClick, slot0)
	slot0._btnenemy:AddClickListener(slot0._btnenemyOnClick, slot0)
	slot0._enemylist:AddClickListener(slot0._btnenemyOnClick, slot0)
	slot0._btnadditionruledetail:AddClickListener(slot0._btnAdditionRuleDetailOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnadditionRuleclick:RemoveClickListener()
	slot0._btncloserule:RemoveClickListener()
	slot0._btnenemy:RemoveClickListener()
	slot0._enemylist:RemoveClickListener()
	slot0._btnadditionruledetail:RemoveClickListener()
end

function slot0._btncloseruleOnClick(slot0)
	if slot0._ruleItemClick then
		slot0._ruleItemClick = false

		return
	end

	gohelper.setActive(slot0._goruledesc, false)
end

function slot0._btnadditionRuleOnClick(slot0)
	if not slot0._hasRuleList then
		return
	end

	slot0._ruleItemClick = slot0._goruledesc.activeSelf

	gohelper.setActive(slot0._gocontainer2, true)
	gohelper.setActive(slot0._goruledesc, true)
end

function slot0._btnenemyOnClick(slot0)
	EnemyInfoController.instance:openSeason123EnemyInfoViewWithNoTab(Season123HeroGroupModel.instance.activityId, HeroGroupModel.instance.battleId)
end

function slot0._btnAdditionRuleDetailOnClick(slot0)
	Season123Controller.instance:openSeasonAdditionRuleTipView({
		actId = Season123HeroGroupModel.instance.activityId,
		stage = Season123HeroGroupModel.instance.stage
	})
end

function slot0._editableInitView(slot0)
	gohelper.addUIClickAudio(slot0._btnenemy.gameObject, AudioEnum.UI.play_ui_formation_monstermessage)
	gohelper.setActive(slot0._goruleitem2, false)
	gohelper.setActive(slot0._goruletemp, false)
	gohelper.setActive(slot0._goruledesc, false)

	slot0._monsterGroupItemList = {}
	slot0._rulesimageList = slot0:getUserDataTb_()
	slot0._rulesimagelineList = slot0:getUserDataTb_()
	slot0._simageList = slot0:getUserDataTb_()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0._recommendCareer, slot0)
	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot0:_refreshRules()
	slot0:_refreshAddition()
	slot0:_refreshEnemy()
	slot0:_recommendCareer()
end

function slot0._refreshRules(slot0)
	slot3 = Season123Model.instance:getEpisodeRetail(slot1)

	gohelper.setActive(slot0._goruleitem, true)

	if DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId).type == DungeonEnum.EpisodeType.Season123Retail and slot3 then
		gohelper.setActive(slot0._gorules, slot2 and slot3.advancedId ~= 0)
		gohelper.setActive(slot0._goimagenormal, slot3.advancedRare == 1)
		gohelper.setActive(slot0._goimagerare, slot3.advancedRare == 2)
		gohelper.setActive(slot0._gonormal, slot3.advancedRare == 1)
		gohelper.setActive(slot0._gorare, slot3.advancedRare == 2)

		if slot3.advancedId and slot3.advancedId ~= 0 then
			slot0._txtruleinfo.text = lua_condition.configDict[slot3.advancedId].desc
		else
			slot0._txtruleinfo.text = ""
		end
	else
		gohelper.setActive(slot0._gorules, false)
	end
end

function slot0._refreshAddition(slot0)
	if not GameUtil.splitString2(DungeonConfig.instance:getEpisodeAdditionRule(HeroGroupModel.instance.episodeId), true, "|", "#") or #slot3 == 0 then
		gohelper.setActive(slot0._goadditionRule, false)

		return
	end

	if Season123HeroGroupModel.instance.stage then
		slot3 = Season123Config.instance:filterRule(Season123HeroGroupModel.filterRule(Season123HeroGroupModel.instance.activityId, slot3), Season123HeroGroupModel.instance.stage)
	end

	slot0._hasRuleList = #slot3 > 0

	gohelper.setActive(slot0._goadditionRule, true)

	for slot7, slot8 in ipairs(slot3) do
		slot9 = slot8[1]

		if lua_rule.configDict[slot8[2]] then
			slot0:_addRuleItem(slot11, slot9)
			slot0:_setRuleDescItem(slot11, slot9)
		end

		if slot7 == #slot3 then
			gohelper.setActive(slot0._rulesimagelineList[slot7], false)
		end
	end
end

function slot0._addRuleItem(slot0, slot1, slot2)
	slot3 = gohelper.clone(slot0._goruletemp, slot0._gorulelist, slot1.id)

	gohelper.setActive(slot3, true)
	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot3, "#image_tagicon"), "wz_" .. slot2)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(gohelper.findChildImage(slot3, ""), slot1.icon)
end

function slot0._setRuleDescItem(slot0, slot1, slot2)
	slot4 = gohelper.clone(slot0._goruleitem2, slot0._goruleDescList, slot1.id)

	gohelper.setActive(slot4, true)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(gohelper.findChildImage(slot4, "icon"), slot1.icon)
	table.insert(slot0._rulesimagelineList, gohelper.findChild(slot4, "line"))
	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot4, "tag"), "wz_" .. slot2)

	slot8 = gohelper.findChildText(slot4, "desc")

	SkillHelper.addHyperLinkClick(slot8)

	slot9 = slot1.desc
	slot8.text = string.format("<color=%s>[%s]</color>%s%s", ({
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	})[slot2], luaLang("dungeon_add_rule_target_" .. slot2), SkillHelper.buildDesc(slot9, nil, "#6680bd"), "\n" .. SkillHelper.getTagDescRecursion(slot9, "#6680bd"))
end

function slot0._refreshEnemy(slot0)
	slot2 = {}
	slot3 = {}
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in ipairs(FightModel.instance:getFightParam().monsterGroupIds) do
		for slot16, slot17 in ipairs(string.splitToNumber(lua_monster_group.configDict[slot10].monster, "#")) do
			slot18 = lua_monster.configDict[slot17].career

			if slot17 == lua_monster_group.configDict[slot10].bossId then
				slot2[slot18] = (slot2[slot18] or 0) + 1

				table.insert(slot5, slot17)
			else
				slot3[slot18] = (slot3[slot18] or 0) + 1

				table.insert(slot4, slot17)
			end
		end
	end

	slot6 = {}

	for slot10, slot11 in pairs(slot2) do
		table.insert(slot6, {
			career = slot10,
			count = slot11
		})
	end

	slot0._enemyBossEndIndex = #slot6

	for slot10, slot11 in pairs(slot3) do
		table.insert(slot6, {
			career = slot10,
			count = slot11
		})
	end

	gohelper.CreateObjList(slot0, slot0._onEnemyItemShow, slot6, gohelper.findChild(slot0._goenemyteam, "enemyList"), gohelper.findChild(slot0._goenemyteam, "enemyList/go_enemyitem"))

	slot9 = 0

	if DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId).type == DungeonEnum.EpisodeType.Season123 then
		if Season123Config.instance:getSeasonEpisodeCo(Season123HeroGroupModel.instance.activityId, Season123HeroGroupModel.instance.stage, Season123HeroGroupModel.instance.layer) then
			slot9 = slot10.level
		end
	else
		slot9 = FightHelper.getBattleRecommendLevel(slot8.battleId)
	end

	if #slot5 > 0 then
		slot0._txtrecommendlevel.text = HeroConfig.instance:getCommonLevelDisplay(slot9)
	elseif #slot4 > 0 then
		slot0._txtrecommendlevel.text = HeroConfig.instance:getCommonLevelDisplay(slot9)
	else
		slot0._txtrecommendlevel.text = ""
	end
end

function slot0._recommendCareer(slot0)
	slot1, slot2 = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(slot0, slot0._onRecommendCareerItemShow, slot1, gohelper.findChild(slot0._gorecommendattr.gameObject, "attrlist"), slot0._goattritem)

	if #slot1 == 0 then
		slot0._txtrecommonddes.text = luaLang("new_common_none")
	else
		slot0._txtrecommonddes.text = ""
	end
end

function slot0._onRecommendCareerItemShow(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setHeroGroupSprite(gohelper.findChildImage(slot1, "icon"), "career_" .. slot2)
end

function slot0._onEnemyItemShow(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot1, "icon"), "lssx_" .. tostring(slot2.career))

	gohelper.findChildTextMesh(slot1, "enemycount").text = slot2.count > 1 and luaLang("multiple") .. slot2.count or ""

	gohelper.setActive(gohelper.findChild(slot1, "icon/kingIcon"), slot3 <= slot0._enemyBossEndIndex)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0._recommendCareer, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
