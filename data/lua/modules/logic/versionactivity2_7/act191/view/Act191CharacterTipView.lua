module("modules.logic.versionactivity2_7.act191.view.Act191CharacterTipView", package.seeall)

slot0 = class("Act191CharacterTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._gopassiveskilltip = gohelper.findChild(slot0.viewGO, "#go_passiveskilltip")
	slot0._simageshadow = gohelper.findChildSingleImage(slot0.viewGO, "#go_passiveskilltip/mask/root/scrollview/#simage_shadow")
	slot0._goeffectdesc = gohelper.findChild(slot0.viewGO, "#go_passiveskilltip/mask/root/scrollview/viewport/content/#go_effectdesc")
	slot0._goeffectdescitem = gohelper.findChild(slot0.viewGO, "#go_passiveskilltip/mask/root/scrollview/viewport/content/#go_effectdesc/#go_effectdescitem")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "#go_passiveskilltip/mask/root/scrollview")
	slot0._gomask1 = gohelper.findChild(slot0.viewGO, "#go_passiveskilltip/mask/root/scrollview/#go_mask1")
	slot0._txtpassivename = gohelper.findChildText(slot0.viewGO, "#go_passiveskilltip/name/bg/#txt_passivename")
	slot0._btnclosepassivetip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_passiveskilltip/#btn_closepassivetip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclosepassivetip:AddClickListener(slot0._btnclosepassivetipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclosepassivetip:RemoveClickListener()
end

function slot0._btnclosepassivetipOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._passiveskilltipcontent = gohelper.findChild(slot0._gopassiveskilltip, "mask/root/scrollview/viewport/content")
	slot0._passiveskilltipmask = gohelper.findChild(slot0._gopassiveskilltip, "mask"):GetComponent(typeof(UnityEngine.UI.RectMask2D))
	slot4 = "bg_shade"

	slot0._simageshadow:LoadImage(ResUrl.getCharacterIcon(slot4))

	slot0._passiveskillitems = {}

	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0._gopassiveskilltip, "mask/root/scrollview/viewport/content/talentstar" .. tostring(slot4))
		slot5.desc = gohelper.findChildTextMesh(slot5.go, "desctxt")
		slot5.hyperLinkClick = SkillHelper.addHyperLinkClick(slot5.desc, slot0._onHyperLinkClick, slot0)
		slot5.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(slot5.desc.gameObject, FixTmpBreakLine)
		slot5.on = gohelper.findChild(slot5.go, "#go_passiveskills/passiveskill/on")
		slot5.unlocktxt = gohelper.findChildText(slot5.go, "#go_passiveskills/passiveskill/unlocktxt")
		slot5.canvasgroup = gohelper.onceAddComponent(slot5.go, typeof(UnityEngine.CanvasGroup))
		slot5.connectline = gohelper.findChild(slot5.go, "line")
		slot0._passiveskillitems[slot4] = slot5
	end

	slot0._txtpassivename = gohelper.findChildText(slot0.viewGO, "#go_passiveskilltip/name/bg/#txt_passivename")
	slot0._skillEffectDescItems = slot0:getUserDataTb_()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam
	slot0.config = Activity191Config.instance:getRoleCo(slot1.id)

	slot0:_setPassiveSkill(slot1.anchorParams, slot1.tipPos)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0._setPassiveSkill(slot0, slot1, slot2)
	slot0._matchSkillNames = {}

	if slot0.viewParam.stoneId then
		slot3 = Activity191Helper.replaceSkill(slot0.viewParam.stoneId, Activity191Config.instance:getHeroPassiveSkillIdList(slot0.config.id))
	end

	slot4 = #slot3 <= 3 and #slot3 or 3
	slot0._txtpassivename.text = lua_skill.configDict[slot3[1]].name
	slot6 = {}

	for slot10 = 1, slot4 do
		table.insert(slot6, FightConfig.instance:getSkillEffectDesc(slot0.config.name, lua_skill.configDict[slot3[slot10]]))
	end

	slot7 = HeroSkillModel.instance:getSkillEffectTagIdsFormDescTabRecursion(slot6)
	slot8 = {}
	slot9 = {}

	for slot13 = 1, slot4 do
		slot15 = true

		for slot21, slot22 in ipairs(slot7[slot13]) do
			if HeroSkillModel.instance:canShowSkillTag(SkillConfig.instance:getSkillEffectDescCo(slot22).name, true) and not slot8[slot24] then
				slot8[slot24] = true

				if slot23.isSpecialCharacter == 1 then
					slot17 = string.format("%s", FightConfig.instance:getSkillEffectDesc(slot0.config.name, lua_skill.configDict[slot3[slot13]]))

					table.insert(slot9, {
						desc = SkillHelper.buildDesc(slot23.desc),
						title = slot23.name
					})
				end
			end
		end

		slot0._passiveskillitems[slot13].unlocktxt.text = string.format(luaLang("character_passive_unlock"), GameUtil.getRomanNums(slot0:_getTargetRankByEffect(slot0.config.roleId, slot13)))

		SLFramework.UGUI.GuiHelper.SetColor(slot0._passiveskillitems[slot13].unlocktxt, "#313B33")

		slot0._passiveskillitems[slot13].canvasgroup.alpha = slot15 and 1 or 0.83

		gohelper.setActive(slot0._passiveskillitems[slot13].on, slot15)

		slot0._passiveskillitems[slot13].desc.text = SkillHelper.buildDesc(slot17)

		slot0._passiveskillitems[slot13].fixTmpBreakLine:refreshTmpContent(slot0._passiveskillitems[slot13].desc)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._passiveskillitems[slot13].desc, slot15 and "#272525" or "#3A3A3A")
		gohelper.setActive(slot0._passiveskillitems[slot13].go, true)
		gohelper.setActive(slot0._passiveskillitems[slot13].connectline, slot13 ~= slot4)
	end

	for slot13 = slot4 + 1, #slot0._passiveskillitems do
		gohelper.setActive(slot0._passiveskillitems[slot13].go, false)
	end

	slot0:_showSkillEffectDesc(slot9)
	slot0:_refreshPassiveSkillScroll()
	slot0:_setTipPos(slot0._gopassiveskilltip.transform, slot2, slot1)
