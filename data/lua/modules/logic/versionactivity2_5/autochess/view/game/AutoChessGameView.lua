module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessGameView", package.seeall)

slot0 = class("AutoChessGameView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotouch = gohelper.findChild(slot0.viewGO, "UI/#go_touch")
	slot0._goFightRoot = gohelper.findChild(slot0.viewGO, "UI/#go_FightRoot")
	slot0._btnStop = gohelper.findChildButtonWithAudio(slot0.viewGO, "UI/#go_FightRoot/#btn_Stop")
	slot0._btnResume = gohelper.findChildButtonWithAudio(slot0.viewGO, "UI/#go_FightRoot/#btn_Resume")
	slot0._btnSkip = gohelper.findChildButtonWithAudio(slot0.viewGO, "UI/#go_FightRoot/#btn_Skip")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnStop:AddClickListener(slot0._btnStopOnClick, slot0)
	slot0._btnResume:AddClickListener(slot0._btnResumeOnClick, slot0)
	slot0._btnSkip:AddClickListener(slot0._btnSkipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnStop:RemoveClickListener()
	slot0._btnResume:RemoveClickListener()
	slot0._btnSkip:RemoveClickListener()
end

function slot0._btnResumeOnClick(slot0)
	gohelper.setActive(slot0._btnStop, true)
	gohelper.setActive(slot0._btnResume, false)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.StopFight, false)
end

function slot0._btnStopOnClick(slot0)
	gohelper.setActive(slot0._btnStop, false)
	gohelper.setActive(slot0._btnResume, true)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.StopFight, true)
end

function slot0._btnSkipOnClick(slot0)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.SkipFight)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.StartFight, slot0.onStartFight, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.NextRound, slot0.onNextRound, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.onStartFight(slot0)
	gohelper.setActive(slot0._gotopleft, false)
	gohelper.setActive(slot0._gotouch, false)
	gohelper.setActive(slot0._goFightRoot, true)
	ViewMgr.instance:openView(ViewName.AutoChessStartFightView)
end

function slot0.onNextRound(slot0)
	gohelper.setActive(slot0._gotopleft, true)
	gohelper.setActive(slot0._gotouch, true)
	gohelper.setActive(slot0._goFightRoot, false)
end

return slot0
