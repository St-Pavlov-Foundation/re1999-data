module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogSystemMessageItem", package.seeall)

slot0 = class("AergusiDialogSystemMessageItem", AergusiDialogItem)

function slot0.initView(slot0)
	slot0._txtSystemMessage = gohelper.findChildText(slot0.go, "#txt_systemmessage")
	slot0._goline = gohelper.findChild(slot0.go, "line")
	slot0._txtSystemMessageGrey = gohelper.findChildText(slot0.go, "#txt_systemmessage_grey")
	slot0._golinegrey = gohelper.findChild(slot0.go, "line_grey")
	slot0.go.name = string.format("systemmessageitem_%s_%s", slot0.stepCo.id, slot0.stepCo.stepId)
end

function slot0.refresh(slot0)
	gohelper.setActive(slot0._txtSystemMessage.gameObject, AergusiDialogModel.instance:getCurDialogGroup() == slot0.stepCo.id)
	gohelper.setActive(slot0._txtSystemMessageGrey.gameObject, slot1 ~= slot0.stepCo.id)
	gohelper.setActive(slot0._goline, slot1 == slot0.stepCo.id)
	gohelper.setActive(slot0._golinegrey, slot1 ~= slot0.stepCo.id)

	if slot1 == slot0.stepCo.id then
		slot0._txtSystemMessage.text = slot0.stepCo.content
	else
		slot0._txtSystemMessageGrey.text = slot0.stepCo.content
	end
end

function slot0.calculateHeight(slot0)
	slot0.height = AergusiEnum.MinHeight[slot0.type]
end

function slot0.onDestroy(slot0)
end

return slot0