end

function slot0._getTargetRankByEffect(slot0, slot1, slot2)
	for slot7, slot8 in pairs(SkillConfig.instance:getheroranksCO(slot1)) do
		if CharacterModel.instance:getrankEffects(slot1, slot7)[2] == slot2 then
			return slot7 - 1
		end
	end

	return 0
end

function slot0._showSkillEffectDesc(slot0, slot1)
	gohelper.setActive(slot0._goeffectdesc, slot1 and #slot1 > 0)

	for slot5 = 1, #slot1 do
		slot6 = slot1[slot5]
		slot7 = slot0:_getSkillEffectDescItem(slot5)
		slot7.desc.text = slot6.desc
		slot7.title.text = SkillHelper.removeRichTag(slot6.title)

		slot7.fixTmpBreakLine:refreshTmpContent(slot7.desc)
		gohelper.setActive(slot7.go, true)
	end

	for slot5 = #slot1 + 1, #slot0._skillEffectDescItems do
		gohelper.setActive(slot0._passiveskillitems[slot5].go, false)
	end
end

function slot0._getSkillEffectDescItem(slot0, slot1)
	if not slot0._skillEffectDescItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._goeffectdescitem, "descitem" .. slot1)
		slot2.desc = gohelper.findChildText(slot2.go, "effectdesc")
		slot2.title = gohelper.findChildText(slot2.go, "titlebg/bg/name")
		slot2.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(slot2.desc.gameObject, FixTmpBreakLine)
		slot2.hyperLinkClick = SkillHelper.addHyperLinkClick(slot2.desc, slot0._onHyperLinkClick, slot0)

		table.insert(slot0._skillEffectDescItems, slot1, slot2)
	end

	return slot2
end

function slot0._refreshPassiveSkillScroll(slot0)
	ZProj.UGUIHelper.RebuildLayout(gohelper.findChild(slot0._gopassiveskilltip, "mask/root").transform)

	slot0._couldScroll = recthelper.getHeight(slot0._scrollview.transform) < recthelper.getHeight(slot0._passiveskilltipcontent.transform)

	gohelper.setActive(slot0._gomask1, slot0._couldScroll and gohelper.getRemindFourNumberFloat(slot0._scrollview.verticalNormalizedPosition) > 0)

	slot0._passiveskilltipmask.enabled = false
	slot4 = gohelper.findChild(slot0._gopassiveskilltip, "mask/root/scrollview/viewport")
	slot6 = gohelper.onceAddComponent(slot4, typeof(UnityEngine.UI.LayoutElement))
	gohelper.onceAddComponent(slot4, gohelper.Type_VerticalLayoutGroup).enabled = false
	slot6.enabled = true
	slot6.preferredHeight = recthelper.getHeight(slot4.transform)
end

function slot0._setTipPos(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	slot6 = slot2 and slot2 or Vector2.New(0, 0)
	slot0._gopassiveskilltip.transform.anchorMin = slot3 and slot3[1] or Vector2.New(0.5, 0.5)
	slot0._gopassiveskilltip.transform.anchorMax = slot3 and slot3[2] or Vector2.New(0.5, 0.5)

	recthelper.setAnchor(slot1, slot6.x, slot6.y)
end

slot0.LeftWidth = 470
slot0.RightWidth = 190
slot0.TopHeight = 292
slot0.Interval = 10

function slot0._onHyperLinkClick(slot0, slot1, slot2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(tonumber(slot1), slot0.setTipPosCallback, slot0)
end

function slot0.setTipPosCallback(slot0, slot1, slot2)
	slot0.rectTrPassive = slot0.rectTrPassive or slot0._gopassiveskilltip:GetComponent(gohelper.Type_RectTransform)
	slot5, slot6 = recthelper.uiPosToScreenPos2(slot0.rectTrPassive)
	slot7, slot8 = SLFramework.UGUI.RectTrHelper.ScreenPosXYToAnchorPosXY(slot5, slot6, slot1, CameraMgr.instance:getUICamera(), nil, )
	slot2.pivot = CommonBuffTipEnum.Pivot.Right
	slot12 = slot7

	recthelper.setAnchor(slot2, recthelper.getWidth(slot2) <= GameUtil.getViewSize() / 2 + slot7 - uv0.LeftWidth - uv0.Interval and slot12 - uv0.LeftWidth - uv0.Interval or slot12 + uv0.RightWidth + uv0.Interval + slot10, slot8 + uv0.TopHeight)
end

return slot0
