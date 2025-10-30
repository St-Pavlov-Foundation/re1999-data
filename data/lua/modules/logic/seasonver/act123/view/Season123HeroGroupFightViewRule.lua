﻿-- chunkname: @modules/logic/seasonver/act123/view/Season123HeroGroupFightViewRule.lua

module("modules.logic.seasonver.act123.view.Season123HeroGroupFightViewRule", package.seeall)

local Season123HeroGroupFightViewRule = class("Season123HeroGroupFightViewRule", BaseView)

function Season123HeroGroupFightViewRule:onInitView()
	self._gorules = gohelper.findChild(self.viewGO, "#go_container/infocontain/#go_rules")
	self._goimagenormal = gohelper.findChild(self.viewGO, "#go_container/infocontain/#go_rules/title/text/#image_normalicondition")
	self._goimagerare = gohelper.findChild(self.viewGO, "#go_container/infocontain/#go_rules/title/text/#image_rarecondition")
	self._goruleitem = gohelper.findChild(self.viewGO, "#go_container/infocontain/#go_rules/rulelist/#go_ruleitem")
	self._gonormal = gohelper.findChild(self.viewGO, "#go_container/infocontain/#go_rules/rulelist/#go_ruleitem/image_normal")
	self._gorare = gohelper.findChild(self.viewGO, "#go_container/infocontain/#go_rules/rulelist/#go_ruleitem/image_rare")
	self._txtruleinfo = gohelper.findChildText(self.viewGO, "#go_container/infocontain/#go_rules/rulelist/#go_ruleitem/txt_ruleinfo")
	self._goadditionRule = gohelper.findChild(self.viewGO, "#go_container/infocontain/#go_additionRule")
	self._goruletemp = gohelper.findChild(self.viewGO, "#go_container/infocontain/#go_additionRule/#go_ruletemp")
	self._imagetagicon = gohelper.findChildImage(self.viewGO, "#go_container/infocontain/#go_additionRule/#go_ruletemp/#image_tagicon")
	self._gorulelist = gohelper.findChild(self.viewGO, "#go_container/infocontain/#go_additionRule/#go_rulelist")
	self._btnadditionRuleclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/infocontain/#go_additionRule/#go_rulelist/#btn_additionRuleclick")
	self._gocontainer2 = gohelper.findChild(self.viewGO, "#go_container2")
	self._goruledesc = gohelper.findChild(self.viewGO, "#go_container2/#go_ruledesc")
	self._btncloserule = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container2/#go_ruledesc/#btn_closerule")
	self._goruleitem2 = gohelper.findChild(self.viewGO, "#go_container2/#go_ruledesc/bg/#go_ruleitem")
	self._goruleDescList = gohelper.findChild(self.viewGO, "#go_container2/#go_ruledesc/bg/#go_ruleDescList")
	self._btnenemy = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/infocontain/enemycontain/enemytitle/txten/#btn_enemy")
	self._enemylist = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/infocontain/enemycontain/enemyList/#go_enemyteam/enemyList")
	self._txtrecommendlevel = gohelper.findChildText(self.viewGO, "#go_container/infocontain/enemycontain/recommendtxt/#txt_recommendLevel")
	self._goenemyteam = gohelper.findChild(self.viewGO, "#go_container/infocontain/enemycontain/enemyList/#go_enemyteam")
	self._gorecommendattr = gohelper.findChild(self.viewGO, "#go_container/infocontain/enemycontain/#go_recommendAttr")
	self._goattritem = gohelper.findChild(self.viewGO, "#go_container/infocontain/enemycontain/#go_recommendAttr/attrlist/#go_attritem")
	self._txtrecommonddes = gohelper.findChildTextMesh(self.viewGO, "#go_container/infocontain/enemycontain/#go_recommendAttr/#txt_recommonddes")
	self._btnadditionruledetail = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/infocontain/#go_additionRule/#go_additionruletips/tips/#btn_additionruledetail")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123HeroGroupFightViewRule:addEvents()
	self._btnadditionRuleclick:AddClickListener(self._btnadditionRuleOnClick, self)
	self._btncloserule:AddClickListener(self._btncloseruleOnClick, self)
	self._btnenemy:AddClickListener(self._btnenemyOnClick, self)
	self._enemylist:AddClickListener(self._btnenemyOnClick, self)
	self._btnadditionruledetail:AddClickListener(self._btnAdditionRuleDetailOnClick, self)
end

function Season123HeroGroupFightViewRule:removeEvents()
	self._btnadditionRuleclick:RemoveClickListener()
	self._btncloserule:RemoveClickListener()
	self._btnenemy:RemoveClickListener()
	self._enemylist:RemoveClickListener()
	self._btnadditionruledetail:RemoveClickListener()
end

