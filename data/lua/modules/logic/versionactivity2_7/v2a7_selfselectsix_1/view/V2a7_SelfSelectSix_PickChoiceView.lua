module("modules.logic.versionactivity2_7.v2a7_selfselectsix_1.view.V2a7_SelfSelectSix_PickChoiceView", package.seeall)

slot0 = class("V2a7_SelfSelectSix_PickChoiceView", BaseView)

function slot0.onInitView(slot0)
	slot0._gopickchoice = gohelper.findChild(slot0.viewGO, "pickchoice")
	slot0._gooverview = gohelper.findChild(slot0.viewGO, "overview")
	slot0._txtnum = gohelper.findChildText(slot0._gopickchoice, "Tips2/#txt_num")
	slot0._btnoverview = gohelper.findChildButtonWithAudio(slot0.viewGO, "overview/#btn_close")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0._gopickchoice, "#btn_confirm")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0._gopickchoice, "#btn_cancel")
	slot0._scrollrule = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_rule")
	slot0._trsscrollrule = gohelper.findChild(slot0.viewGO, "#scroll_rule").transform
	slot0._trscontent = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/Content").transform
	slot0._gostoreItem = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem")
	slot0._txtlocked = gohelper.findChildText(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title/go_locked/#txt_locked")
	slot0._txtunlock = gohelper.findChildText(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/Title/go_unlock/#txt_unlock")
	slot0._gohero = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_hero")
	slot0._goexskill = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_hero/heroitem/role/#go_exskill")
	slot0._imageexskill = gohelper.findChildImage(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_hero/heroitem/role/#go_exskill/#image_exskill")
	slot0._goclick = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/#go_storeItem/#go_hero/heroitem/select/#go_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btncancel:AddClickListener(slot0.closeThis, slot0)
	slot0._btnoverview:AddClickListener(slot0.closeThis, slot0)
	slot0:addEventCb(V2a7_SelfSelectSix_PickChoiceController.instance, V2a7_SelfSelectSix_PickChoiceEvent.onCustomPickListChanged, slot0.refreshUI, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnconfirm:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
	slot0._btnoverview:RemoveClickListener()
	slot0:removeEventCb(V2a7_SelfSelectSix_PickChoiceController.instance, V2a7_SelfSelectSix_PickChoiceEvent.onCustomPickListChanged, slot0.refreshUI, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0._btnconfirmOnClick(slot0)
	V2a7_SelfSelectSix_PickChoiceController.instance:tryChoice(slot0.viewParam)
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	slot0._isPreview = slot0.viewParam and slot0.viewParam.isPreview

	gohelper.setActive(slot0._gopickchoice, not slot0._isPreview)
	gohelper.setActive(slot0._gooverview, slot0._isPreview)
	slot0:refreshSelectCount()

	if (V2a7_SelfSelectSix_PickChoiceListModel.instance:getLastUnlockIndex() - 1 > 0 and slot1 * slot3 or 0) > 266 * V2a7_SelfSelectSix_PickChoiceListModel.instance:getArrCount() + 30 - recthelper.getHeight(slot0._trsscrollrule) then
		slot6 = slot8
	end

	ZProj.TweenHelper.DOAnchorPosY(slot0._trscontent, slot6, 0.3)
end

function slot0.refreshUI(slot0)
	slot0:refreshSelectCount()
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.CharacterGetView then
		slot0:closeThis()
	end
end

function slot0.refreshSelectCount(slot0)
	slot1 = V2a7_SelfSelectSix_PickChoiceListModel.instance:getSelectCount()
	slot2 = V2a7_SelfSelectSix_PickChoiceListModel.instance:getMaxSelectCount()
	slot0._txtnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_custompick_selectnum"), {
		slot1,
		slot2
	})

	ZProj.UGUIHelper.SetGrayscale(slot0._btnconfirm.gameObject, slot1 ~= slot2)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
