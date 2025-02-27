module("modules.logic.versionactivity2_6.xugouji.view.XugoujiGameResultView", package.seeall)

slot0 = class("XugoujiGameResultView", BaseView)
slot1 = VersionActivity2_6Enum.ActivityId.Xugouji

function slot0.onInitView(slot0)
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg2")
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg1")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_successClick")
	slot0._btnExit = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_btn/#btn_quitgame")
	slot0._btnRestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_btn/#btn_restart")
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_success")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "#go_fail")
	slot0._goBtns = gohelper.findChild(slot0.viewGO, "#go_btn")
	slot0._goTargetRoot = gohelper.findChild(slot0.viewGO, "targets")
	slot0._goTargetItem = gohelper.findChild(slot0.viewGO, "targets/#go_targetitem")
	slot0._goTips = gohelper.findChild(slot0.viewGO, "content/Layout/#go_Tips")
	slot0._txtTips = gohelper.findChildText(slot0.viewGO, "Tips/#txt_Tips")
	slot0._scrollItem = gohelper.findChild(slot0.viewGO, "#scroll_List/Viewport/Content/#go_Item")
	slot0._gorewardContent = gohelper.findChild(slot0.viewGO, "#scroll_List/Viewport/Content")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnExit:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnRestart:AddClickListener(slot0._btnRestartOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnExit:RemoveClickListener()
	slot0._btnRestart:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	if slot0:isLockOp() then
		return
	end

	XugoujiController.instance:gameResultOver()
end

function slot0._btnRestartOnClick(slot0)
	if slot0:isLockOp() then
		return
	end

	slot0:closeThis()
	XugoujiController.instance:restartEpisode()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._animator = slot0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)

	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.ExitGame, slot0.onExitGame, slot0)

	if slot0.viewContainer then
		NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0._btncloseOnClick, slot0)
	end

	slot0:_setLockOpTime(1)
	slot0:refreshUI()
end

function slot0.onExitGame(slot0)
	XugoujiController.instance:getStatMo():sendDungeonFinishStatData()
	slot0:closeThis()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.playViewAnimator(slot0, slot1)
	if slot0._animator then
		slot0._animator.enabled = true

		slot0._animator:Play(slot1, 0, 0)
	end
end

function slot0.refreshUI(slot0)
	slot1 = Activity188Model.instance:getCurEpisodeId()
	slot0._star = slot0.viewParam.star
	slot3 = slot0.viewParam.reason == XugoujiEnum.ResultEnum.Completed
	slot6 = slot2 == XugoujiEnum.ResultEnum.PowerUseup or slot2 == XugoujiEnum.ResultEnum.Quit

	gohelper.setActive(slot0._gosuccess, slot3)
	gohelper.setActive(slot0._gofail, slot6)
	gohelper.setActive(slot0._goBtns, slot6)
	gohelper.setActive(slot0._btnclose.gameObject, slot3)
	AudioMgr.instance:trigger(slot6 and AudioEnum.VersionActivity2_2Lopera.play_ui_pkls_challenge_fail or AudioEnum.VersionActivity2_2Lopera.play_ui_pkls_endpoint_arriva)
	slot0:_createTargetList()
end

function slot0._createTargetList(slot0)
	slot0._targetDataList = {}

	for slot7, slot8 in ipairs(string.split(Activity188Config.instance:getGameCfg(uv0, Activity188Model.instance:getCurGameId()).passRound, "#")) do
		table.insert(slot0._targetDataList, slot8)
	end

	gohelper.CreateObjList(slot0, slot0._createTargetItem, slot0._targetDataList, slot0._goTargetRoot, slot0._goTargetItem)
end

function slot0._createTargetItem(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1, true)

	gohelper.findChildText(slot1, "#txt_taskdesc").text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("xugouji_round_target"), slot2)

	gohelper.setActive(gohelper.findChild(slot1, "result/#go_finish"), slot3 <= slot0._star)
	gohelper.setActive(gohelper.findChild(slot1, "result/#go_unfinish"), slot0._star < slot3)
end

function slot0._setLockOpTime(slot0, slot1)
	slot0._lockTime = Time.time + slot1
end

function slot0.isLockOp(slot0)
	if slot0._lockTime and Time.time < slot0._lockTime then
		return true
	end

	return false
end

return slot0
