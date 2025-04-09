module("modules.logic.versionactivity2_7.act191.view.Act191CharacterExSkillView", package.seeall)

slot0 = class("Act191CharacterExSkillView", BaseView)

function slot0.onInitView(slot0)
	slot0._golvProgress = gohelper.findChild(slot0.viewGO, "#go_lvProgress")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "materialCost/#go_item")
	slot0._goskillDetailTipView = gohelper.findChild(slot0.viewGO, "#go_skillDetailTipView")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#go_skillDetailTipView/tipViewBg/#go_arrow")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content")
	slot0._godescripteList = gohelper.findChild(slot0.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content/#go_descripteList")
	slot0._godescitem = gohelper.findChild(slot0.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content/#go_descripteList/descripteitem")
	slot0._goBuffContainer = gohelper.findChild(slot0.viewGO, "#go_buffContainer")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot0.NormalDescColor = "#b1b1b1"
slot0.NotHaveDescColor = "#b1b1b1"
slot0.NormalDescColorA = 1
slot0.NotHaveDescColorA = 0.4

function slot0._onEscapeBtnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.goCircleNormal1 = gohelper.findChild(slot0.viewGO, "go_skills/#simage_circleup")
	slot0.goCircleNormal2 = gohelper.findChild(slot0.viewGO, "go_skills/#simage_circledown")
	slot0.goCircleMax1 = gohelper.findChild(slot0.viewGO, "go_skills/#simage_maxup")
	slot0.goCircleMax2 = gohelper.findChild(slot0.viewGO, "go_skills/#simage_maxdown")
	slot0._gocircle1 = gohelper.findChild(slot0.viewGO, "go_skills/decoration/#go_circle1")
	slot0._gocircle5 = gohelper.findChild(slot0.viewGO, "go_skills/decoration/#go_circle5")
	slot0._gosignature = gohelper.findChild(slot0.viewGO, "go_skills/signature")
	slot0._goclickani = gohelper.findChild(slot0.viewGO, "go_skills/click/ani")
	slot0._gomaxani = gohelper.findChild(slot0.viewGO, "go_skills/max/ani")
	slot0._simagefulllevel = gohelper.findChildSingleImage(slot0.viewGO, "go_skills/decoration/#simage_fulllevel")
	slot0._scrollskillDetailTipScroll = gohelper.findChildScrollRect(slot0.viewGO, "#go_skillDetailTipView/skillDetailTipScroll")

	slot0._scrollskillDetailTipScroll:AddOnValueChanged(slot0._refreshArrow, slot0)

	slot4 = "zs_02"

	slot0._simagefulllevel:LoadImage(ResUrl.getCharacterExskill(slot4))

	slot0.skillContainerGo = gohelper.findChild(slot0.viewGO, "go_skills")
	slot0.skillCardGoDict = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot5.icon = gohelper.findChildSingleImage(slot0.skillContainerGo, string.format("skillicon%s/ani/imgIcon", slot4))
		slot5.tagIcon = gohelper.findChildSingleImage(slot0.skillContainerGo, string.format("skillicon%s/ani/tag/tagIcon", slot4))
		slot0.skillCardGoDict[slot4] = slot5
	end

	slot0._buffBg = gohelper.findChild(slot0.viewGO, "#go_buffContainer/buff_bg")
	slot0._buffBgClick = gohelper.getClick(slot0._buffBg)
	slot4 = slot0

	slot0._buffBgClick:AddClickDownListener(slot0.hideBuffContainer, slot4)

	slot0._goBuffItem = gohelper.findChild(slot0.viewGO, "#go_buffContainer/#go_buffitem")
	slot0._txtBuffName = gohelper.findChildText(slot0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name")
	slot0._goBuffTag = gohelper.findChild(slot0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag")
	slot0._txtBuffTagName = gohelper.findChildText(slot0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag/bg/txt_tagname")
	slot0._txtBuffDesc = gohelper.findChildText(slot0.viewGO, "#go_buffContainer/#go_buffitem/txt_desc")
	slot0.golvList = slot0:getUserDataTb_()

	for slot4 = 1, CharacterEnum.MaxSkillExLevel do
		table.insert(slot0.golvList, gohelper.findChild(slot0.viewGO, "#go_lvProgress/#go_lv" .. slot4))
	end

	gohelper.setActive(slot0._goBuffContainer, false)
	gohelper.setActive(slot0._godescitem, false)
	gohelper.setActive(slot0._gosignature, false)

	slot0.goSignatureAnimator = slot0._gosignature:GetComponent(typeof(UnityEngine.Animator))
	slot0.viewGoAnimator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0.viewGoAniEventWrap = slot0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	slot0.viewGoAniEventWrap:AddEventListener("end", slot0.onAniEnd, slot0)
	slot0.viewGoAniEventWrap:AddEventListener("refreshUI", slot0.onAniRefreshUI, slot0)
	slot0.viewGoAniEventWrap:AddEventListener("onJumpTargetFrame", slot0.onJumpTargetFrame, slot0)

	slot0.goClickAnimation = slot0._goclickani:GetComponent(typeof(UnityEngine.Animation))
	slot0.maxBuffContainerWidth = 570
end

function slot0.initViewParam(slot0)
	slot0.config = slot0.viewParam.config
	slot0.exSkillLevel = slot0.config.exLevel
end

function slot0.onOpen(slot0)
	slot0:initViewParam()
	slot0:_refreshUI()

	if slot0:_isSkillLevelTop() then
		gohelper.setActive(slot0._gosignature, true)
		slot0.goSignatureAnimator:Play(UIAnimationName.Open)
	end

	if slot0:_isSkillLevelTop() then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_mould_opengeneral)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_mould_open)
	end

	NavigateMgr.instance:addEscape(ViewName.Act191CharacterExSkillView, slot0._onEscapeBtnClick, slot0)
end

function slot0.onUpdateParam(slot0)
	slot0:initViewParam()
	slot0:_refreshUI()
	gohelper.setActive(slot0._gosignature, slot0:_isSkillLevelTop())
end

function slot0._refreshUI(slot0)
	slot0:refreshCircleAnimation()
	slot0:refreshSkillCardInfo()
	slot0:refreshExLevel()
	slot0:showSkillDetail()
	slot0:setSkillLevelTop(slot0:_isSkillLevelTop())
end

function slot0.refreshCircleAnimation(slot0)
	slot1 = slot0:_isSkillLevelTop()

	gohelper.setActive(slot0.goCircleNormal1, not slot1)
	gohelper.setActive(slot0.goCircleNormal2, not slot1)
	gohelper.setActive(slot0.goCircleMax1, slot1)
	gohelper.setActive(slot0.goCircleMax2, slot1)
end

function slot0.refreshSkillCardInfo(slot0)
	slot2, slot3 = nil

	for slot7 = 1, 3 do
		if not lua_skill.configDict[Activity191Config.instance:getHeroSkillIdDic(slot0.config.id, true)[slot7]] then
			logError(string.format("heroID : %s, skillId not found : %s", slot0.config.id, slot3))
		end

		slot0.skillCardGoDict[slot7].icon:LoadImage(ResUrl.getSkillIcon(slot2.icon))
		slot0.skillCardGoDict[slot7].tagIcon:LoadImage(ResUrl.getAttributeIcon("attribute_" .. slot2.showTag))
	end
end

function slot0.refreshExLevel(slot0)
	for slot4 = 1, slot0.exSkillLevel do
		gohelper.setActive(slot0.golvList[slot4], true)
	end

	for slot4 = slot0.exSkillLevel + 1, CharacterEnum.MaxSkillExLevel do
		gohelper.setActive(slot0.golvList[slot4], false)
	end
end

function slot0.setSkillLevelTop(slot0, slot1)
	if slot1 then
		recthelper.setHeight(slot0._scrollskillDetailTipScroll.transform, 638)
	else
		recthelper.setHeight(slot0._scrollskillDetailTipScroll.transform, 750)
	end

	gohelper.setActive(slot0._simagefulllevel.gameObject, slot1)
	gohelper.setActive(slot0._gocircle5, slot1)
	gohelper.setActive(slot0._gocircle1, slot1 == false)
end

function slot0._refreshArrow(slot0)
	if slot0._scrollskillDetailTipScroll.verticalNormalizedPosition > 0.01 then
		gohelper.setActive(slot0._goarrow, true)
	else
		gohelper.setActive(slot0._goarrow, false)
	end
end

function slot0._isSkillLevelTop(slot0)
	return slot0.exSkillLevel == CharacterEnum.MaxSkillExLevel
end

function slot0.onAniEnd(slot0)
	gohelper.setActive(slot0._goJumpAnimationMask, false)
	gohelper.setActive(slot0._goclickani, true)
	gohelper.setActive(slot0._gomaxani, true)
end

function slot0.onAniRefreshUI(slot0)
	slot0:_refreshUI()
end

function slot0.onJumpTargetFrame(slot0)
	slot0.inPreTargetFrame = false
end

function slot0.resetJumpValue(slot0)
	slot0.inPreTargetFrame = true
	slot0.jumped = false
end

function slot0.showSkillDetail(slot0)
	slot1 = 0
	slot2 = 0

	for slot6 = 1, CharacterEnum.MaxSkillExLevel do
		slot7 = slot0:addDescItem(slot6)

		if slot6 == slot0.exSkillLevel then
			slot2 = slot1
		end

		slot1 = slot1 + slot7
	end

	slot0._goContent:SetActive(true)
	slot0:rebuildLayout()
	recthelper.setAnchorY(slot0._goContent.transform, slot2)
end

function slot0.rebuildLayout(slot0)
	ZProj.UGUIHelper.RebuildLayout(slot0._godescripteList.transform)
	slot0:_refreshArrow()
end

function slot0.addDescItem(slot0, slot1)
	slot0._descList = slot0._descList or slot0:getUserDataTb_()

	if not slot0._descList[slot1] then
		slot2 = Act191CharacterSkillDesc.New()
		slot3 = gohelper.clone(slot0._godescitem, slot0._godescripteList)

		slot3:SetActive(true)
		slot2:initView(slot3)

		slot0._descList[slot1] = slot2
	end

	return slot2:updateInfo(slot0, slot0.config, slot1)
end

function slot0.showBuffContainer(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot0._goBuffContainer, true)

	slot0.buffItemWidth = GameUtil.getTextWidthByLine(slot0._txtBuffDesc, slot2, 24)
	slot0.buffItemWidth = slot0.buffItemWidth + 70

	if slot0.maxBuffContainerWidth < slot0.buffItemWidth then
		slot0.buffItemWidth = slot0.maxBuffContainerWidth
	end

	slot0._txtBuffName.text = slot1
	slot0._txtBuffDesc.text = slot2
	slot4 = FightConfig.instance:getBuffTag(slot1)

	gohelper.setActive(slot0._goBuffTag, not string.nilorempty(slot4))

	slot0._txtBuffTagName.text = slot4
	slot5 = recthelper.screenPosToAnchorPos(slot3, slot0.viewGO.transform)

	recthelper.setAnchor(slot0._goBuffItem.transform, slot5.x - 20, slot5.y)
end

function slot0.hideBuffContainer(slot0)
	gohelper.setActive(slot0._goBuffContainer, false)
end

function slot0.getShowAttributeOption(slot0)
	return CharacterEnum.showAttributeOption.ShowCurrent
end

function slot0.onClose(slot0)
	for slot4, slot5 in ipairs(slot0._descList) do
		slot5:onClose()
	end
end

function slot0.onDestroyView(slot0)
	slot0._buffBgClick:RemoveClickDownListener()
	slot0._scrollskillDetailTipScroll:RemoveOnValueChanged()
	slot0._simagefulllevel:UnLoadImage()
	slot0.viewGoAniEventWrap:RemoveAllEventListener()

	for slot4, slot5 in pairs(slot0.skillCardGoDict) do
		slot5.icon:UnLoadImage()
		slot5.tagIcon:UnLoadImage()
	end
end

return slot0
