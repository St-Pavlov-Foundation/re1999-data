﻿-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity_1_2_HeroGroupEditView.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_HeroGroupEditView", package.seeall)

local VersionActivity_1_2_HeroGroupEditView = class("VersionActivity_1_2_HeroGroupEditView", BaseView)

function VersionActivity_1_2_HeroGroupEditView:onInitView()
	self._gononecharacter = gohelper.findChild(self.viewGO, "characterinfo/#go_nonecharacter")
	self._gocharacterinfo = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo")
	self._imagedmgtype = gohelper.findChildImage(self.viewGO, "characterinfo/#go_characterinfo/#image_dmgtype")
	self._imagecareericon = gohelper.findChildImage(self.viewGO, "characterinfo/#go_characterinfo/career/#image_careericon")
	self._txtname = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/name/#txt_name")
	self._txtnameen = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/name/#txt_nameen")
	self._gospecialitem = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/special/#go_specialitem")
	self._txtlevel = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/level/#txt_level")
	self._txtlevelmax = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/level/#txt_level/#txt_levelmax")
	self._btncharacter = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/level/#btn_character")
	self._btntrial = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/level/#btn_trial")
	self._btnattribute = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/attribute/#btn_attribute")
	self._goattribute = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/attribute/#go_attribute")
	self._goskill = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/#go_skill")
	self._btnpassiveskill = gohelper.findChildButtonWithAudio(self.viewGO, "characterinfo/#go_characterinfo/passiveskill/#btn_passiveskill")
	self._txtpassivename = gohelper.findChildText(self.viewGO, "characterinfo/#go_characterinfo/passiveskill/bg/#txt_passivename")
	self._gopassiveskills = gohelper.findChild(self.viewGO, "characterinfo/#go_characterinfo/passiveskill/#go_passiveskills")
	self._gorolecontainer = gohelper.findChild(self.viewGO, "#go_rolecontainer")
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "#go_rolecontainer/#scroll_card")
	self._goScrollContent = gohelper.findChild(self.viewGO, "#go_rolecontainer/#scroll_card/scrollcontent")
	self._scrollquickedit = gohelper.findChildScrollRect(self.viewGO, "#go_rolecontainer/#scroll_quickedit")
	self._gorolesort = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort")
	self._btnlvrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_lvrank")
	self._btnrarerank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	self._btnexskillrank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank")
	self._btnclassify = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify")
	self._btnquickedit = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_quickedit")
	self._goexarrow = gohelper.findChild(self.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank/#go_exarrow")
	self._gosearchfilter = gohelper.findChild(self.viewGO, "#go_searchfilter")
	self._btnclosefilterview = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/#btn_closefilterview")
	self._godmgitem = gohelper.findChild(self.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/dmgContainer/#go_dmgitem")
	self._goattritem = gohelper.findChild(self.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/attrContainer/#go_attritem")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/container/#btn_reset")
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/container/#btn_ok")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ops/#btn_confirm")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ops/#btn_cancel")
	self._txtrecommendAttrDesc = gohelper.findChildText(self.viewGO, "#go_recommendAttr/bg/#txt_desc")
	self._goattrlist = gohelper.findChild(self.viewGO, "#go_recommendAttr/bg/#go_attrlist")
	self._goattritem = gohelper.findChild(self.viewGO, "#go_recommendAttr/bg/#go_attrlist/#go_attritem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity_1_2_HeroGroupEditView:addEvents()
	self._btnlvrank:AddClickListener(self._btnlvrankOnClick, self)
	self._btnrarerank:AddClickListener(self._btnrarerankOnClick, self)
	self._btnexskillrank:AddClickListener(self._btnexskillrankOnClick, self)
	self._btnclassify:AddClickListener(self._btnclassifyOnClick, self)
	self._btncharacter:AddClickListener(self._btncharacterOnClick, self)
	self._btntrial:AddClickListener(self._btntrialOnClick, self)
	self._btnattribute:AddClickListener(self._btnattributeOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btnpassiveskill:AddClickListener(self._btnpassiveskillOnClick, self)
	self._btnquickedit:AddClickListener(self._btnquickeditOnClick, self)
	self._btnclosefilterview:AddClickListener(self._btncloseFilterViewOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnok:AddClickListener(self._btnokOnClick, self)
end

function VersionActivity_1_2_HeroGroupEditView:removeEvents()
	self._btnlvrank:RemoveClickListener()
	self._btnrarerank:RemoveClickListener()
	self._btnexskillrank:RemoveClickListener()
	self._btnclassify:RemoveClickListener()
	self._btncharacter:RemoveClickListener()
	self._btntrial:RemoveClickListener()
	self._btnattribute:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self._btnpassiveskill:RemoveClickListener()
	self._btnquickedit:RemoveClickListener()
	self._btnclosefilterview:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnok:RemoveClickListener()
end

function VersionActivity_1_2_HeroGroupEditView:_btncloseFilterViewOnClick()
	self._selectDmgs = LuaUtil.deepCopy(self._curDmgs)
	self._selectAttrs = LuaUtil.deepCopy(self._curAttrs)
	self._selectLocations = LuaUtil.deepCopy(self._curLocations)

	self:_refreshBtnIcon()
	gohelper.setActive(self._gosearchfilter, false)
end

function VersionActivity_1_2_HeroGroupEditView:_btnclassifyOnClick()
	gohelper.setActive(self._gosearchfilter, true)
	self:_refreshFilterView()
end

function VersionActivity_1_2_HeroGroupEditView:_btnresetOnClick()
	for i = 1, 2 do
		self._selectDmgs[i] = false
	end

	for i = 1, 6 do
		self._selectAttrs[i] = false
	end

	for i = 1, 6 do
		self._selectLocations[i] = false
	end

	self:_refreshBtnIcon()
	self:_refreshFilterView()
end

function VersionActivity_1_2_HeroGroupEditView:_btnokOnClick()
	gohelper.setActive(self._gosearchfilter, false)

	local dmgs = {}

	for i = 1, 2 do
		if self._selectDmgs[i] then
			table.insert(dmgs, i)
		end
	end

	local careers = {}

	for i = 1, 6 do
		if self._selectAttrs[i] then
			table.insert(careers, i)
		end
	end

	local locations = {}

	for i = 1, 6 do
		if self._selectLocations[i] then
			table.insert(locations, i)
		end
	end

	if #dmgs == 0 then
		dmgs = {
			1,
			2
		}
	end

	if #careers == 0 then
		careers = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #locations == 0 then
		locations = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, 0)

	local filterParam = {}

	filterParam.dmgs = dmgs
	filterParam.careers = careers
	filterParam.locations = locations

	CharacterModel.instance:filterCardListByDmgAndCareer(filterParam, false, CharacterEnum.FilterType.HeroGroup)
	HeroGroupTrialModel.instance:setFilter(dmgs, careers)

	self._curDmgs = LuaUtil.deepCopy(self._selectDmgs)
	self._curAttrs = LuaUtil.deepCopy(self._selectAttrs)
	self._curLocations = LuaUtil.deepCopy(self._selectLocations)

	self:_refreshBtnIcon()
	self:_refreshCurScrollBySort()
	ViewMgr.instance:closeView(ViewName.CharacterLevelUpView)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function VersionActivity_1_2_HeroGroupEditView:_btnpassiveskillOnClick()
	if not self._heroMO then
		return
	end

	local info = {}

	info.tag = "passiveskill"
	info.heroid = self._heroMO.heroId
	info.heroMo = self._heroMO
	info.tipPos = Vector2.New(851, -59)
	info.buffTipsX = 1603
	info.anchorParams = {
		Vector2.New(0, 0.5),
		Vector2.New(0, 0.5)
	}

	CharacterController.instance:openCharacterTipView(info)
end

function VersionActivity_1_2_HeroGroupEditView:_btnconfirmOnClick()
	if self._adventure then
		local newHeroUids = HeroGroupQuickEditListModel.instance:getHeroUids()

		if newHeroUids and #newHeroUids > 0 then
			for k, heroUid in pairs(newHeroUids) do
				local mo = HeroModel.instance:getById(heroUid)

				if mo then
					local cd = WeekWalkModel.instance:getCurMapHeroCd(mo.heroId)

					if cd > 0 then
						GameFacade.showToast(ToastEnum.HeroGroupEdit)

						return
					end
				end
			end
		elseif self._heroMO then
			local cd = WeekWalkModel.instance:getCurMapHeroCd(self._heroMO.heroId)

			if cd > 0 then
				GameFacade.showToast(ToastEnum.HeroGroupEdit)

				return
			end
		end
	end

	if self._isShowQuickEdit then
		self:_saveQuickGroupInfo()
		self:closeThis()

		return
	end

	if not self:_normalEditHasChange() then
		self:closeThis()

		return
	end

	local singleGroupMO = HeroSingleGroupModel.instance:getById(self._singleGroupMOId)

	if singleGroupMO.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if self._heroMO then
		if self._heroMO.isPosLock then
			GameFacade.showToast(ToastEnum.TrialCantTakeOff)

			return
		end

		if self._heroMO:isTrial() and not HeroSingleGroupModel.instance:isInGroup(self._heroMO.uid) and (singleGroupMO:isEmpty() or not singleGroupMO.trial) and HeroGroupEditListModel.instance:isTrialLimit() then
			GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

			return
		end

		local hasHero, hasHeroIndex = HeroSingleGroupModel.instance:hasHeroUids(self._heroMO.uid, self._singleGroupMOId)

		if hasHero then
			HeroSingleGroupModel.instance:removeFrom(hasHeroIndex)
			HeroSingleGroupModel.instance:addTo(self._heroMO.uid, self._singleGroupMOId)

			if self._heroMO:isTrial() then
				singleGroupMO:setTrial(self._heroMO.trialCo.id, self._heroMO.trialCo.trialTemplate)
			else
				singleGroupMO:setTrial()
			end

			FightAudioMgr.instance:playHeroVoiceRandom(self._heroMO.heroId, CharacterEnum.VoiceType.HeroGroup)
			self:_saveCurGroupInfo()
			self:closeThis()

			return
		end

		if HeroSingleGroupModel.instance:isAidConflict(self._heroMO.heroId) then
			GameFacade.showToast(ToastEnum.HeroIsAidConflict)

			return
		end

		HeroSingleGroupModel.instance:addTo(self._heroMO.uid, self._singleGroupMOId)

		if self._heroMO:isTrial() then
			singleGroupMO:setTrial(self._heroMO.trialCo.id, self._heroMO.trialCo.trialTemplate)
		else
			singleGroupMO:setTrial()
		end

		FightAudioMgr.instance:playHeroVoiceRandom(self._heroMO.heroId, CharacterEnum.VoiceType.HeroGroup)
		self:_saveCurGroupInfo()
		self:closeThis()
	else
		HeroSingleGroupModel.instance:removeFrom(self._singleGroupMOId)
		self:_saveCurGroupInfo()
		self:closeThis()
	end
end

function VersionActivity_1_2_HeroGroupEditView:checkTrialNum()
	return false
end

function VersionActivity_1_2_HeroGroupEditView:_btncancelOnClick()
	self:closeThis()
end

function VersionActivity_1_2_HeroGroupEditView:_btncharacterOnClick()
	if self._heroMO then
		local heroMoList

		if self._isShowQuickEdit then
			heroMoList = HeroGroupQuickEditListModel.instance:getList()
		else
			heroMoList = HeroGroupEditListModel.instance:getList()
		end

		local newList = {}

		for k, heroMo in ipairs(heroMoList) do
			if not heroMo:isTrial() then
				table.insert(newList, heroMo)
			end
		end

		CharacterController.instance:openCharacterView(self._heroMO, newList)
	end
end

function VersionActivity_1_2_HeroGroupEditView:_btntrialOnClick()
	if self._heroMO then
		local heroMoList

		if self._isShowQuickEdit then
			heroMoList = HeroGroupQuickEditListModel.instance:getList()
		else
			heroMoList = HeroGroupEditListModel.instance:getList()
		end

		local newList = {}

		for k, heroMo in ipairs(heroMoList) do
			if heroMo:isTrial() then
				table.insert(newList, heroMo)
			end
		end

		CharacterController.instance:openCharacterView(self._heroMO, newList)
	end
end

function VersionActivity_1_2_HeroGroupEditView:_btnexskillrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByExSkill(false, CharacterEnum.FilterType.HeroGroup)
	self:_refreshCurScrollBySort()
	self:_refreshBtnIcon()
end

function VersionActivity_1_2_HeroGroupEditView:_btnlvrankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByLevel(false, CharacterEnum.FilterType.HeroGroup)
	self:_refreshCurScrollBySort()
	self:_refreshBtnIcon()
end

function VersionActivity_1_2_HeroGroupEditView:_btnrarerankOnClick()
	local x, y = transformhelper.getLocalPos(self._goScrollContent.transform)

	transformhelper.setLocalPosXY(self._goScrollContent.transform, x, self._initScrollContentPosY)
	CharacterModel.instance:setCardListByRare(false, CharacterEnum.FilterType.HeroGroup)
	self:_refreshCurScrollBySort()
	self:_refreshBtnIcon()
end

function VersionActivity_1_2_HeroGroupEditView:_btnquickeditOnClick()
	self._isShowQuickEdit = not self._isShowQuickEdit

	self:_refreshBtnIcon()
	self:_refreshEditMode()

	if self._isShowQuickEdit then
		self:_onHeroItemClick(nil)
		HeroGroupQuickEditListModel.instance:cancelAllSelected()
		HeroGroupQuickEditListModel.instance:copyQuickEditCardList()

		local mo = HeroGroupQuickEditListModel.instance:getById(self._originalHeroUid)

		if mo then
			local index = HeroGroupQuickEditListModel.instance:getIndex(mo)

			HeroGroupQuickEditListModel.instance:selectCell(index, true)
		end
	else
		self:_saveQuickGroupInfo()
		self:_onHeroItemClick(nil)
		HeroGroupEditListModel.instance:cancelAllSelected()

		local curHeroUid = HeroSingleGroupModel.instance:getHeroUid(self._singleGroupMOId)

		if curHeroUid ~= "0" then
			local mo = HeroGroupEditListModel.instance:getById(curHeroUid)
			local index = HeroGroupEditListModel.instance:getIndex(mo)

			HeroGroupEditListModel.instance:selectCell(index, true)
		end

		HeroGroupEditListModel.instance:copyCharacterCardList()
	end
end

function VersionActivity_1_2_HeroGroupEditView:_attrBtnOnClick(i)
	self._selectAttrs[i] = not self._selectAttrs[i]

	self:_refreshFilterView()
end

function VersionActivity_1_2_HeroGroupEditView:_dmgBtnOnClick(i)
	if not self._selectDmgs[i] then
		self._selectDmgs[3 - i] = self._selectDmgs[i]
	end

	self._selectDmgs[i] = not self._selectDmgs[i]

	self:_refreshFilterView()
end

function VersionActivity_1_2_HeroGroupEditView:_locationBtnOnClick(i)
	self._selectLocations[i] = not self._selectLocations[i]

	self:_refreshFilterView()
end

function VersionActivity_1_2_HeroGroupEditView:_onHeroItemClick(heroMO)
	self._heroMO = heroMO

	self:_refreshCharacterInfo()
end

function VersionActivity_1_2_HeroGroupEditView:_refreshCharacterInfo()
	if self._heroMO then
		gohelper.setActive(self._gononecharacter, false)
		gohelper.setActive(self._gocharacterinfo, true)
		self:_refreshSkill()
		self:_refreshMainInfo()
		self:_refreshAttribute()
		self:_refreshPassiveSkill()
	else
		gohelper.setActive(self._gononecharacter, true)
		gohelper.setActive(self._gocharacterinfo, false)
	end
end

function VersionActivity_1_2_HeroGroupEditView:_refreshMainInfo()
	if self._heroMO then
		gohelper.setActive(self._btntrial.gameObject, self._heroMO:isTrial())
		UISpriteSetMgr.instance:setCommonSprite(self._imagecareericon, "sx_biandui_" .. tostring(self._heroMO.config.career))
		UISpriteSetMgr.instance:setCommonSprite(self._imagedmgtype, "dmgtype" .. tostring(self._heroMO.config.dmgType))

		self._txtname.text = self._heroMO.config.name
		self._txtnameen.text = self._heroMO.config.nameEng

		local maxLevel = CharacterModel.instance:getrankEffects(self._heroMO.heroId, self._heroMO.rank)[1]
		local showLevel = HeroConfig.instance:getShowLevel(self._heroMO.level)
		local showMaxLevel = HeroConfig.instance:getShowLevel(maxLevel)

		self._txtlevel.text = tostring(showLevel)
		self._txtlevelmax.text = string.format("/%d", showMaxLevel)

		local tags = {}

		if not string.nilorempty(self._heroMO.config.battleTag) then
			tags = string.split(self._heroMO.config.battleTag, "#")
		end

		for i = 1, #tags do
			local careerTable = self._careerGOs[i]

			if not careerTable then
				careerTable = self:getUserDataTb_()
				careerTable.go = gohelper.cloneInPlace(self._gospecialitem, "item" .. i)
				careerTable.textfour = gohelper.findChildText(careerTable.go, "#go_fourword/name")
				careerTable.textthree = gohelper.findChildText(careerTable.go, "#go_threeword/name")
				careerTable.texttwo = gohelper.findChildText(careerTable.go, "#go_twoword/name")
				careerTable.containerfour = gohelper.findChild(careerTable.go, "#go_fourword")
				careerTable.containerthree = gohelper.findChild(careerTable.go, "#go_threeword")
				careerTable.containertwo = gohelper.findChild(careerTable.go, "#go_twoword")

				table.insert(self._careerGOs, careerTable)
			end

			local desc = HeroConfig.instance:getBattleTagConfigCO(tags[i]).tagName
			local wordCount = GameUtil.utf8len(desc)

			gohelper.setActive(careerTable.containertwo, wordCount <= 2)
			gohelper.setActive(careerTable.containerthree, wordCount == 3)
			gohelper.setActive(careerTable.containerfour, wordCount >= 4)

			if wordCount <= 2 then
				careerTable.texttwo.text = desc
			elseif wordCount == 3 then
				careerTable.textthree.text = desc
			else
				careerTable.textfour.text = desc
			end

			gohelper.setActive(careerTable.go, true)
		end

		for i = #tags + 1, #self._careerGOs do
			gohelper.setActive(self._careerGOs[i].go, false)
		end
	end
end

function VersionActivity_1_2_HeroGroupEditView:_refreshPassiveSkill()
	if not self._heroMO then
		return
	end

	local pskills = SkillConfig.instance:getpassiveskillsCO(self._heroMO.heroId)
	local firstSkill = pskills[1]
	local skillId = firstSkill.skillPassive
	local passiveSkillConfig = lua_skill.configDict[skillId]

	if not passiveSkillConfig then
		logError("找不到角色被动技能, skillId: " .. tostring(skillId))
	else
		self._txtpassivename.text = passiveSkillConfig.name
	end

	for i = 1, #pskills do
		local unlock = CharacterModel.instance:isPassiveUnlockByHeroMo(self._heroMO, i)

		gohelper.setActive(self._passiveskillitems[i].on, unlock)
		gohelper.setActive(self._passiveskillitems[i].off, not unlock)
		gohelper.setActive(self._passiveskillitems[i].go, true)
	end

	for i = #pskills + 1, #self._passiveskillitems do
		gohelper.setActive(self._passiveskillitems[i].go, false)
	end
end

function VersionActivity_1_2_HeroGroupEditView:_refreshSkill()
	self._skillContainer:onUpdateMO(self._heroMO and self._heroMO.heroId, nil, self._heroMO)
end

function VersionActivity_1_2_HeroGroupEditView:_refreshBtnIcon()
	local state = CharacterModel.instance:getRankState()
	local tag = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.HeroGroup)

	gohelper.setActive(self._lvBtns[1], tag ~= 1)
	gohelper.setActive(self._lvBtns[2], tag == 1)
	gohelper.setActive(self._rareBtns[1], tag ~= 2)
	gohelper.setActive(self._rareBtns[2], tag == 2)

	local hasFilter = false

	for _, v in pairs(self._selectDmgs) do
		if v then
			hasFilter = true
		end
	end

	for _, v in pairs(self._selectAttrs) do
		if v then
			hasFilter = true
		end
	end

	for _, v in pairs(self._selectLocations) do
		if v then
			hasFilter = true
		end
	end

	gohelper.setActive(self._classifyBtns[1], not hasFilter)
	gohelper.setActive(self._classifyBtns[2], hasFilter)
	HeroGroupTrialModel.instance:sortByLevelAndRare(tag == 1, state[tag] == 1)
	transformhelper.setLocalScale(self._lvArrow[1], 1, state[1], 1)
	transformhelper.setLocalScale(self._lvArrow[2], 1, state[1], 1)
	transformhelper.setLocalScale(self._rareArrow[1], 1, state[2], 1)
	transformhelper.setLocalScale(self._rareArrow[2], 1, state[2], 1)
end

function VersionActivity_1_2_HeroGroupEditView:_refreshFilterView()
	for i = 1, 2 do
		gohelper.setActive(self._dmgUnselects[i], not self._selectDmgs[i])
		gohelper.setActive(self._dmgSelects[i], self._selectDmgs[i])
	end

	for i = 1, 6 do
		gohelper.setActive(self._attrUnselects[i], not self._selectAttrs[i])
		gohelper.setActive(self._attrSelects[i], self._selectAttrs[i])
	end

	for i = 1, 6 do
		gohelper.setActive(self._locationUnselects[i], not self._selectLocations[i])
		gohelper.setActive(self._locationSelects[i], self._selectLocations[i])
	end
end

function VersionActivity_1_2_HeroGroupEditView:_updateHeroList()
	local dmgs = {}

	for i = 1, 2 do
		if self._selectDmgs[i] then
			table.insert(dmgs, i)
		end
	end

	local careers = {}

	for i = 1, 6 do
		if self._selectAttrs[i] then
			table.insert(careers, i)
		end
	end

	local locations = {}

	for i = 1, 6 do
		if self._selectLocations[i] then
			table.insert(locations, i)
		end
	end

	if #dmgs == 0 then
		dmgs = {
			1,
			2
		}
	end

	if #careers == 0 then
		careers = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #locations == 0 then
		locations = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local filterParam = {}

	filterParam.dmgs = dmgs
	filterParam.careers = careers
	filterParam.locations = locations

	CharacterModel.instance:filterCardListByDmgAndCareer(filterParam, false, CharacterEnum.FilterType.HeroGroup)
	self:_refreshBtnIcon()

	if self._isShowQuickEdit then
		HeroGroupQuickEditListModel.instance:copyQuickEditCardList()
	else
		HeroGroupEditListModel.instance:copyCharacterCardList()
	end
end

function VersionActivity_1_2_HeroGroupEditView:replaceSelectHeroDefaultEquip()
	if self._heroMO and self._heroMO:hasDefaultEquip() then
		local heroGroupMo = HeroGroupModel.instance:getCurGroupMO()
		local heroGroupEquipMoList = heroGroupMo.equips

		for i, heroGroupEquipMo in pairs(heroGroupEquipMoList) do
			if heroGroupEquipMo.equipUid[1] == self._heroMO.defaultEquipUid then
				heroGroupEquipMo.equipUid[1] = "0"

				break
			end
		end

		heroGroupEquipMoList[self._singleGroupMOId - 1].equipUid[1] = self._heroMO.defaultEquipUid
	end
end

function VersionActivity_1_2_HeroGroupEditView:replaceQuickGroupHeroDefaultEquip(heroUids)
	local heroGroupMo = HeroGroupModel.instance:getCurGroupMO()
	local heroGroupEquipMoList = heroGroupMo.equips
	local heroMo

	for index, heroUid in ipairs(heroUids) do
		heroMo = HeroModel.instance:getById(heroUid)

		if heroMo and heroMo:hasDefaultEquip() then
			for _, heroGroupEquipMo in ipairs(heroGroupEquipMoList) do
				if heroGroupEquipMo.equipUid[1] == heroMo.defaultEquipUid then
					heroGroupEquipMo.equipUid[1] = "0"

					break
				end
			end

			heroGroupEquipMoList[index - 1].equipUid[1] = heroMo.defaultEquipUid
		end
	end
end

function VersionActivity_1_2_HeroGroupEditView:_saveCurGroupInfo()
	local newHeroUids = HeroSingleGroupModel.instance:getHeroUids()
	local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()

	self:replaceSelectHeroDefaultEquip()

	if Activity104Model.instance:isSeasonChapter() then
		local actId = ActivityEnum.Activity.Season
		local subId = Activity104Model.instance:getSeasonCurSnapshotSubId(actId)
		local extraData = {}

		extraData.groupIndex = subId
		heroGroupMO.heroList = newHeroUids
		extraData.heroGroup = heroGroupMO

		HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season, DungeonModel.instance.curSendEpisodeId, true, extraData)
	else
		HeroGroupModel.instance:replaceSingleGroup()
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		HeroGroupModel.instance:saveCurGroupData()
	end
end

function VersionActivity_1_2_HeroGroupEditView:_saveQuickGroupInfo()
	if HeroGroupQuickEditListModel.instance:getIsDirty() then
		local newHeroUids = HeroGroupQuickEditListModel.instance:getHeroUids()
		local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()

		self:replaceQuickGroupHeroDefaultEquip(newHeroUids)

		if Activity104Model.instance:isSeasonChapter() then
			local actId = ActivityEnum.Activity.Season
			local subId = Activity104Model.instance:getSeasonCurSnapshotSubId(actId)
			local extraData = {}

			extraData.groupIndex = subId
			heroGroupMO.heroList = newHeroUids
			extraData.heroGroup = heroGroupMO

			HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season, DungeonModel.instance.curSendEpisodeId, true, extraData)
		else
			for i = 1, HeroGroupModel.instance:getBattleRoleNum() do
				local heroUid = newHeroUids[i]

				if heroUid ~= nil then
					HeroSingleGroupModel.instance:addTo(heroUid, i)

					local singleGroupMO = HeroSingleGroupModel.instance:getByIndex(i)

					if tonumber(heroUid) < 0 then
						local heroMO = HeroGroupTrialModel.instance:getById(heroUid)

						if heroMO then
							singleGroupMO:setTrial(heroMO.trialCo.id, heroMO.trialCo.trialTemplate)
						else
							singleGroupMO:setTrial()
						end
					else
						singleGroupMO:setTrial()
					end
				end
			end

			HeroGroupModel.instance:replaceSingleGroup()
			HeroGroupModel.instance:replaceSingleGroupEquips()
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
			HeroGroupModel.instance:saveCurGroupData()
		end
	end
end

function VersionActivity_1_2_HeroGroupEditView:_onAttributeChanged(level, heroId)
	CharacterModel.instance:setFakeLevel(heroId, level)
end

function VersionActivity_1_2_HeroGroupEditView:_normalEditHasChange()
	if Activity104Model.instance:isSeasonChapter() then
		return true
	end

	if HeroSingleGroupModel.instance:getHeroUid(self._singleGroupMOId) ~= self._originalHeroUid then
		return true
	end

	if self._originalHeroUid and self._heroMO and self._originalHeroUid == self._heroMO.uid then
		return false
	elseif (not self._originalHeroUid or self._originalHeroUid == "0") and not self._heroMO then
		return false
	else
		return true
	end
end

function VersionActivity_1_2_HeroGroupEditView:_refreshEditMode()
	gohelper.setActive(self._scrollquickedit.gameObject, self._isShowQuickEdit)
	gohelper.setActive(self._scrollcard.gameObject, not self._isShowQuickEdit)
	gohelper.setActive(self._goBtnEditQuickMode.gameObject, self._isShowQuickEdit)
	gohelper.setActive(self._goBtnEditNormalMode.gameObject, not self._isShowQuickEdit)
end

function VersionActivity_1_2_HeroGroupEditView:_refreshCurScrollBySort()
	if self._isShowQuickEdit then
		if HeroGroupQuickEditListModel.instance:getIsDirty() then
			self:_saveQuickGroupInfo()
		end

		local originalMO = self._heroMO

		HeroGroupQuickEditListModel.instance:copyQuickEditCardList()

		if originalMO ~= self._heroMO then
			HeroGroupQuickEditListModel.instance:cancelAllSelected()
		end
	else
		HeroGroupEditListModel.instance:copyCharacterCardList()
	end
end

function VersionActivity_1_2_HeroGroupEditView:_onGroupModify()
	if self._isShowQuickEdit then
		HeroGroupQuickEditListModel.instance:copyQuickEditCardList()
	else
		local heroUid = HeroSingleGroupModel.instance:getHeroUid(self._singleGroupMOId)

		if self._originalHeroUid ~= heroUid then
			self._originalHeroUid = heroUid

			HeroGroupEditListModel.instance:setParam(heroUid, self._adventure)
			self:_onHeroItemClick(nil)
			HeroGroupEditListModel.instance:cancelAllSelected()

			local mo = HeroGroupEditListModel.instance:getById(heroUid)
			local index = HeroGroupEditListModel.instance:getIndex(mo)

			HeroGroupEditListModel.instance:selectCell(index, true)
		end

		HeroGroupEditListModel.instance:copyCharacterCardList()
	end
end

function VersionActivity_1_2_HeroGroupEditView:_editableInitView()
	gohelper.setActive(self._gospecialitem, false)

	self._careerGOs = {}
	self._imgBg = gohelper.findChildSingleImage(self.viewGO, "bg/bgimg")
	self._simageredlight = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_redlight")

	self._imgBg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))
	self._simageredlight:LoadImage(ResUrl.getHeroGroupBg("guang_027"))

	self._lvBtns = self:getUserDataTb_()
	self._lvArrow = self:getUserDataTb_()
	self._rareBtns = self:getUserDataTb_()
	self._rareArrow = self:getUserDataTb_()
	self._classifyBtns = self:getUserDataTb_()
	self._selectDmgs = {}
	self._dmgSelects = self:getUserDataTb_()
	self._dmgUnselects = self:getUserDataTb_()
	self._dmgBtnClicks = self:getUserDataTb_()
	self._selectAttrs = {}
	self._attrSelects = self:getUserDataTb_()
	self._attrUnselects = self:getUserDataTb_()
	self._attrBtnClicks = self:getUserDataTb_()
	self._selectLocations = {}
	self._locationSelects = self:getUserDataTb_()
	self._locationUnselects = self:getUserDataTb_()
	self._locationBtnClicks = self:getUserDataTb_()
	self._curDmgs = {}
	self._curAttrs = {}
	self._curLocations = {}

	for i = 1, 2 do
		self._lvBtns[i] = gohelper.findChild(self._btnlvrank.gameObject, "btn" .. tostring(i))
		self._lvArrow[i] = gohelper.findChild(self._lvBtns[i], "txt/arrow").transform
		self._rareBtns[i] = gohelper.findChild(self._btnrarerank.gameObject, "btn" .. tostring(i))
		self._rareArrow[i] = gohelper.findChild(self._rareBtns[i], "txt/arrow").transform
		self._classifyBtns[i] = gohelper.findChild(self._btnclassify.gameObject, "btn" .. tostring(i))
		self._dmgUnselects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. i .. "/unselected")
		self._dmgSelects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. i .. "/selected")
		self._dmgBtnClicks[i] = gohelper.findChildButtonWithAudio(self._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. i .. "/click")

		self._dmgBtnClicks[i]:AddClickListener(self._dmgBtnOnClick, self, i)
	end

	for i = 1, 6 do
		self._attrUnselects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. i .. "/unselected")
		self._attrSelects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. i .. "/selected")
		self._attrBtnClicks[i] = gohelper.findChildButtonWithAudio(self._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. i .. "/click")

		self._attrBtnClicks[i]:AddClickListener(self._attrBtnOnClick, self, i)
	end

	for i = 1, 6 do
		self._locationUnselects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. i .. "/unselected")
		self._locationSelects[i] = gohelper.findChild(self._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. i .. "/selected")
		self._locationBtnClicks[i] = gohelper.findChildButtonWithAudio(self._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. i .. "/click")

		self._locationBtnClicks[i]:AddClickListener(self._locationBtnOnClick, self, i)
	end

	self._goBtnEditQuickMode = gohelper.findChild(self._btnquickedit.gameObject, "btn2")
	self._goBtnEditNormalMode = gohelper.findChild(self._btnquickedit.gameObject, "btn1")
	self._attributevalues = {}

	for i = 1, 5 do
		local o = self:getUserDataTb_()

		o.value = gohelper.findChildText(self._goattribute, "attribute" .. tostring(i) .. "/txt_attribute")
		o.name = gohelper.findChildText(self._goattribute, "attribute" .. tostring(i) .. "/name")
		o.icon = gohelper.findChildImage(self._goattribute, "attribute" .. tostring(i) .. "/icon")
		self._attributevalues[i] = o
	end

	self._passiveskillitems = {}

	for i = 1, 3 do
		local o = self:getUserDataTb_()

		o.go = gohelper.findChild(self._gopassiveskills, "passiveskill" .. tostring(i))
		o.on = gohelper.findChild(o.go, "on")
		o.off = gohelper.findChild(o.go, "off")
		o.balance = gohelper.findChild(o.go, "balance")
		self._passiveskillitems[i] = o
	end

	self._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(self._goskill, CharacterSkillContainer)

	gohelper.setActive(self._gononecharacter, false)
	gohelper.setActive(self._gocharacterinfo, false)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function VersionActivity_1_2_HeroGroupEditView:onOpen()
	self._isShowQuickEdit = false
	self._scrollcard.verticalNormalizedPosition = 1
	self._scrollquickedit.verticalNormalizedPosition = 1
	self._originalHeroUid = self.viewParam.originalHeroUid
	self._singleGroupMOId = self.viewParam.singleGroupMOId
	self._adventure = self.viewParam.adventure
	self._equips = self.viewParam.equips

	for i = 1, 2 do
		self._selectDmgs[i] = false
	end

	for i = 1, 6 do
		self._selectAttrs[i] = false
	end

	for i = 1, 6 do
		self._selectLocations[i] = false
	end

	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)
	HeroGroupEditListModel.instance:setParam(self._originalHeroUid, self._adventure, self._heroHps)
	HeroGroupQuickEditListModel.instance:setParam(self._adventure, self._heroHps)

	self._heroMO = HeroGroupEditListModel.instance:copyCharacterCardList(true)

	self:_refreshEditMode()
	self:_refreshBtnIcon()
	self:_refreshCharacterInfo()
	self:_showRecommendCareer()
	self:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, self._updateHeroList, self)
	self:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, self._updateHeroList, self)
	self:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._updateHeroList, self)
	self:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, self._onHeroItemClick, self)
	self:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, self._refreshCharacterInfo, self)
	self:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, self._refreshCharacterInfo, self)
	self:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._refreshCharacterInfo, self)
	self:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, self._refreshCharacterInfo, self)
	self:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._refreshCharacterInfo, self)
	self:addEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, self._onAttributeChanged, self)
	self:addEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, self._showCharacterRankUpView, self)
	self:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._onGroupModify, self)
	self:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._onGroupModify, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	gohelper.addUIClickAudio(self._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnexskillrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnattribute.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnpassiveskill.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btncharacter.gameObject, AudioEnum.UI.UI_Common_Click)

	_, self._initScrollContentPosY = transformhelper.getLocalPos(self._goScrollContent.transform)
