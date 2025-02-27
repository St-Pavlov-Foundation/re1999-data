module("modules.logic.rouge.dlc.103.view.RougeMapAttributeComp", package.seeall)

slot0 = class("RougeMapAttributeComp", BaseViewExtended)

function slot0.definePrefabUrl(slot0)
	slot0:setPrefabUrl("ui/viewres/rouge/dlc/103/rougedistortruleitem.prefab")
end

function slot0.onInitView(slot0)
	slot0._btndistortrule = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_distortrule")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "#go_tips")
	slot0._scrolloverview = gohelper.findChildScrollRect(slot0.viewGO, "#go_tips/#scroll_overview")
	slot0._txttitle1 = gohelper.findChildText(slot0.viewGO, "#go_tips/#scroll_overview/Viewport/Content/txt_title1")
	slot0._txtdec1 = gohelper.findChildText(slot0.viewGO, "#go_tips/#scroll_overview/Viewport/Content/#txt_dec1")
	slot0._txttitle2 = gohelper.findChildText(slot0.viewGO, "#go_tips/#scroll_overview/Viewport/Content/txt_title2")
	slot0._txtdec2 = gohelper.findChildText(slot0.viewGO, "#go_tips/#scroll_overview/Viewport/Content/#txt_dec2")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_tips/#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btndistortrule:AddClickListener(slot0._btndistortruleOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btndistortrule:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btndistortruleOnClick(slot0)
	slot0._tipAnimatorPlayer:Play("open", function ()
	end, slot0)
	slot0:setTipVisible(true)
end

function slot0._btncloseOnClick(slot0)
	slot0._tipAnimatorPlayer:Play("close", slot0.closeTips, slot0)
end

function slot0._editableInitView(slot0)
	slot0._monsterRuleItemTab = slot0:getUserDataTb_()

	gohelper.setActive(slot0._txtdec2.gameObject, false)

	slot0._tipAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0._gotips)
	slot0._canvasgroup = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_CanvasGroup)
	slot0._scrollViewTran = slot0._scrolloverview.transform
	slot0._scrollWidth = recthelper.getWidth(slot0._scrollViewTran)
	slot0._scrollScreenPos = recthelper.uiPosToScreenPos(slot0._scrollViewTran)
	slot0._effectTipViewPosX = recthelper.screenPosToAnchorPos2(slot0._scrollScreenPos, slot0.PARENT_VIEW.viewGO.transform) + slot0._scrollWidth

	SkillHelper.addHyperLinkClick(slot0._txtdec1, slot0.clcikHyperLink, slot0)
	gohelper.fitScreenOffset(slot0._scrollViewTran)
	slot0:initInfo()
	slot0:setTipVisible(false)
	slot0:checkAndSetIconVisible()
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, slot0._onUpdateMapInfo, slot0)
end

function slot0._onUpdateMapInfo(slot0)
	slot0:initInfo()
	slot0:checkAndSetIconVisible()
end

function slot0.initInfo(slot0)
	slot0._monsterRuleIds = RougeMapModel.instance:getChoiceCollection()
	slot0._monsterRuleNum = slot0._monsterRuleIds and #slot0._monsterRuleIds or 0

	if RougeMapModel.instance:isNormalLayer() then
		slot0._ruleCo = RougeMapModel.instance:getLayerChoiceInfo(RougeMapModel.instance:getLayerId()) and slot3:getMapRuleCo()
	else
		slot0._ruleCo = nil
	end
end

function slot0.checkAndSetIconVisible(slot0)
	slot0:setIconVisible(slot0._monsterRuleNum and slot0._monsterRuleNum > 0 or slot0._ruleCo ~= nil)
end

function slot0.setIconVisible(slot0, slot1)
	slot0._canvasgroup.alpha = slot1 and 1 or 0
	slot0._canvasgroup.interactable = slot1
	slot0._canvasgroup.blocksRaycasts = slot1
end

function slot0.setTipVisible(slot0, slot1)
	gohelper.setActive(slot0._gotips, slot1)

	if not slot1 then
		return
	end

	slot0:refreshMapRule()
	slot0:refreshMonsterRules()
end

function slot0.closeTips(slot0)
	slot0:setTipVisible(false)
end

function slot0.refreshMapRule(slot0)
	gohelper.setActive(slot0._txttitle1, false)
	gohelper.setActive(slot0._txtdec1, false)

	if not slot0._ruleCo then
		return
	end

	gohelper.setActive(slot0._txttitle1, true)
	gohelper.setActive(slot0._txtdec1, true)

	slot0._txtdec1.text = SkillHelper.buildDesc(slot0._ruleCo and slot0._ruleCo.desc or "")
end

function slot0.clcikHyperLink(slot0, slot1, slot2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(slot1, function (slot0, slot1, slot2)
		slot2.pivot = GameUtil.checkClickPositionInRight(uv0) and CommonBuffTipEnum.Pivot.Right or CommonBuffTipEnum.Pivot.Left
		slot4, slot5 = recthelper.screenPosToAnchorPos2(uv0, slot1)

		recthelper.setAnchor(slot2, uv1._effectTipViewPosX, slot5 + CommonBuffTipEnum.DefaultInterval)
	end)
end

function slot0.refreshMonsterRules(slot0)
	slot1 = {
		[slot7] = true
	}

	for slot5, slot6 in ipairs(slot0._monsterRuleIds or {}) do
		slot7 = slot0:_getOrCreateMonsterRuleItem(slot5)
		slot7.txtdec.text = SkillHelper.buildDesc(RougeDLCConfig103.instance:getMonsterRuleConfig(slot6) and slot8.desc)

		gohelper.setActive(slot7.viewGO, true)
	end

	for slot5, slot6 in pairs(slot0._monsterRuleItemTab) do
		if not slot1[slot6] then
			gohelper.setActive(slot6.viewGO, false)
		end
	end

	gohelper.setActive(slot0._txttitle2.gameObject, slot0._monsterRuleNum > 0)
end

function slot0._getOrCreateMonsterRuleItem(slot0, slot1)
	if not slot0._monsterRuleItemTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.cloneInPlace(slot0._txtdec2.gameObject, "debuff_" .. slot1)
		slot2.txtdec = gohelper.onceAddComponent(slot2.viewGO, gohelper.Type_TextMesh)

		SkillHelper.addHyperLinkClick(slot2.txtdec, slot0.clcikHyperLink, slot0)

		slot0._monsterRuleItemTab[slot1] = slot2
	end

	return slot2
end

function slot0.onDestroy(slot0)
end

return slot0
