module("modules.logic.versionactivity2_7.towergift.view.TowerGiftPanelView", package.seeall)

slot0 = class("TowerGiftPanelView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")
	slot0._btncheck = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_check")
	slot0._goClaim = gohelper.findChild(slot0.viewGO, "root/reward1/go_canget/#btn_Claim")
	slot0._btn1Claim = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/reward1/go_canget/#btn_Claim")
	slot0._btngoto = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/reward2/go_goto/#btn_goto")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btncheck:AddClickListener(slot0._btncheckOnClick, slot0)
	slot0._btn1Claim:AddClickListener(slot0._btn1ClaimOnClick, slot0)
	slot0._btngoto:AddClickListener(slot0._btngotoOnClick, slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, slot0.refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btncheck:RemoveClickListener()
	slot0._btn1Claim:RemoveClickListener()
	slot0._btngoto:RemoveClickListener()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, slot0.refreshUI, slot0)
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
	if not slot0:checkReceived() then
		Activity101Rpc.instance:sendGet101BonusRequest(slot0._actId, 1)
	end
end

function slot0._btngotoOnClick(slot0)
	ActivityModel.instance:setTargetActivityCategoryId(ActivityEnum.Activity.V2a7_TowerGift)
	ActivityController.instance:openActivityBeginnerView()
end

function slot0.checkReceived(slot0)
	return ActivityType101Model.instance:isType101RewardCouldGet(slot0._actId, 1)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._actId = slot0.viewParam.actId
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._goClaim, not slot0:checkReceied())
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