end

function VersionActivity_1_2_HeroGroupEditView:onClose()
	self:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, self._updateHeroList, self)
	self:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, self._updateHeroList, self)
	self:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._updateHeroList, self)
	self:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, self._onHeroItemClick, self)
	self:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, self._refreshCharacterInfo, self)
	self:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, self._refreshCharacterInfo, self)
	self:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._refreshCharacterInfo, self)
	self:removeEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, self._refreshCharacterInfo, self)
	self:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, self._refreshCharacterInfo, self)
	self:removeEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, self._onAttributeChanged, self)
	self:removeEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, self._showCharacterRankUpView, self)
	self:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, self._onGroupModify, self)
	self:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self._onGroupModify, self)
	CharacterModel.instance:setFakeLevel()
	HeroGroupEditListModel.instance:cancelAllSelected()
	HeroGroupEditListModel.instance:clear()
	HeroGroupQuickEditListModel.instance:cancelAllSelected()
	HeroGroupQuickEditListModel.instance:clear()
	HeroGroupTrialModel.instance:setFilter()
	CommonHeroHelper.instance:resetGrayState()

	self._selectDmgs = {}
	self._selectAttrs = {}
	self._selectLocations = {}

	if self._isStopBgm then
		TaskDispatcher.cancelTask(self._delyStopBgm, self)
		self:_delyStopBgm()
	end
