module("modules.logic.versionactivity2_7.towergift.view.TowerGiftPanelView", package.seeall)

slot0 = class("TowerGiftPanelView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")
	slot0._btncheck = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_check")
	slot0._goClaim = gohelper.findChild(slot0.viewGO, "root/reward1/go_canget/#btn_Claim")
	slot0._goreceive = gohelper.findChild(slot0.viewGO, "root/reward1/go_receive")
	slot0._btn1Claim = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/reward1/go_canget/#btn_Claim")
	slot0._btngoto = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/reward2/go_goto/#btn_goto")
	slot0._btnicon = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/reward2/icon/click")
	slot0._goreceive2 = gohelper.findChild(slot0.viewGO, "root/reward2/go_receive")
	slot0._gogoto = gohelper.findChild(slot0.viewGO, "root/reward2/go_goto")
	slot0._golock = gohelper.findChild(slot0.viewGO, "root/reward2/go_lock")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "root/simage_fullbg/#txt_time")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btncheck:AddClickListener(slot0._btncheckOnClick, slot0)
	slot0._btn1Claim:AddClickListener(slot0._btn1ClaimOnClick, slot0)
	slot0._btngoto:AddClickListener(slot0._btngotoOnClick, slot0)
	slot0._btnicon:AddClickListener(slot0._btniconOnClick, slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, slot0.refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btncheck:RemoveClickListener()
	slot0._btn1Claim:RemoveClickListener()
	slot0._btngoto:RemoveClickListener()
	slot0._btnicon:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, slot0.refreshUI, slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btncheckOnClick(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, {
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Effect,
		heroId = TowerGiftEnum.ShowHeroList
	})
end

function slot0._btn1ClaimOnClick(slot0)
	if not slot0:checkReceied() and slot0:checkCanGet() then
		Activity101Rpc.instance:sendGet101BonusRequest(slot0._actId, 1)
	end
end

function slot0._btngotoOnClick(slot0)
	slot0:closeThis()
	ActivityModel.instance:setTargetActivityCategoryId(ActivityEnum.Activity.V2a7_TowerGift)
	ActivityController.instance:openActivityBeginnerView()
end

function slot0._btniconOnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Item, TowerGiftEnum.StoneUpTicketId)
end

function slot0.checkReceied(slot0)
	return ActivityType101Model.instance:isType101RewardGet(slot0._actId, 1)
end

function slot0.checkCanGet(slot0)
	return ActivityType101Model.instance:isType101RewardCouldGet(slot0._actId, 1)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)

	slot0._actId = slot0.viewParam.actId

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._goClaim, slot0:checkCanGet())
	gohelper.setActive(slot0._goreceive, slot0:checkReceied())

	slot0._txttime.text = ActivityHelper.getActivityRemainTimeStr(slot0._actId)

	gohelper.setActive(slot0._goreceive2, TowerTaskModel.instance:getActRewardTask() and slot3:isClaimed() or false)
	gohelper.setActive(slot0._gogoto, true)
	gohelper.setActive(slot0._golock, false)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
