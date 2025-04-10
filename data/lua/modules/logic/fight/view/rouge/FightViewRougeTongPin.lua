module("modules.logic.fight.view.rouge.FightViewRougeTongPin", package.seeall)

slot0 = class("FightViewRougeTongPin", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._polarizationRoot = slot0.viewGO
	slot0._polarizationItem = gohelper.findChild(slot0.viewGO, "item")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PolarizationLevel, slot0._onPolarizationLevel, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, slot0._onClothSkillRoundSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.tongPingGoList = slot0:getUserDataTb_()

	table.insert(slot0.tongPingGoList, slot0._polarizationItem)
end

function slot0.onRefreshViewParam(slot0)
end

function slot0.hideTongPinObj(slot0)
	gohelper.setActive(slot0._polarizationRoot, false)
	FightController.instance:dispatchEvent(FightEvent.RightElements_HideElement, FightRightElementEnum.Elements.RougeTongPin)
end

function slot0.showTongPinObj(slot0, slot1)
	gohelper.setActive(slot0._polarizationRoot, true)
	FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, FightRightElementEnum.Elements.RougeTongPin, slot1 and FightRightElementEnum.ElementsSizeDict[FightRightElementEnum.Elements.RougeTongPin].y * slot1 or nil)
end

function slot0._onClothSkillRoundSequenceFinish(slot0)
	slot0:hideTongPinObj()
end

function slot0._onRoundSequenceFinish(slot0)
	slot0:hideTongPinObj()
end

function slot0._onPolarizationLevel(slot0)
	slot0:_refreshTongPin()
end

function slot0.onOpen(slot0)
	slot0:hideTongPinObj()
end

slot0.tempDataList = {}

function slot0._refreshTongPin(slot0)
	slot0._polarizationDic = FightRoundSequence.roundTempData.PolarizationLevel

	if slot0._polarizationDic then
		for slot4, slot5 in pairs(slot0._polarizationDic) do
			if slot5.effectNum == 0 then
				slot0._polarizationDic[slot4] = nil
			end
		end
	end

	if slot0._polarizationDic and tabletool.len(slot0._polarizationDic) > 0 then
		tabletool.clear(uv0.tempDataList)

		for slot6, slot7 in pairs(slot0._polarizationDic) do
			table.insert(slot2, slot7)
		end

		table.sort(slot2, slot0.sortPolarization)
		slot0:com_createObjList(slot0._onPolarizationItemShow, slot2, slot0._polarizationRoot, slot0._polarizationItem)
		slot0:showTongPinObj(#slot2)
	else
		slot0:hideTongPinObj()
	end
end

function slot0.sortPolarization(slot0, slot1)
	return slot0.configEffect < slot1.configEffect
end

slot0.TempParam = {}

function slot0._onPolarizationItemShow(slot0, slot1, slot2, slot3)
	if not (lua_polarization.configDict[slot2.effectNum] and lua_polarization.configDict[slot2.effectNum][slot2.configEffect]) then
		gohelper.setActive(slot1, false)

		return
	end

	gohelper.findChildText(slot1, "bg/#txt_name").text = slot4 and slot4.name
	gohelper.findChildText(slot1, "bg/#txt_level").text = "Lv." .. slot2.effectNum
	slot8 = gohelper.getClickWithDefaultAudio(gohelper.findChild(slot1, "bg"))

	slot0:removeClickCb(slot8)

	slot9 = uv0.TempParam
	slot9.config = slot4
	slot9.position = slot1.transform.position

	slot0:addClickCb(slot8, slot0._onBtnPolarization, slot0, slot9)

	for slot13 = 1, 3 do
		gohelper.setActive(gohelper.findChild(slot1, "effect_lv/effect_lv" .. slot13), slot13 == slot7)
	end

	if slot7 > 3 then
		gohelper.setActive(gohelper.findChild(slot1, "effect_lv/effect_lv3"), true)
	end
end

function slot0._onBtnPolarization(slot0, slot1)
	FightController.instance:dispatchEvent(FightEvent.RougeShowTip, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
