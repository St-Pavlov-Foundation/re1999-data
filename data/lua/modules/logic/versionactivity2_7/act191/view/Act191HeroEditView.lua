module("modules.logic.versionactivity2_7.act191.view.Act191HeroEditView", package.seeall)

slot0 = class("Act191HeroEditView", BaseView)

function slot0.onInitView(slot0)
	slot0._gononecharacter = gohelper.findChild(slot0.viewGO, "characterinfo/#go_nonecharacter")
	slot0._gocharacterinfo = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo")
	slot0._imagedmgtype = gohelper.findChildImage(slot0.viewGO, "characterinfo/#go_characterinfo/#image_dmgtype")
	slot0._imagecareericon = gohelper.findChildImage(slot0.viewGO, "characterinfo/#go_characterinfo/career/#image_careericon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/name/#txt_name")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/name/#txt_nameen")
	slot0._txtpassivename = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/passiveskill/bg/#txt_passivename")
	slot0._gopassiveskills = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/passiveskill/#go_passiveskills")
	slot0._btnpassiveskill = gohelper.findChildButtonWithAudio(slot0.viewGO, "characterinfo/#go_characterinfo/passiveskill/#btn_passiveskill")
	slot0._goattribute = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/attribute/#go_attribute")
	slot0._goskill = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/#go_skill")
	slot0._btnExSkill = gohelper.findChildButtonWithAudio(slot0.viewGO, "characterinfo/#go_characterinfo/quality/exSkill/#btn_ExSkill")
	slot0._goFetterIcon = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/fetters/Viewport/Content/#go_FetterIcon")
	slot0._goDestiny = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/#go_Destiny")
	slot0._goDestinyLock = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/#go_Destiny/stone/#go_DestinyLock")
	slot0._btnDestiny = gohelper.findChildButtonWithAudio(slot0.viewGO, "characterinfo/#go_characterinfo/#go_Destiny/#btn_Destiny")
	slot0._gorolecontainer = gohelper.findChild(slot0.viewGO, "#go_rolecontainer")
	slot0._gorolesort = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort")
	slot0._btnrarerank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	slot0._goRareArrow = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank/txt/#go_RareArrow")
	slot0._btnquickedit = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_quickedit")
	slot0._btnclassify = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify")
	slot0._goFetterContent = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/layout/#go_FetterContent")
	slot0._scrollcard = gohelper.findChildScrollRect(slot0.viewGO, "#go_rolecontainer/layout/#scroll_card")
	slot0._scrollquickedit = gohelper.findChildScrollRect(slot0.viewGO, "#go_rolecontainer/layout/#scroll_quickedit")
	slot0._goDetail = gohelper.findChild(slot0.viewGO, "#go_Detail")
	slot0._btnCloseDetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Detail/#btn_CloseDetail")
	slot0._goDetailPassiveItem = gohelper.findChild(slot0.viewGO, "#go_Detail/scroll_content/viewport/content/#go_DetailPassiveItem")
	slot0._goops = gohelper.findChild(slot0.viewGO, "#go_ops")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ops/#btn_confirm")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ops/#btn_cancel")
	slot0._gosearchfilter = gohelper.findChild(slot0.viewGO, "#go_searchfilter")
	slot0._btnclosefilterview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_searchfilter/#btn_closefilterview")
	slot0._btnok = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_searchfilter/container/#btn_ok")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_searchfilter/container/#btn_reset")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnpassiveskill:AddClickListener(slot0._btnpassiveskillOnClick, slot0)
	slot0._btnExSkill:AddClickListener(slot0._btnExSkillOnClick, slot0)
	slot0._btnDestiny:AddClickListener(slot0._btnDestinyOnClick, slot0)
	slot0._btnrarerank:AddClickListener(slot0._btnrarerankOnClick, slot0)
	slot0._btnquickedit:AddClickListener(slot0._btnquickeditOnClick, slot0)
	slot0._btnclassify:AddClickListener(slot0._btnclassifyOnClick, slot0)
	slot0._btnCloseDetail:AddClickListener(slot0._btnCloseDetailOnClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
	slot0._btnclosefilterview:AddClickListener(slot0._btnclosefilterviewOnClick, slot0)
	slot0._btnok:AddClickListener(slot0._btnokOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnpassiveskill:RemoveClickListener()
	slot0._btnExSkill:RemoveClickListener()
	slot0._btnDestiny:RemoveClickListener()
	slot0._btnrarerank:RemoveClickListener()
	slot0._btnquickedit:RemoveClickListener()
	slot0._btnclassify:RemoveClickListener()
	slot0._btnCloseDetail:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
	slot0._btnclosefilterview:RemoveClickListener()
	slot0._btnok:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
end

function slot0._btnDestinyOnClick(slot0)
	if not slot0.destinyUnlock then
		GameFacade.showToast(ToastEnum.Act191DestinyLock)

		return
	end

	ViewMgr.instance:openView(ViewName.Act191CharacterDestinyView, {
		config = slot0.config,
		stoneId = slot0.stoneId
	})
end

function slot0._btnExSkillOnClick(slot0)
	if Activity191Config.instance:getRoleCoByNativeId(slot0._heroMo.heroId, slot0._heroMo.star) then
		ViewMgr.instance:openView(ViewName.Act191CharacterExSkillView, {
			config = slot1
		})
	end
end

function slot0._btnclosefilterviewOnClick(slot0)
	gohelper.setActive(slot0._gosearchfilter, false)
end

function slot0._btnCloseDetailOnClick(slot0)
	gohelper.setActive(slot0._goDetail, false)
end

function slot0._btncloseFilterViewOnClick(slot0)
	gohelper.setActive(slot0._gosearchfilter, false)
end

function slot0._btnclassifyOnClick(slot0)
	gohelper.setActive(slot0._gosearchfilter, true)
	slot0:_refreshFilterView()
end

function slot0._btnresetOnClick(slot0)
	slot0:_refreshFilterView()
end

function slot0._btnokOnClick(slot0)
	gohelper.setActive(slot0._gosearchfilter, false)
end

function slot0._btnpassiveskillOnClick(slot0)
	if not slot0.config then
		return
	end

	if slot0.config.type == Activity191Enum.CharacterType.Hero then
		ViewMgr.instance:openView(ViewName.Act191CharacterTipView, {
			id = slot0.config.id,
			tipPos = Vector2.New(851, -59),
			buffTipsX = 1603,
			anchorParams = {
				Vector2.New(0, 0.5),
				Vector2.New(0, 0.5)
			}
		})
	else
		slot0:refreshPassiveDetail()
		gohelper.setActive(slot0._goDetail, true)
	end
end

function slot0.refreshPassiveDetail(slot0)
	for slot5 = 1, #slot0.passiveSkillIds do
		if lua_skill.configDict[tonumber(slot0.passiveSkillIds[slot5])] then
			if not slot0._detailPassiveTables[slot5] then
				slot9 = gohelper.cloneInPlace(slot0._goDetailPassiveItem, "item" .. slot5)
				slot8 = slot0:getUserDataTb_()
				slot8.go = slot9
				slot8.name = gohelper.findChildText(slot9, "title/txt_name")
				slot8.icon = gohelper.findChildSingleImage(slot9, "title/simage_icon")
				slot8.desc = gohelper.findChildText(slot9, "txt_desc")

				SkillHelper.addHyperLinkClick(slot8.desc, slot0.onClickHyperLink, slot0)

				slot8.line = gohelper.findChild(slot9, "txt_desc/image_line")

				table.insert(slot0._detailPassiveTables, slot8)
			end

			slot8.name.text = slot7.name
			slot8.desc.text = SkillHelper.getSkillDesc(slot0.config.name, slot7)

			gohelper.setActive(slot8.go, true)
			gohelper.setActive(slot8.line, slot5 < slot1)
		else
			logError(string.format("被动技能配置没找到, id: %d", slot6))
		end
	end

	for slot5 = slot1 + 1, #slot0._detailPassiveTables do
		gohelper.setActive(slot0._detailPassiveTables[slot5].go, false)
	end
end

function slot0._btnconfirmOnClick(slot0)
	if slot0._isShowQuickEdit then
		slot0.gameInfo:saveQuickGroupInfo(Act191HeroQuickEditListModel.instance:getHeroIdMap())
	elseif slot0._heroMo then
		if slot0._heroMo.heroId ~= Act191HeroEditListModel.instance.specialHero then
			Activity191Model.instance:getActInfo():getGameInfo():repleaceHeroInTeam(slot0._heroMo.heroId, slot0.curSlotIndex)
		end
	elseif slot1 then
		slot2:removeHeroInTeam(slot1)
	end

	slot0:closeThis()
end

function slot0._btncancelOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnrarerankOnClick(slot0)
	if slot0.sortRule == Activity191Enum.SortRule.Down then
		slot0.sortRule = Activity191Enum.SortRule.Up
	else
		slot0.sortRule = Activity191Enum.SortRule.Down
	end

	slot0:refreshBtnRare()

	if slot0._isShowQuickEdit then
		Act191HeroQuickEditListModel.instance:sortData(slot0.sortRule)
	else
		Act191HeroEditListModel.instance:sortData(slot0.sortRule)
	end
end

function slot0._btnquickeditOnClick(slot0)
	slot0._isShowQuickEdit = not slot0._isShowQuickEdit

	if slot0._isShowQuickEdit then
		slot0:_onHeroItemClick(slot0._quickHeroMo)
	else
		slot0:_onHeroItemClick(slot0._normalHeroMo)
	end

	slot0:_refreshEditMode()
end

function slot0._editableInitView(slot0)
	slot0.actId = Activity191Model.instance:getCurActId()
	slot0._detailPassiveTables = {}
	slot0._goScrollContent = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#scroll_card/scrollcontent")
	slot0._imgBg = gohelper.findChildSingleImage(slot0.viewGO, "bg/bgimg")
	slot4 = "full/biandui_di"

	slot0._imgBg:LoadImage(ResUrl.getCommonViewBg(slot4))

	slot0._classifyBtns = slot0:getUserDataTb_()

	for slot4 = 1, 2 do
		slot0._classifyBtns[slot4] = gohelper.findChild(slot0._btnclassify.gameObject, "btn" .. tostring(slot4))
	end

	slot0._goBtnEditQuickMode = gohelper.findChild(slot0._btnquickedit.gameObject, "btn2")
	slot0._goBtnEditNormalMode = gohelper.findChild(slot0._btnquickedit.gameObject, "btn1")
	slot0._attributevalues = {}

	for slot4 = 1, 5 do
		slot5 = slot0:getUserDataTb_()
		slot5.value = gohelper.findChildText(slot0._goattribute, "attribute" .. tostring(slot4) .. "/txt_attribute")
		slot5.name = gohelper.findChildText(slot0._goattribute, "attribute" .. tostring(slot4) .. "/name")
		slot0._attributevalues[slot4] = slot5
	end

	for slot4 = 1, 3 do
		slot0["goPassiveSkill" .. slot4] = gohelper.findChild(slot0._gopassiveskills, "passiveskill" .. tostring(slot4))
		slot0["goStar" .. slot4] = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/quality/mask/bg/" .. slot4)
	end

	slot0._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._goskill, Act191SkillContainer)
	slot0.upLevelExpArr = GameUtil.splitString2(lua_activity191_const.configDict[Activity191Enum.ConstKey.CharacterUpExp].value, true)
	slot0.expItemList = {}
	slot0.goExp = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/quality/go_exp")
	slot0.goExpMax = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/quality/go_max")
	slot1 = gohelper.findChild(slot0.goExp, "expitem")

	for slot6 = 1, slot0.upLevelExpArr[Activity191Enum.CharacterMaxStar - 1][2] do
		slot7 = slot0:getUserDataTb_()
		slot7.go = gohelper.cloneInPlace(slot1)
		slot7.light = gohelper.findChild(slot7.go, "light")
		slot0.expItemList[slot6] = slot7
	end

	gohelper.setActive(slot1, false)

	slot0.exGoList = slot0:getUserDataTb_()

	for slot6 = 1, 5 do
		slot0.exGoList[slot6] = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/quality/exSkill/go_ex" .. slot6)
	end

	slot0.fetterIconItemList = {}
	slot0.fetterItemList = {}
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(slot0._gononecharacter, true)
	gohelper.setActive(slot0._gocharacterinfo, false)
end

function slot0.onOpen(slot0)
	slot0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	slot0.sortRule = Activity191Enum.SortRule.Down

	Act191HeroEditListModel.instance:initData(slot0.viewParam)
	Act191HeroQuickEditListModel.instance:initData()

	slot0.curSlotIndex = slot0.viewParam.index
	slot0._isShowQuickEdit = false
	slot0._scrollcard.verticalNormalizedPosition = 1
	slot0._scrollquickedit.verticalNormalizedPosition = 1

	slot0:_refreshEditMode()
	slot0:_refreshCharacterInfo()
	slot0:addEventCb(Activity191Controller.instance, Activity191Event.OnClickHeroEditItem, slot0._onHeroItemClick, slot0)
	gohelper.addUIClickAudio(slot0._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(slot0._btnpassiveskill.gameObject, AudioEnum.UI.UI_Common_Click)
	slot0:refreshFetter()
	slot0:refreshBtnRare()
end

function slot0.onClose(slot0)
	slot0._heroMo = nil
	slot0.config = nil
end

function slot0.onDestroyView(slot0)
	Act191HeroEditListModel.instance:clear()
	Act191HeroQuickEditListModel.instance:clear()
	slot0._imgBg:UnLoadImage()

	slot0._imgBg = nil
end

function slot0.refreshBtnRare(slot0)
	transformhelper.setLocalRotation(slot0._goRareArrow.transform, 1, 1, slot0.sortRule == Activity191Enum.SortRule.Down and 0 or 180)
end

function slot0.refreshDestiny(slot0)
	slot0.hasDestiny = CharacterDestinyConfig.instance:hasDestinyHero(slot0.config.roleId)

	if slot0.hasDestiny then
		slot0.destinyUnlock, slot0.stoneId = slot0.gameInfo:isHeroDestinyUnlock(slot0.config.roleId)

		gohelper.setActive(slot0._goDestinyLock, not slot0.destinyUnlock)
	end

	gohelper.setActive(slot0._goDestiny, slot0.hasDestiny)
end

function slot0._onHeroItemClick(slot0, slot1)
	if slot0._isShowQuickEdit then
		slot0._quickHeroMo = slot1
	else
		slot0._normalHeroMo = slot1
	end

	slot0:refreshFetter()

	if slot0._heroMo and slot1 and slot0._heroMo.heroId == slot1.heroId then
		return
	end

	slot0._heroMo = slot1
	slot0.config = slot1 and slot1.config or nil

	slot0:_refreshCharacterInfo()
end

function slot0._refreshCharacterInfo(slot0)
	if slot0.config then
		gohelper.setActive(slot0._gononecharacter, false)
		gohelper.setActive(slot0._gocharacterinfo, true)
		UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareericon, "sx_biandui_" .. tostring(slot0.config.career))

		slot6 = slot0.config.dmgType
		slot5 = tostring(slot6)

		UISpriteSetMgr.instance:setCommonSprite(slot0._imagedmgtype, "dmgtype" .. slot5)

		slot0._txtname.text = slot0.config.name
		slot1 = lua_activity191_template.configDict[slot0.config.id]

		for slot5, slot6 in ipairs(CharacterEnum.BaseAttrIdList) do
			slot0._attributevalues[slot5].name.text = HeroConfig.instance:getHeroAttributeCO(slot6).name
		end

		slot0._attributevalues[1].value.text = slot1.attack
		slot0._attributevalues[2].value.text = slot1.life
		slot0._attributevalues[3].value.text = slot1.defense
		slot0._attributevalues[4].value.text = slot1.mdefense
		slot0._attributevalues[5].value.text = slot1.technic
		slot0.passiveSkillIds = Activity191Config.instance:getHeroPassiveSkillIdList(slot0.config.id)
		slot0._txtpassivename.text = lua_skill.configDict[slot0.passiveSkillIds[1]].name
		slot2 = nil

		for slot6 = 1, 3 do
			gohelper.setActive(slot0["goPassiveSkill" .. slot6], slot6 <= (slot0.config.type == Activity191Enum.CharacterType.Hero and #SkillConfig.instance:getheroranksCO(slot0.config.roleId) - 1 or 0))
		end

		for slot6 = 1, Activity191Enum.CharacterMaxStar do
			gohelper.setActive(slot0["goStar" .. slot6], slot6 <= slot0.config.star)
		end

		slot3 = nil

		if slot0._heroMo.star == Activity191Enum.CharacterMaxStar then
			slot3 = slot0.upLevelExpArr[slot0._heroMo.star - 1][2]

			gohelper.setActive(slot0.goExpMax, true)
		else
			slot3 = slot0.upLevelExpArr[slot0._heroMo.star][2]

			gohelper.setActive(slot0.goExpMax, false)
		end

		for slot7, slot8 in ipairs(slot0.expItemList) do
			gohelper.setActive(slot8.go, slot7 <= slot3)
			gohelper.setActive(slot8.light, slot7 <= slot0._heroMo.exp)
		end

		for slot7, slot8 in ipairs(slot0.exGoList) do
			gohelper.setActive(slot8, slot7 <= slot0.config.exLevel)
		end

		slot0:refreshFetterIcon()
		slot0._skillContainer:onUpdateMO(slot0.config)
		slot0:refreshDestiny()
	else
		gohelper.setActive(slot0._gononecharacter, true)
		gohelper.setActive(slot0._gocharacterinfo, false)
	end
end

function slot0.refreshFetterIcon(slot0)
	for slot4, slot5 in ipairs(slot0.fetterIconItemList) do
		gohelper.setActive(slot5.go, false)
	end

	for slot5, slot6 in ipairs(string.split(slot0.config.tag, "#")) do
		if not slot0.fetterIconItemList[slot5] then
			slot0.fetterIconItemList[slot5] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._goFetterIcon), Act191FetterIconItem)
		end

		slot7:setData(slot6)
		gohelper.setActive(slot7.go, true)
	end
end

function slot0._refreshFilterView(slot0)
end

function slot0.replaceQuickGroupHeroDefaultEquip(slot0, slot1)
	slot3 = HeroGroupModel.instance:getCurGroupMO().equips
	slot4 = nil

	for slot8, slot9 in ipairs(slot1) do
		if HeroModel.instance:getById(slot9) and slot4:hasDefaultEquip() then
			for slot13, slot14 in pairs(slot3) do
				if slot14.equipUid[1] == slot4.defaultEquipUid then
					slot14.equipUid[1] = "0"

					break
				end
			end

			slot3[slot8 - 1].equipUid[1] = slot4.defaultEquipUid
		end
	end
end

function slot0._refreshEditMode(slot0)
	gohelper.setActive(slot0._scrollquickedit.gameObject, slot0._isShowQuickEdit)
	gohelper.setActive(slot0._scrollcard.gameObject, not slot0._isShowQuickEdit)
	gohelper.setActive(slot0._goBtnEditQuickMode.gameObject, slot0._isShowQuickEdit)
	gohelper.setActive(slot0._goBtnEditNormalMode.gameObject, not slot0._isShowQuickEdit)
end

function slot0.onClickHyperLink(slot0, slot1, slot2)
	CommonBuffTipController:openCommonTipViewWithCustomPos(slot1, Vector2.New(0, 0))
end

function slot0.refreshFetter(slot0)
	slot1 = nil
	slot1 = (not slot0._isShowQuickEdit or slot0.gameInfo:getPreviewFetterCntDic(Act191HeroQuickEditListModel.instance:getHeroIdMap())) and slot0.gameInfo:getPreviewFetterCntDic(Act191HeroEditListModel.instance:getHeroIdMap())

	for slot5, slot6 in ipairs(slot0.fetterItemList) do
		gohelper.setActive(slot6.go, false)
	end

	for slot6, slot7 in ipairs(Activity191Helper.getActiveFetterInfoList(slot1)) do
		if not slot0.fetterItemList[slot6] then
			slot0.fetterItemList[slot6] = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.FetterItem, slot0._goFetterContent), Act191FetterItem)
		end

		slot8:setData(slot7.config, slot7.count)
		gohelper.setActive(slot8.go, true)
	end

	gohelper.setActive(slot0._goFetterContent, #slot2 ~= 0)
end

return slot0
