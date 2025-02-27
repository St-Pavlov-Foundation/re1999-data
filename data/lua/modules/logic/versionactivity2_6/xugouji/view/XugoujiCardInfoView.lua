module("modules.logic.versionactivity2_6.xugouji.view.XugoujiCardInfoView", package.seeall)

slot0 = class("XugoujiCardInfoView", BaseView)
slot1 = Vector2(-530, -60)
slot2 = Vector2(530, -60)
slot3 = VersionActivity2_6Enum.ActivityId.Xugouji

function slot0.onInitView(slot0)
	slot0._goInfo = gohelper.findChild(slot0.viewGO, "#go_Tips")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._txtDesc = gohelper.findChildText(slot0._goInfo, "Scroll View/Viewport/#txt_Descr")
	slot0._txtName = gohelper.findChildText(slot0._goInfo, "Info/#txt_ChessName")
	slot0._cardIcon = gohelper.findChildImage(slot0._goInfo, "Info/#image_Skill")
	slot0._viewAnimator = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)

	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.ManualExitGame, slot0.closeThis, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.OnOpenGameResultView, slot0.closeThis, slot0)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0._onCloseClick, slot0)
	slot0:addEventCb(XugoujiController.instance, XugoujiEvent.GuideCloseCardInfoView, slot0._closeByGuide, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0:removeEventCb(XugoujiController.instance, XugoujiEvent.GuideCloseCardInfoView, slot0._closeByGuide, slot0)
end

function slot0.closeThis(slot0)
	BaseView.closeThis(slot0)
end

function slot0._onCloseClick(slot0)
	TaskDispatcher.cancelTask(slot0._onCloseClick, slot0)
	gohelper.setActive(slot0._btnClose.gameObject, false)
	slot0._viewAnimator:Play(UIAnimationName.Close, slot0.closeThis, slot0)
end

function slot0._closeByGuide(slot0)
	TaskDispatcher.cancelTask(slot0._onCloseClick, slot0)
	gohelper.setActive(slot0._btnClose.gameObject, false)
	slot0._viewAnimator:Play(UIAnimationName.Close, slot0.closeThis, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	slot5 = Activity188Model.instance:isMyTurn() and uv0 or uv1
	slot6 = Activity188Config.instance:getCardCfg(uv2, slot0.viewParam.cardId)

	recthelper.setAnchor(slot0._goInfo.transform, slot5.x, slot5.y)

	slot0._txtDesc.text = slot6.desc
	slot0._txtName.text = slot6.name

	if slot6.resource and slot7 ~= "" then
		UISpriteSetMgr.instance:setXugoujiSprite(slot0._cardIcon, slot7)
	end

	if not slot3 then
		TaskDispatcher.runDelay(slot0._onCloseClick, slot0, 2)
	end

	gohelper.setActive(slot0._btnClose.gameObject, true)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._onCloseClick, slot0)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.CloseCardInfoView)
end

function slot0.onDestroyView(slot0)
end

return slot0