function Season123HeroGroupFightViewRule:_btncloseruleOnClick()
	if self._ruleItemClick then
		self._ruleItemClick = false

		return
	end

	gohelper.setActive(self._goruledesc, false)
end

function Season123HeroGroupFightViewRule:_btnadditionRuleOnClick()
	if not self._hasRuleList then
		return
	end

	self._ruleItemClick = self._goruledesc.activeSelf

	gohelper.setActive(self._gocontainer2, true)
	gohelper.setActive(self._goruledesc, true)
end

function Season123HeroGroupFightViewRule:_btnenemyOnClick()
	EnemyInfoController.instance:openSeason123EnemyInfoViewWithNoTab(Season123HeroGroupModel.instance.activityId, HeroGroupModel.instance.battleId)
end

function Season123HeroGroupFightViewRule:_btnAdditionRuleDetailOnClick()
	local actId = Season123HeroGroupModel.instance.activityId
	local stage = Season123HeroGroupModel.instance.stage
	local param = {
		actId = actId,
		stage = stage
	}

	Season123Controller.instance:openSeasonAdditionRuleTipView(param)
end

function Season123HeroGroupFightViewRule:_editableInitView()
	gohelper.addUIClickAudio(self._btnenemy.gameObject, AudioEnum.UI.play_ui_formation_monstermessage)
	gohelper.setActive(self._goruleitem2, false)
	gohelper.setActive(self._goruletemp, false)
	gohelper.setActive(self._goruledesc, false)

	self._monsterGroupItemList = {}
	self._rulesimageList = self:getUserDataTb_()
	self._rulesimagelineList = self:getUserDataTb_()
	self._simageList = self:getUserDataTb_()
end

function Season123HeroGroupFightViewRule:onOpen()
	self:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._recommendCareer, self)
	self:_refreshUI()
end

function Season123HeroGroupFightViewRule:_refreshUI()
	self:_refreshRules()
	self:_refreshAddition()
	self:_refreshEnemy()
	self:_recommendCareer()
end

function Season123HeroGroupFightViewRule:_refreshRules()
	local episodeId = HeroGroupModel.instance.episodeId
	local isRetail = DungeonConfig.instance:getEpisodeCO(episodeId).type == DungeonEnum.EpisodeType.Season123Retail
	local retailMo = Season123Model.instance:getEpisodeRetail(episodeId)

	gohelper.setActive(self._goruleitem, true)

	if isRetail and retailMo then
		gohelper.setActive(self._gorules, isRetail and retailMo.advancedId ~= 0)
		gohelper.setActive(self._goimagenormal, retailMo.advancedRare == 1)
		gohelper.setActive(self._goimagerare, retailMo.advancedRare == 2)
		gohelper.setActive(self._gonormal, retailMo.advancedRare == 1)
		gohelper.setActive(self._gorare, retailMo.advancedRare == 2)

		if retailMo.advancedId and retailMo.advancedId ~= 0 then
			self._txtruleinfo.text = lua_condition.configDict[retailMo.advancedId].desc
		else
			self._txtruleinfo.text = ""
		end
	else
		gohelper.setActive(self._gorules, false)
	end
end

function Season123HeroGroupFightViewRule:_refreshAddition()
	local episodeId = HeroGroupModel.instance.episodeId
	local additionRule = DungeonConfig.instance:getEpisodeAdditionRule(episodeId)
	local ruleList = GameUtil.splitString2(additionRule, true, "|", "#")

	if not ruleList or #ruleList == 0 then
		gohelper.setActive(self._goadditionRule, false)

		return
	end

	ruleList = Season123HeroGroupModel.filterRule(Season123HeroGroupModel.instance.activityId, ruleList)

	if Season123HeroGroupModel.instance.stage then
		ruleList = Season123Config.instance:filterRule(ruleList, Season123HeroGroupModel.instance.stage)
	end

	self._hasRuleList = #ruleList > 0

	gohelper.setActive(self._goadditionRule, true)

	for i, v in ipairs(ruleList) do
		local targetId = v[1]
		local ruleId = v[2]
		local ruleCo = lua_rule.configDict[ruleId]

		if ruleCo then
			self:_addRuleItem(ruleCo, targetId)
			self:_setRuleDescItem(ruleCo, targetId)
		end

		if i == #ruleList then
			gohelper.setActive(self._rulesimagelineList[i], false)
		end
	end
end