end

function VersionActivity_1_2_HeroGroupEditView:_onOpenView(viewName)
	if viewName == ViewName.CharacterView and self._isStopBgm then
		TaskDispatcher.cancelTask(self._delyStopBgm, self)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Unsatisfied_Music)

		return
	end
end

function VersionActivity_1_2_HeroGroupEditView:_showRecommendCareer()
	local recommended, counter = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(self, self._onRecommendCareerItemShow, recommended, self._goattrlist, self._goattritem)

	self._txtrecommendAttrDesc.text = #recommended == 0 and luaLang("herogroupeditview_notrecommend") or luaLang("herogroupeditview_recommend")

	gohelper.setActive(self._goattrlist, #recommended ~= 0)
end

function VersionActivity_1_2_HeroGroupEditView:_onRecommendCareerItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(icon, "career_" .. data)
end

function VersionActivity_1_2_HeroGroupEditView:_onCloseView(viewName)
	if viewName == ViewName.CharacterView then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_UIMusic)

		self._isStopBgm = true

		TaskDispatcher.cancelTask(self._delyStopBgm, self)
		TaskDispatcher.runDelay(self._delyStopBgm, self, 1)
	end
end

function VersionActivity_1_2_HeroGroupEditView:_delyStopBgm()
	self._isStopBgm = false

	AudioMgr.instance:trigger(AudioEnum.Bgm.Pause_FightingMusic)
