module("modules.logic.versionactivity2_7.towergift.view.DestinyStoneGiftPickChoiceView", package.seeall)

slot0 = class("DestinyStoneGiftPickChoiceView", BaseView)

function slot0.onInitView(slot0)
	slot0._goconfirm = gohelper.findChild(slot0.viewGO, "#btn_confirm")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_confirm")
	slot0._goconfirmgrey = gohelper.findChild(slot0.viewGO, "#btn_confirm_grey")
	slot0._btnconfirmgrey = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_confirm_grey")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_cancel")
	slot0._scrollstone = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_stone")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
	slot0._btnconfirmgrey:AddClickListener(slot0._btnconfirmgreyOnClick, slot0)
	slot0:addEventCb(DestinyStoneGiftPickChoiceController.instance, DestinyStoneGiftPickChoiceEvent.onCustomPickListChanged, slot0.refreshUI, slot0)
	slot0:addEventCb(DestinyStoneGiftPickChoiceController.instance, DestinyStoneGiftPickChoiceEvent.hadStoneUp, slot0.onStoneUpFinish, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnconfirm:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
	slot0._btnconfirmgrey:RemoveClickListener()
	slot0:removeEventCb(DestinyStoneGiftPickChoiceController.instance, DestinyStoneGiftPickChoiceEvent.onCustomPickListChanged, slot0.refreshUI, slot0)
	slot0:removeEventCb(DestinyStoneGiftPickChoiceController.instance, DestinyStoneGiftPickChoiceEvent.hadStoneUp, slot0.onStoneUpFinish, slot0)
end

function slot0._btnconfirmOnClick(slot0)
	if DestinyStoneGiftPickChoiceListModel.instance:getCurrentSelectMo() then
		slot1.heroMo.destinyStoneMo:setUpStoneId(slot1.stoneId)
		ViewMgr.instance:openView(ViewName.CharacterDestinyStoneUpView, {
			heroMo = slot1.heroMo,
			stoneMo = slot1.stoneMo
		})
	end
end

function slot0._btncancelOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnconfirmgreyOnClick(slot0)
	GameFacade.showToast(ToastEnum.NoChoiceHeroStoneUp)
end

function slot0.onStoneUpFinish(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	DestinyStoneGiftPickChoiceListModel.instance:initList()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot1 = DestinyStoneGiftPickChoiceListModel.instance:getCurrentSelectMo() ~= nil

	gohelper.setActive(slot0._goconfirm, slot1)
	gohelper.setActive(slot0._goconfirmgrey, not slot1)
end

function slot0.onClose(slot0)
	DestinyStoneGiftPickChoiceListModel.instance:clearSelect()
end

function slot0.onDestroyView(slot0)
end

return slot0
