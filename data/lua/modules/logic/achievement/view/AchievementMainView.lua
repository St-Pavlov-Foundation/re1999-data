module("modules.logic.achievement.view.AchievementMainView", package.seeall)

slot0 = class("AchievementMainView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocategoryitem = gohelper.findChild(slot0.viewGO, "#scroll_category/categorycontent/#go_categoryitem")
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageBottomBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_BottomBG")
	slot0._btnedit = gohelper.findChildButtonWithAudio(slot0.viewGO, "Bottom/Edit/#btn_edit")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "#go_groupTips/image_TipsBG/#txt_Descr")
	slot0._btnswitchscrolltype = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_switchscrolltype")
	slot0._scrollcontent = gohelper.findChildScrollRect(slot0.viewGO, "#go_container/#scroll_content")
	slot0._scrolllist = gohelper.findChildScrollRect(slot0.viewGO, "#go_container/#scroll_list")
	slot0._btnrare = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_sort/#btn_rare")
	slot0._btnunlocktime = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_sort/#btn_unlocktime")
	slot0._txtunlockcount = gohelper.findChildText(slot0.viewGO, "Bottom/UnLockCount/image_UnLockBG/#txt_unlockcount")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_container/#go_empty")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnedit:AddClickListener(slot0._btneditOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnedit:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(AchievementMainController.instance, AchievementEvent.AchievementMainViewUpdate, slot0.refreshUI, slot0)
	slot0:addEventCb(AchievementController.instance, AchievementEvent.UpdateAchievementState, slot0.updateAchievementState, slot0)
	slot0._simageFullBG:LoadImage(ResUrl.getAchievementIcon("achievement_editfullbg"))
	slot0._simageBottomBG:LoadImage(ResUrl.getAchievementIcon("achievement_editbottombg"))
	slot0:initCategory()
end

function slot0.onDestroyView(slot0)
	if slot0._categoryItems then
		for slot4, slot5 in pairs(slot0._categoryItems) do
			slot5.btnself:RemoveClickListener()
		end

		slot0._categoryItems = nil
	end

	slot0._simageFullBG:UnLoadImage()
	slot0._simageBottomBG:UnLoadImage()
	AchievementMainController.instance:onCloseView()
end

function slot0.onOpen(slot0)
	slot5 = slot0.viewParam and slot0.viewParam.focusDataId

	AchievementMainController.instance:onOpenView(slot0.viewParam and slot0.viewParam.categoryType, slot0.viewParam and slot0.viewParam.viewType, slot0.viewParam and slot0.viewParam.sortType, slot0.viewParam and slot0.viewParam.filterType)

	if slot0.viewParam and slot0.viewParam.isOpenLevelView and slot5 and (slot0.viewParam and slot0.viewParam.achievementType) == AchievementEnum.AchievementType.Single then
		AchievementController.instance:openAchievementLevelView(slot5)
	end

	slot0:refreshUI()
end

function slot0.updateAchievementState(slot0)
	AchievementMainController.instance:updateAchievementState()
	slot0:refreshUI()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(AchievementMainController.instance, AchievementEvent.AchievementMainViewUpdate, slot0.refreshUI, slot0)
	slot0:removeEventCb(AchievementController.instance, AchievementEvent.UpdateAchievementState, slot0.updateAchievementState, slot0)
end

function slot0.refreshUI(slot0)
	slot0:refreshCategory()
	slot0:refreshUnlockCount()
	slot0:refreshEmptyUI()
end

function slot0.refreshCategory(slot0)
	for slot5, slot6 in pairs(slot0._categoryItems) do
		slot7 = AchievementMainCommonModel.instance:getCurrentCategory() == slot0._focusTypes[slot5]

		gohelper.setActive(slot6.goselected, slot7)
		gohelper.setActive(slot6.gounselected, not slot7)

		slot8 = AchievementMainCommonModel.instance:categoryHasNew(slot0._focusTypes[slot5])

		gohelper.setActive(slot6.goreddot1, slot8)
		gohelper.setActive(slot6.goreddot2, slot8)
	end
end

function slot0.refreshUnlockCount(slot0)
	slot2, slot3 = AchievementMainCommonModel.instance:getCategoryAchievementUnlockInfo(AchievementMainCommonModel.instance:getCurrentCategory())
	slot0._txtunlockcount.text = GameUtil.getSubPlaceholderLuaLang(luaLang("achievementmainview_unlockTaskCount"), {
		slot3,
		slot2
	})
end

function slot0.refreshEmptyUI(slot0)
	gohelper.setActive(slot0._goempty, AchievementMainCommonModel.instance:isCurrentViewBagEmpty())
end

function slot0.initCategory(slot0)
	slot0._focusTypes = {
		AchievementEnum.Type.Story,
		AchievementEnum.Type.Normal,
		AchievementEnum.Type.GamePlay,
		AchievementEnum.Type.Activity
	}
	slot0._categoryItems = {}

	for slot4, slot5 in pairs(slot0._focusTypes) do
		slot6 = slot0:getUserDataTb_()
		slot6.go = gohelper.cloneInPlace(slot0._gocategoryitem, "category_" .. tostring(slot4))

		gohelper.setActive(slot6.go, true)

		slot6.gounselected = gohelper.findChild(slot6.go, "go_unselected")
		slot6.txtitemcn1 = gohelper.findChildText(slot6.go, "go_unselected/txt_itemcn1")
		slot6.txtitemen1 = gohelper.findChildText(slot6.go, "go_unselected/txt_itemen1")
		slot6.goselected = gohelper.findChild(slot6.go, "go_selected")
		slot6.txtitemcn2 = gohelper.findChildText(slot6.go, "go_selected/txt_itemcn2")
		slot6.txtitemen2 = gohelper.findChildText(slot6.go, "go_selected/txt_itemen2")
		slot6.btnself = gohelper.findChildButtonWithAudio(slot6.go, "btn_self")

		slot6.btnself:AddClickListener(slot0.onClickCategory, slot0, slot4)

		slot6.goreddot1 = gohelper.findChild(slot6.go, "go_unselected/txt_itemcn1/#go_reddot1")
		slot6.goreddot2 = gohelper.findChild(slot6.go, "go_selected/txt_itemcn2/#go_reddot2")
		slot8 = AchievementEnum.TypeNameEn[slot5]

		if not string.nilorempty(AchievementEnum.TypeName[slot5]) then
			slot6.txtitemcn1.text = luaLang(slot7)
			slot6.txtitemcn2.text = luaLang(slot7)
			slot6.txtitemen1.text = tostring(slot8)
			slot6.txtitemen2.text = tostring(slot8)
		end

		slot0._categoryItems[slot4] = slot6
	end
end

function slot0.onClickCategory(slot0, slot1)
	if AchievementMainCommonModel.instance:getCurrentCategory() == slot0._focusTypes[slot1] then
		return
	end

	AchievementMainController.instance:setCategory(slot3)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_switch)
end

function slot0._btneditOnClick(slot0)
	ViewMgr.instance:openView(ViewName.AchievementSelectView)

	if slot0.viewParam.jumpFrom == ViewName.AchievementSelectView then
		slot0:closeThis()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_thumbnail_click)
end

return slot0