function Season123HeroGroupFightViewRule:_addRuleItem(ruleCo, targetId)
	local go = gohelper.clone(self._goruletemp, self._gorulelist, ruleCo.id)

	gohelper.setActive(go, true)

	local tagicon = gohelper.findChildImage(go, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(tagicon, "wz_" .. targetId)

	local simage = gohelper.findChildImage(go, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(simage, ruleCo.icon)
end

function Season123HeroGroupFightViewRule:_setRuleDescItem(ruleCo, targetId)
	local tagColor = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	local go = gohelper.clone(self._goruleitem2, self._goruleDescList, ruleCo.id)

	gohelper.setActive(go, true)

	local icon = gohelper.findChildImage(go, "icon")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(icon, ruleCo.icon)

	local line = gohelper.findChild(go, "line")

	table.insert(self._rulesimagelineList, line)

	local tag = gohelper.findChildImage(go, "tag")

	UISpriteSetMgr.instance:setCommonSprite(tag, "wz_" .. targetId)

	local desc = gohelper.findChildText(go, "desc")

	SkillHelper.addHyperLinkClick(desc)

	local srcDesc = ruleCo.desc
	local descContent = SkillHelper.buildDesc(srcDesc, nil, "#6680bd")
	local wordContent = "\n" .. SkillHelper.getTagDescRecursion(srcDesc, "#6680bd")
	local side = luaLang("dungeon_add_rule_target_" .. targetId)
	local color = tagColor[targetId]

	desc.text = string.format("<color=%s>[%s]</color>%s%s", color, side, descContent, wordContent)
end

function Season123HeroGroupFightViewRule:_refreshEnemy()
	local fightParam = FightModel.instance:getFightParam()
	local bossCareerDict = {}
	local enemyCareerDict = {}
	local enemyList = {}
	local enemyBossList = {}

	for i, v in ipairs(fightParam.monsterGroupIds) do
		local bossId = lua_monster_group.configDict[v].bossId
		local ids = string.splitToNumber(lua_monster_group.configDict[v].monster, "#")

		for index, id in ipairs(ids) do
			local enemyCareer = lua_monster.configDict[id].career

			if id == bossId then
				bossCareerDict[enemyCareer] = (bossCareerDict[enemyCareer] or 0) + 1

				table.insert(enemyBossList, id)
			else
				enemyCareerDict[enemyCareer] = (enemyCareerDict[enemyCareer] or 0) + 1

				table.insert(enemyList, id)
			end
		end
	end

	local enemyCareerList = {}

	for k, v in pairs(bossCareerDict) do
		table.insert(enemyCareerList, {
			career = k,
			count = v
		})
	end

	self._enemyBossEndIndex = #enemyCareerList

	for k, v in pairs(enemyCareerDict) do
		table.insert(enemyCareerList, {
			career = k,
			count = v
		})
	end

	gohelper.CreateObjList(self, self._onEnemyItemShow, enemyCareerList, gohelper.findChild(self._goenemyteam, "enemyList"), gohelper.findChild(self._goenemyteam, "enemyList/go_enemyitem"))

	local episodeId = DungeonModel.instance.curSendEpisodeId
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)
	local level = 0

	if episodeConfig.type == DungeonEnum.EpisodeType.Season123 then
		local episodeCfg = Season123Config.instance:getSeasonEpisodeCo(Season123HeroGroupModel.instance.activityId, Season123HeroGroupModel.instance.stage, Season123HeroGroupModel.instance.layer)

		if episodeCfg then
			level = episodeCfg.level
		end
	else
		level = FightHelper.getBattleRecommendLevel(episodeConfig.battleId)
	end

	if #enemyBossList > 0 then
		self._txtrecommendlevel.text = HeroConfig.instance:getCommonLevelDisplay(level)
	elseif #enemyList > 0 then
		self._txtrecommendlevel.text = HeroConfig.instance:getCommonLevelDisplay(level)
	else
		self._txtrecommendlevel.text = ""
	end
end

function Season123HeroGroupFightViewRule:_recommendCareer()
	local recommended, counter = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(self, self._onRecommendCareerItemShow, recommended, gohelper.findChild(self._gorecommendattr.gameObject, "attrlist"), self._goattritem)

	if #recommended == 0 then
		self._txtrecommonddes.text = luaLang("new_common_none")
	else
		self._txtrecommonddes.text = ""
	end
end

function Season123HeroGroupFightViewRule:_onRecommendCareerItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(icon, "career_" .. data)
end

function Season123HeroGroupFightViewRule:_onEnemyItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")
	local kingIcon = gohelper.findChild(obj, "icon/kingIcon")
	local enemy_count = gohelper.findChildTextMesh(obj, "enemycount")

	UISpriteSetMgr.instance:setCommonSprite(icon, "lssx_" .. tostring(data.career))

	enemy_count.text = data.count > 1 and luaLang("multiple") .. data.count or ""

	gohelper.setActive(kingIcon, index <= self._enemyBossEndIndex)
end

function Season123HeroGroupFightViewRule:onClose()
	self:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._recommendCareer, self)
end

function Season123HeroGroupFightViewRule:onDestroyView()
	return
end

return Season123HeroGroupFightViewRule
