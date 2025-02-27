module("modules.logic.versionactivity2_6.enter.view.subview.VersionActivity2_6RougeEnterView", package.seeall)

slot0 = class("VersionActivity2_6RougeEnterView", BaseView)
slot1 = 103

function slot0.onInitView(slot0)
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_start")
	slot0._btnReward = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_reward")
	slot0._goRewardNew = gohelper.findChild(slot0.viewGO, "Right/#btn_reward/#go_new")
	slot0._txtRewardNum = gohelper.findChildText(slot0.viewGO, "Right/#btn_reward/#txt_RewardNum")
	slot0._btnlock = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_locked")
	slot0._txtUnlockedTips = gohelper.findChildText(slot0.viewGO, "Right/#btn_locked/#txt_UnLockedTips")
	slot0._btndlc = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_dlc")
	slot0._gostartreddot = gohelper.findChild(slot0.viewGO, "Right/#btn_start/#go_startreddot")
	slot0._goclosetipseffect = gohelper.findChild(slot0.viewGO, "Right/vx_glow")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnEnter:AddClickListener(slot0._btnEnterOnClick, slot0)
	slot0._btnReward:AddClickListener(slot0._btnRewardOnClick, slot0)
	slot0._btnlock:AddClickListener(slot0._btnLockOnClick, slot0)
	slot0._btndlc:AddClickListener(slot0._btndlcOnClick, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, slot0.refreshReward, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinishCallback, slot0)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, slot0.refreshLock, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEnter:RemoveClickListener()
	slot0._btnReward:RemoveClickListener()
	slot0._btnlock:RemoveClickListener()
	slot0._btndlc:RemoveClickListener()
	slot0:removeEventCb(RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, slot0.refreshReward, slot0)
	OpenController.instance:unregisterCallback(OpenEvent.NewFuncUnlock, slot0.refreshLock, slot0)
end

function slot0._btnEnterOnClick(slot0)
	RougeController.instance:openRougeMainView()
end

function slot0._btnRewardOnClick(slot0)
	RougeController.instance:openRougeRewardView()
end

function slot0._btnLockOnClick(slot0)
	slot1, slot2 = OpenHelper.getToastIdAndParam(slot0.config.openId)

	GameFacade.showToastWithTableParam(slot1, slot2)
end

function slot0._btndlcOnClick(slot0)
	if not uv0 or uv0 == 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.RougeDLCTipsView, {
		dlcId = uv0
	})
	gohelper.setActive(slot0._goclosetipseffect, false)
end

function slot0._editableInitView(slot0)
	slot0.animComp = VersionActivitySubAnimatorComp.get(slot0.viewGO, slot0)

	RedDotController.instance:addRedDot(slot0._gostartreddot, RedDotEnum.DotNode.RougeDLCNew)
end

function slot0.onOpen(slot0)
	slot0._season = RougeOutsideModel.instance:season()

	RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(slot0._season)
	slot0.animComp:playOpenAnim()

	slot0.actId = slot0.viewContainer.activityId
	slot0.config = ActivityConfig.instance:getActivityCo(slot0.actId)

	slot0:refreshLock()
	slot0:refreshReward()
	slot0:checkOpenDLCTipsView()
end

function slot0.refreshLock(slot0)
	slot2 = slot0.config.openId ~= 0 and not OpenModel.instance:isFunctionUnlock(slot1)

	gohelper.setActive(slot0._btnlock, slot2)
	gohelper.setActive(slot0._btnReward.gameObject, not slot2)

	if slot2 then
		slot3, slot4 = OpenHelper.getToastIdAndParam(slot0.config.openId)
		slot0._txtUnlockedTips.text = GameUtil.getSubPlaceholderLuaLang(ToastConfig.instance:getToastCO(slot3).tips, slot4)
	else
		slot0._txtUnlockedTips.text = ""
	end
end

function slot0.refreshReward(slot0)
	slot0._txtRewardNum.text = RougeRewardModel.instance:getRewardPoint()

	gohelper.setActive(slot0._goRewardNew, RougeRewardModel.instance:checkIsNewStage())
end

function slot0.checkOpenDLCTipsView(slot0)
	if not uv0 or uv0 == 0 then
		return
	end

	if string.nilorempty(PlayerPrefsHelper.getString(string.format("%s#%s#%s", PlayerPrefsKey.RougePopUpDLCTipsId, PlayerModel.instance:getMyUserId(), uv0), "")) then
		ViewMgr.instance:openView(ViewName.RougeDLCTipsView, {
			dlcId = uv0
		})
		PlayerPrefsHelper.setString(slot1, "true")
	end
end

function slot0._onCloseViewFinishCallback(slot0, slot1)
	if slot1 ~= ViewName.RougeDLCTipsView then
		return
	end

	gohelper.setActive(slot0._goclosetipseffect, true)
end

function slot0.onDestroyView(slot0)
	slot0.animComp:destroy()
end

return slot0
