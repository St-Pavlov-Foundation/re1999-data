module("modules.logic.versionactivity2_7.towergift.view.TowerGiftFullView", package.seeall)

slot0 = class("TowerGiftFullView", BaseView)
slot0.TaskId = 92001101

function slot0.onInitView(slot0)
	slot0._btncheck = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_check")
	slot0._btn1Claim = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/reward1/go_canget/#btn_Claim")
	slot0._gocanget = gohelper.findChild(slot0.viewGO, "root/reward1/go_canget")
	slot0._goreceive = gohelper.findChild(slot0.viewGO, "root/reward1/go_receive")
	slot0._gotaskreceive = gohelper.findChild(slot0.viewGO, "root/reward2/go_receive")
	slot0._txtprogress = gohelper.findChildText(slot0.viewGO, "root/reward2/go_goto/#txt_progress")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "root/reward2/go_goto/#txt_desc")
	slot0._btngoto = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/reward2/go_goto/#btn_goto")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncheck:AddClickListener(slot0._btncheckOnClick, slot0)
	slot0._btn1Claim:AddClickListener(slot0._btn1ClaimOnClick, slot0)
	slot0._btngoto:AddClickListener(slot0._btngotoOnClick, slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, slot0.refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncheck:RemoveClickListener()
	slot0._btn1Claim:RemoveClickListener()
	slot0._btngoto:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, slot0.refreshUI, slot0)
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
	GameFacade.jump(JumpEnum.JumpView.Tower)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._actId = slot0.viewParam.actId

	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
	Activity101Rpc.instance:sendGet101InfosRequest(slot0._actId)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	if TowerTaskModel.instance:getActRewardTask() then
		slot2 = slot1.hasFinished

		gohelper.setActive(slot0._gotaskreceive, slot2)

		if slot2 then
			slot0._txtprogress.text = luaLang("p_v2a7_tower_fullview_txt_finished")
		end

		slot0._txtprogress.text = string.format("<#ec5d5d>%s</color>/%s", slot1.progress, slot1.config.maxProgress)
		slot0._txtdesc.text = slot1.config.desc
	end

	slot2 = slot0:checkReceied()

	gohelper.setActive(slot0._gocanget, not slot2)
	gohelper.setActive(slot0._goreceive, slot2)
end

function slot0.checkReceied(slot0)
	return ActivityType101Model.instance:isType101RewardCouldGet(slot0._actId, 1)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
