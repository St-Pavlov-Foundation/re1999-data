module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandResultView", package.seeall)

slot0 = class("CooperGarlandResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_success")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "#go_fail")
	slot0._gotargetitem = gohelper.findChild(slot0.viewGO, "targets/#go_targetitem")
	slot0._gofinish = gohelper.findChild(slot0.viewGO, "targets/#go_targetitem/result/#go_finish")
	slot0._gounfinish = gohelper.findChild(slot0.viewGO, "targets/#go_targetitem/result/#go_unfinish")
	slot0._gobtn = gohelper.findChild(slot0.viewGO, "#go_btn")
	slot0._btnquitgame = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_btn/#btn_quitgame")
	slot0._btnrestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_btn/#btn_restart")
	slot0._btnsuccessClick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_successClick")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnquitgame:AddClickListener(slot0._btnquitgameOnClick, slot0)
	slot0._btnrestart:AddClickListener(slot0._btnrestartOnClick, slot0)
	slot0._btnsuccessClick:AddClickListener(slot0._btnsuccessClickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnquitgame:RemoveClickListener()
	slot0._btnrestart:RemoveClickListener()
	slot0._btnsuccessClick:RemoveClickListener()
end

function slot0._btnquitgameOnClick(slot0)
	CooperGarlandStatHelper.instance:sendGameExit(slot0.viewName)
	CooperGarlandController.instance:exitGame()
	slot0:closeThis()
end

function slot0._btnrestartOnClick(slot0)
	CooperGarlandStatHelper.instance:sendMapReset(slot0.viewName)
	CooperGarlandController.instance:resetGame()
	slot0:closeThis()
end

function slot0._btnsuccessClickOnClick(slot0)
	CooperGarlandController.instance:exitGame()
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam and slot0.viewParam.isWin

	gohelper.setActive(slot0._gosuccess, slot1)
	gohelper.setActive(slot0._btnsuccessClick, slot1)
	gohelper.setActive(slot0._gofail, not slot1)
	gohelper.setActive(slot0._gobtn, not slot1)
	gohelper.setActive(slot0._gotargetitem, slot1)
	gohelper.setActive(slot0._gofinish, slot1)
	gohelper.setActive(slot0._gounfinish, not slot1)
	AudioMgr.instance:trigger(slot1 and AudioEnum2_7.CooperGarland.play_ui_pkls_endpoint_arrival or AudioEnum2_7.CooperGarland.play_ui_pkls_challenge_fail)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