end

function VersionActivity_1_2_HeroGroupEditView:_showCharacterRankUpView(func)
	func()
end

function VersionActivity_1_2_HeroGroupEditView:onDestroyView()
	self._imgBg:UnLoadImage()
	self._simageredlight:UnLoadImage()

	self._imgBg = nil
	self._simageredlight = nil

	for i = 1, 2 do
		self._dmgBtnClicks[i]:RemoveClickListener()
	end

	for i = 1, 6 do
		self._attrBtnClicks[i]:RemoveClickListener()
	end

	for i = 1, 6 do
		self._locationBtnClicks[i]:RemoveClickListener()
	end
end

function VersionActivity_1_2_HeroGroupEditView:_refreshAttribute()
	if self._heroMO then
		local upDic = VersionActivity1_2DungeonModel.instance:getAttrUpDic()
		local attrDict = self._heroMO:getTotalBaseAttrDict(self._equips)

		for index, attrId in ipairs(CharacterEnum.BaseAttrIdList) do
			local tarAttr = self._attributevalues[index]
			local co = HeroConfig.instance:getHeroAttributeCO(attrId)

			tarAttr.name.text = co.name
			tarAttr.value.text = attrDict[attrId] + (upDic[attrId] or 0)

			CharacterController.instance:SetAttriIcon(tarAttr.icon, attrId)

			local img_up = gohelper.findChild(tarAttr.value.gameObject, "img_up")

			gohelper.setActive(img_up, upDic[attrId])
		end
	end
end

function VersionActivity_1_2_HeroGroupEditView:_btnattributeOnClick()
	if self._heroMO then
		local info = {}

		info.tag = "attribute"
		info.heroid = self._heroMO.heroId
		info.equips = self._equips
		info.showExtraAttr = true
		info.fromHeroGroupEditView = true
		info.heroMo = self._heroMO

		ViewMgr.instance:openView(ViewName.Va_1_2_CharacterTipView, info)
	end
end

return VersionActivity_1_2_HeroGroupEditView
