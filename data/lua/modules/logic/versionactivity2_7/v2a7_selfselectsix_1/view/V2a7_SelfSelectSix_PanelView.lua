module("modules.logic.versionactivity2_7.v2a7_selfselectsix_1.view.V2a7_SelfSelectSix_PanelView", package.seeall)

slot0 = class("V2a7_SelfSelectSix_PanelView", BaseView)

function slot0.onInitView(slot0)
	slot0._goClaim = gohelper.findChild(slot0.viewGO, "root/simage_panelbg/reward/#btn_Claim")
	slot0._gohasget = gohelper.findChild(slot0.viewGO, "root/simage_panelbg/reward/#go_hasget")
	slot0._btnClaim = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/simage_panelbg/reward/#btn_Claim")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_Close")
	slot0._btnemptyTop = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_emptyTop")
	slot0._btnemptyBottom = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_emptyBottom")
	slot0._btnemptyLeft = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_emptyLeft")
	slot0._btnemptyRight = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_emptyRight")
	slot0._btnGo = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_Go")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "root/simage_panelbg/#txt_desc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClaim:AddClickListener(slot0._btnClaimOnClick, slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
	slot0._btnemptyTop:AddClickListener(slot0._btnemptyTopOnClick, slot0)
	slot0._btnemptyBottom:AddClickListener(slot0._btnemptyBottomOnClick, slot0)
	slot0._btnemptyLeft:AddClickListener(slot0._btnemptyLeftOnClick, slot0)
	slot0._btnemptyRight:AddClickListener(slot0._btnemptyRightOnClick, slot0)
	slot0._btnGo:AddClickListener(slot0._btnGoOnClick, slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, slot0.refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClaim:RemoveClickListener()
	slot0._btnClose:RemoveClickListener()
	slot0._btnemptyTop:RemoveClickListener()
	slot0._btnemptyBottom:RemoveClickListener()
	slot0._btnemptyLeft:RemoveClickListener()
	slot0._btnemptyRight:RemoveClickListener()
	slot0._btnGo:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, slot0.refreshUI, slot0)
end

function slot0._btnClaimOnClick(slot0)
	if not slot0:checkReceied() and slot0:checkCanGet() then
		Activity101Rpc.instance:sendGet101BonusRequest(slot0._actId, 1)
	end
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyTopOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyBottomOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyLeftOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyRightOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnGoOnClick(slot0)
	slot0:closeThis()

	if ActivityModel.instance:getActMO(slot0._actId) and slot1.centerId then
		ActivityModel.instance:setTargetActivityCategoryId(slot0._actId)

		if slot1.centerId == ActivityEnum.ActivityType.Beginner then
			ActivityController.instance:openActivityBeginnerView()
		else
			ActivityController.instance:openActivityWelfareView()
		end
	end
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_day_night)

	slot0._actId = slot0.viewParam.actId
	slot0._actCo = ActivityConfig.instance:getActivityCo(slot0._actId)
	slot0._txtdesc.text = slot0._actCo.actDesc
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._goClaim, not slot0:checkReceied() and slot0:checkCanGet())
	gohelper.setActive(slot0._gohasget, slot1)
end

function slot0.checkReceied(slot0)
	return ActivityType101Model.instance:isType101RewardGet(slot0._actId, 1)
end

function slot0.checkCanGet(slot0)
	return ActivityType101Model.instance:isType101RewardCouldGet(slot0._actId, 1)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
