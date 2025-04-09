module("modules.logic.fight.view.rightlayout.FightViewRightBottomElementsLayout", package.seeall)

slot0 = class("FightViewRightBottomElementsLayout", BaseView)

function slot0.onInitView(slot0)
	slot0.goRightBottomRoot = gohelper.findChild(slot0.viewGO, "root/right_elements/bottom")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RightBottomElements_ShowElement, slot0.showElement, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RightBottomElements_HideElement, slot0.hideElement, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.showElementDict = {}
	slot0.elementGoDict = slot0:getUserDataTb_()

	for slot4, slot5 in pairs(FightRightBottomElementEnum.Elements) do
		slot6 = gohelper.findChild(slot0.goRightBottomRoot, FightRightBottomElementEnum.ElementsNodeName[slot5])
		slot0.elementGoDict[slot5] = slot6

		gohelper.setAsLastSibling(slot6)
		gohelper.setActive(slot6, false)

		slot8 = FightRightBottomElementEnum.ElementsSizeDict[slot5]

		recthelper.setSize(slot6:GetComponent(gohelper.Type_RectTransform), slot8.x, slot8.y)
	end
end

function slot0.getElementContainer(slot0, slot1)
	return slot0.elementGoDict[slot1]
end

function slot0.showElement(slot0, slot1)
	slot0.showElementDict[slot1] = true

	slot0:refreshLayout()
end

function slot0.hideElement(slot0, slot1)
	slot0.showElementDict[slot1] = nil

	slot0:refreshLayout()
end

function slot0.refreshLayout(slot0)
	for slot4, slot5 in ipairs(FightRightBottomElementEnum.Priority) do
		slot6 = slot0.showElementDict[slot5]

		gohelper.setActive(slot0.elementGoDict[slot5], slot6)

		if slot6 then
			gohelper.setAsFirstSibling(slot0.elementGoDict[slot5])
		end
	end
end

return slot0
