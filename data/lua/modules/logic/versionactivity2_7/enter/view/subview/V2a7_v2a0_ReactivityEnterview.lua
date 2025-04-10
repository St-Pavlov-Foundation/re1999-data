module("modules.logic.versionactivity2_7.enter.view.subview.V2a7_v2a0_ReactivityEnterview", package.seeall)

slot0 = class("V2a7_v2a0_ReactivityEnterview", ReactivityEnterview)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "img/#simage_bg")
	slot0._gospine = gohelper.findChild(slot0.viewGO, "#go_spine")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "logo/#txt_dec")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "logo/actbg/Layout/#txt_time")
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_enter")
	slot0._btnEnd = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_Finished")
	slot0._btnLock = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_Locked")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "entrance/#btn_enter/#go_reddot")
	slot0._txtlockedtips = gohelper.findChildText(slot0.viewGO, "entrance/#btn_enter/locked/#txt_lockedtips")
	slot0._btnstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_store")
	slot0._txtNum = gohelper.findChildText(slot0.viewGO, "entrance/#btn_store/normal/#txt_num")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "entrance/#btn_store/#go_time")
	slot0._txtstoretime = gohelper.findChildText(slot0.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	slot0._btnreplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_replay")
	slot0._btnAchevement = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_achievementpreview")
	slot0._btnExchange = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_Exchange")
	slot0.rewardItems = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnAchevement:AddClickListener(slot0._onClickAchevementBtn, slot0)
	slot0._btnstore:AddClickListener(slot0._onClickStoreBtn, slot0)
	slot0._btnEnter:AddClickListener(slot0._onClickEnter, slot0)
	slot0._btnreplay:AddClickListener(slot0._onClickReplay, slot0)
	slot0._btnExchange:AddClickListener(slot0._onClickExchange, slot0)
	slot0._btnEnd:AddClickListener(slot0._onClickEnter, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnAchevement:RemoveClickListener()
	slot0._btnstore:RemoveClickListener()
	slot0._btnEnter:RemoveClickListener()
	slot0._btnreplay:RemoveClickListener()
	slot0._btnExchange:RemoveClickListener()
	slot0._btnEnd:RemoveClickListener()
end

function slot0._onClickEnter(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(slot0.actId)

	if slot1 ~= ActivityEnum.ActivityStatus.Normal then
		if slot2 then
			GameFacade.showToastWithTableParam(slot2, slot3)
		end

		return
	end

	VersionActivity2_0DungeonController.instance:openVersionActivityDungeonMapView()
end

function slot0.initRedDot(slot0)
	if slot0.actId then
		return
	end

	slot0.actId = VersionActivity2_7Enum.ActivityId.Reactivity

	RedDotController.instance:addRedDot(slot0._goreddot, ActivityConfig.instance:getActivityCo(slot0.actId).redDotId)
end

return slot0
