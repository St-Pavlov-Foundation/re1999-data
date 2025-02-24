module("modules.logic.versionactivity2_6.xugouji.view.XugoujiCardInfoView", package.seeall)

slot0 = class("XugoujiCardInfoView", BaseView)
slot1 = Vector2(-430, -60)
slot2 = Vector2(430, -60)
slot3 = VersionActivity2_6Enum.ActivityId.Xugouji

function slot0.onInitView(slot0)
	slot0._goInfo = gohelper.findChild(slot0.viewGO, "#go_Tips")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._txtDesc = gohelper.findChildText(slot0._goInfo, "Scroll View/Viewport/#txt_Descr")
	slot0._txtName = gohelper.findChildText(slot0._goInfo, "Info/#txt_ChessName")
	slot0._cardIcon = gohelper.findChildSingleImage(slot0._goInfo, "Info/#image_Skill")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0._onCloseClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
end

function slot0._onCloseClick(slot0)
	if Activity188Model.instance:isMyTurn() then
		slot0:closeThis()
	end
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
		slot0._cardIcon:LoadImage(slot7)
	end

	if not slot3 then
		TaskDispatcher.runDelay(slot0.closeThis, slot0, 2)
	end
end

function slot0.onClose(slot0)
	slot0._cardIcon:UnLoadImage()
	XugoujiController.instance:dispatchEvent(XugoujiEvent.CloseCardInfoView)
end

function slot0.onDestroyView(slot0)
end

return slot0
