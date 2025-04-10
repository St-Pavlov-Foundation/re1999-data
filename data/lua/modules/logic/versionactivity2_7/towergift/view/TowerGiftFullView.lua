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
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "root/reward2/go_goto/txt_dec")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "root/simage_fullbg/#txt_time")
	slot0._gogoto = gohelper.findChild(slot0.viewGO, "root/reward2/go_goto")
	slot0._golock = gohelper.findChild(slot0.viewGO, "root/reward2/go_lock")
	slot0._btngoto = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/reward2/go_goto/#btn_goto")
	slot0._btnicon = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/reward2/icon/click")
	slot0._bgmId = nil

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncheck:AddClickListener(slot0._btncheckOnClick, slot0)
	slot0._btn1Claim:AddClickListener(slot0._btn1ClaimOnClick, slot0)
	slot0._btngoto:AddClickListener(slot0._btngotoOnClick, slot0)
	slot0._btnicon:AddClickListener(slot0._btniconOnClick, slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, slot0.refreshUI, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, slot0.refreshUI, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, slot0.refreshUI, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.checkBgm, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncheck:RemoveClickListener()
	slot0._btn1Claim:RemoveClickListener()
	slot0._btngoto:RemoveClickListener()
	slot0._btnicon:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, slot0.refreshUI, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerRefreshTask, slot0.refreshUI, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.TowerTaskUpdated, slot0.refreshUI, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.checkBgm, slot0)
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
	if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Tower) then
		TowerController.instance:openTowerTaskView()

		slot0._bgmId = BGMSwitchModel.instance:getCurBgm()
	else
		slot1, slot2, slot3 = JumpController.instance:canJumpNew(JumpEnum.JumpView.Tower)

		if not slot1 then
			GameFacade.showToastWithTableParam(slot2, slot3)

			return false
		end
	end
end

function slot0._btniconOnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Item, TowerGiftEnum.StoneUpTicketId)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)

	if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Tower) then
		TowerRpc.instance:sendGetTowerInfoRequest()
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Tower
		})
	end

	slot0._actId = slot0.viewParam.actId

	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
	Activity101Rpc.instance:sendGet101InfosRequest(slot0._actId)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot2 = nil

	if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Tower) then
		slot2 = TowerTaskModel.instance:getActRewardTask()
	end

	if slot1 then
		if not (slot2 and next(slot2)) then
			gohelper.setActive(slot0._golock, true)
			gohelper.setActive(slot0._gogoto, false)
		else
			gohelper.setActive(slot0._golock, false)
			gohelper.setActive(slot0._gogoto, true)
		end
	else
		gohelper.setActive(slot0._golock, true)
		gohelper.setActive(slot0._gogoto, false)
	end

	if slot2 then
		slot4 = slot2:isClaimed()

		gohelper.setActive(slot0._gotaskreceive, slot4)
		gohelper.setActive(slot0._gogoto, not slot4)

		if slot4 then
			slot0._txtprogress.text = luaLang("p_v2a7_tower_fullview_txt_finished")
		end

		gohelper.setActive(slot0._txtprogress.gameObject, true)

		slot0._txtprogress.text = string.format("<#ec5d5d>%s</color>/%s", slot2.progress, slot2.config.maxProgress)
	end

	gohelper.setActive(slot0._gocanget, slot0:checkCanGet())
	gohelper.setActive(slot0._goreceive, slot0:checkReceied())

	slot0._txttime.text = ActivityHelper.getActivityRemainTimeStr(slot0._actId)
end

function slot0.checkReceied(slot0)
	return ActivityType101Model.instance:isType101RewardGet(slot0._actId, 1)
end

function slot0.checkCanGet(slot0)
	return ActivityType101Model.instance:isType101RewardCouldGet(slot0._actId, 1)
end

function slot0.checkBgm(slot0, slot1)
	if slot1 == ViewName.TowerMainView then
		if slot0._bgmId and slot0._bgmId ~= -1 then
			AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Main, BGMSwitchConfig.instance:getBGMSwitchCO(slot0._bgmId) and slot2.audio)
		else
			if BGMSwitchModel.instance:isRandomBgmId(BGMSwitchModel.instance:getUsedBgmIdFromServer()) then
				slot2 = BGMSwitchModel.instance:nextBgm(1, true)
			end

			AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Main, BGMSwitchConfig.instance:getBGMSwitchCO(slot2) and slot3.audio or AudioEnum.UI.Play_Replay_Music_Daytime)
		end
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
