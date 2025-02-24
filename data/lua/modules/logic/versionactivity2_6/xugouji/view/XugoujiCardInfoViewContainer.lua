module("modules.logic.versionactivity2_6.xugouji.view.XugoujiCardInfoViewContainer", package.seeall)

slot0 = class("XugoujiCardInfoViewContainer", BaseViewContainer)
slot1 = 0.35

function slot0.buildViews(slot0)
	return {
		XugoujiCardInfoView.New()
	}
end

function slot0._overrideCloseAction(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, slot0._playAniAndClose, nil, , slot0)
end

function slot0._overrideClickHome(slot0)
	NavigateButtonsView.homeClick()
end

function slot0._playAniAndClose(slot0)
	if not slot0._anim then
		slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	end

	slot0._anim:Play("out", 0, 0)
	TaskDispatcher.runDelay(slot0.closeThis, slot0, uv0)
end

function slot0.setVisibleInternal(slot0, slot1)
	uv0.super.setVisibleInternal(slot0, slot1)
end

return slot0
