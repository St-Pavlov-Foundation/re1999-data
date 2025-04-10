module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6GameResult", package.seeall)

slot0 = class("LengZhou6GameResult", BaseView)

function slot0.onInitView(slot0)
	slot0._gotop = gohelper.findChild(slot0.viewGO, "#go_top")
	slot0._txtstage = gohelper.findChildText(slot0.viewGO, "#go_top/#txt_stage")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_top/#txt_name")
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_success")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "#go_fail")
	slot0._gotargetitem = gohelper.findChild(slot0.viewGO, "targets/#go_targetitem")
	slot0._txttaskdesc = gohelper.findChildText(slot0.viewGO, "targets/#go_targetitem/#txt_taskdesc")
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
	slot0:close()
end

function slot0._btnrestartOnClick(slot0)
	slot0._isCloseGameView = false

	slot0:close()
	LengZhou6Controller.instance:restartGame()
end

function slot0._btnsuccessClickOnClick(slot0)
	slot0:close()
end

function slot0.close(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._isCloseGameView = true

	slot0:initInfo()
	slot0:initResult()
	LengZhou6StatHelper.instance:sendGameExit()
end

function slot0.initInfo(slot0)
	slot1 = LengZhou6GameModel.instance:getEpisodeConfig()
	slot0._txtname.text = slot1.name
	slot0._txtstage.text = string.format("STAGE %s", slot1.episodeId - 1270200)
end

function slot0.initResult(slot0)
	slot1 = LengZhou6GameModel.instance:playerIsWin()

	gohelper.setActive(slot0._gofail, not slot1)
	gohelper.setActive(slot0._gosuccess, slot1)
	gohelper.setActive(slot0._gobtn, not slot1)
	AudioMgr.instance:trigger(slot1 and AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_success or AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_fail)
	LengZhou6StatHelper.instance:setGameResult(slot1 and LengZhou6Enum.GameResult.win or LengZhou6Enum.GameResult.lose)
end

function slot0.onClose(slot0)
	LengZhou6GameController.instance:levelGame(slot0._isCloseGameView)
end

return slot0
