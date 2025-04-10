module("modules.logic.versionactivity2_7.enter.view.subview.V2a6_CooperGarlandEnterView", package.seeall)

slot0 = class("V2a6_CooperGarlandEnterView", VersionActivityEnterBaseSubView)

function slot0.onInitView(slot0)
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "Right/#txt_Descr")
	slot0._txtlimittime = gohelper.findChildText(slot0.viewGO, "Right/#go_time/#txt_limittime")
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Enter")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "Right/#btn_Enter/#go_reddot")
	slot0._btnLocked = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Locked")
	slot0._btnTrial = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_Try/image_TryBtn")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnEnter:AddClickListener(slot0._btnEnterOnClick, slot0)
	slot0._btnLocked:AddClickListener(slot0._btnLockedOnClick, slot0)
	slot0._btnTrial:AddClickListener(slot0._btnTrialOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEnter:RemoveClickListener()
	slot0._btnLocked:RemoveClickListener()
	slot0._btnTrial:RemoveClickListener()
end

function slot0._btnEnterOnClick(slot0)
	CooperGarlandController.instance:openLevelView()
end

function slot0._btnLockedOnClick(slot0)
	slot1, slot2 = OpenHelper.getToastIdAndParam(slot0.actCo.openId)

	if slot1 and slot1 ~= 0 then
		GameFacade.showToastWithTableParam(slot1, slot2)
	end
end

function slot0._btnTrialOnClick(slot0)
	if CooperGarlandModel.instance:isAct192Open() then
		if slot0.actCo.tryoutEpisode <= 0 then
			logError("没有配置对应的试用关卡")

			return
		end

		DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot2).chapterId, slot2)
	else
		slot0:_btnLockedOnClick()
	end
end

function slot0._editableInitView(slot0)
	slot0.actId = CooperGarlandModel.instance:getAct192Id()
	slot0.actCo = ActivityConfig.instance:getActivityCo(slot0.actId)
	slot0._txtDescr.text = slot0.actCo.actDesc
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	slot0:_refreshTime()
	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.V2a7CooperGarland)
end

function slot0.everySecondCall(slot0)
	slot0:_refreshTime()
end

function slot0._refreshTime(slot0)
	slot0._txtlimittime.text, slot2 = CooperGarlandModel.instance:getAct192RemainTimeStr(slot0.actId)

	gohelper.setActive(slot0._txtlimittime.gameObject, not slot2)

	slot3 = CooperGarlandModel.instance:isAct192Open()

	gohelper.setActive(slot0._btnEnter, slot3)
	gohelper.setActive(slot0._btnLocked, not slot3)
end

return slot0
