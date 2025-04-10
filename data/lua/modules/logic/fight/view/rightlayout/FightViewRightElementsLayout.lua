module("modules.logic.fight.view.rightlayout.FightViewRightElementsLayout", package.seeall)

slot0 = class("FightViewRightElementsLayout", BaseView)

function slot0.onInitView(slot0)
	slot0.goRightRoot = gohelper.findChild(slot0.viewGO, "root/right_elements/top")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RightElements_ShowElement, slot0.showElement, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RightElements_HideElement, slot0.hideElement, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.showElementDict = {}
	slot0.preShowElementDict = {}
	slot0.tempElementHeightDict = {}
	slot0.tweenIdList = {}
	slot0.elementGoDict = slot0:getUserDataTb_()
	slot0.elementRectTrDict = slot0:getUserDataTb_()

	for slot4, slot5 in pairs(FightRightElementEnum.Elements) do
		slot6 = gohelper.findChild(slot0.goRightRoot, FightRightElementEnum.ElementsNodeName[slot5])
		slot0.elementGoDict[slot5] = slot6
		slot0.elementRectTrDict[slot5] = slot6:GetComponent(gohelper.Type_RectTransform)

		gohelper.setAsLastSibling(slot6)
		gohelper.setActive(slot6, false)

		slot7 = FightRightElementEnum.ElementsSizeDict[slot5]

		recthelper.setSize(slot0.elementRectTrDict[slot5], slot7.x, slot7.y)
	end

	slot0.maxHeight = recthelper.getHeight(slot0.goRightRoot:GetComponent(gohelper.Type_RectTransform))
end

function slot0.getElementContainer(slot0, slot1)
	return slot0.elementGoDict[slot1]
end

function slot0.showElement(slot0, slot1, slot2)
	slot0.showElementDict[slot1] = true
	slot0.tempElementHeightDict[slot1] = slot2

	slot0:refreshLayout()
end

function slot0.hideElement(slot0, slot1)
	slot0.showElementDict[slot1] = nil
	slot0.tempElementHeightDict[slot1] = nil

	slot0:refreshLayout()
end

function slot0.refreshLayout(slot0)
	slot0:clearTweenId()

	slot1 = 0
	slot2 = 0
	slot4 = 0

	for slot8, slot9 in ipairs(FightRightElementEnum.Priority) do
		if slot0.showElementDict[slot9] then
			gohelper.setActive(slot0.elementGoDict[slot9], true)

			slot11 = slot0:getElementWidth(slot9)

			if slot4 < 1 or slot2 + slot0:getElementHeight(slot9) <= slot0.maxHeight then
				if 0 < slot11 then
					slot3 = slot11
				end
			else
				slot1 = slot1 + slot3
				slot2 = 0
				slot4 = 0
			end

			recthelper.setSize(slot0.elementRectTrDict[slot9], slot11, slot12)

			if slot0.preShowElementDict[slot9] then
				table.insert(slot0.tweenIdList, ZProj.TweenHelper.DOAnchorPos(slot0.elementRectTrDict[slot9], -slot1, -slot2, FightRightElementEnum.AnchorTweenDuration))
			else
				recthelper.setAnchor(slot0.elementRectTrDict[slot9], -slot1, -slot2)
			end

			slot4 = slot4 + 1
			slot2 = slot2 + slot12

			gohelper.setAsLastSibling(slot0.elementGoDict[slot9])
		else
			gohelper.setActive(slot0.elementGoDict[slot9], false)
		end

		slot0.preShowElementDict[slot9] = slot10
	end
end

function slot0.getElementHeight(slot0, slot1)
	if slot0.tempElementHeightDict[slot1] then
		return slot0.tempElementHeightDict[slot1]
	end

	return FightRightElementEnum.ElementsSizeDict[slot1].y
end

function slot0.getElementWidth(slot0, slot1)
	return FightRightElementEnum.ElementsSizeDict[slot1].x
end

function slot0.clearTweenId(slot0)
	for slot4, slot5 in ipairs(slot0.tweenIdList) do
		ZProj.TweenHelper.KillById(slot5)
	end

	tabletool.clear(slot0.tweenIdList)
end

function slot0.onDestroyView(slot0)
	slot0:clearTweenId()
end

return slot0
