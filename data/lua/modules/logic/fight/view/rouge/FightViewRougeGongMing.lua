module("modules.logic.fight.view.rouge.FightViewRougeGongMing", package.seeall)

slot0 = class("FightViewRougeGongMing", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._resonancelObj = slot0.viewGO
	slot0._resonancelNameText = gohelper.findChildText(slot0.viewGO, "bg/#txt_name")
	slot0._resonancelLevelText = gohelper.findChildText(slot0.viewGO, "bg/#txt_level")
	slot0._clickResonancel = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "bg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0._clickResonancel, slot0._onBtnResonancel, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ResonanceLevel, slot0._onResonanceLevel, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, slot0._onClothSkillRoundSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onRefreshViewParam(slot0)
end

function slot0.hideResonanceObj(slot0)
	gohelper.setActive(slot0._resonancelObj, false)
	FightController.instance:dispatchEvent(FightEvent.RightElements_HideElement, FightRightElementEnum.Elements.RougeGongMing)
end

function slot0.showResonanceObj(slot0)
	gohelper.setActive(slot0._resonancelObj, true)
	FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, FightRightElementEnum.Elements.RougeGongMing)
end

function slot0._onClothSkillRoundSequenceFinish(slot0)
	slot0:hideResonanceObj()
end

function slot0._onRoundSequenceFinish(slot0)
	slot0:hideResonanceObj()
end

function slot0._onResonanceLevel(slot0)
	slot0:_refreshData()
end

function slot0._onPolarizationLevel(slot0)
	slot0:_refreshData()
end

function slot0.onOpen(slot0)
	slot0:hideResonanceObj()
end

function slot0._refreshData(slot0)
	gohelper.setActive(slot0.viewGO, true)
	slot0:_refreshGongMing()
end

slot0.TempParam = {}

function slot0._onBtnResonancel(slot0)
	slot1 = uv0.TempParam
	slot1.config = slot0._resonancelConfig
	slot1.position = slot0._resonancelObj.transform.position

	FightController.instance:dispatchEvent(FightEvent.RougeShowTip, slot1)
end

function slot0._refreshGongMing(slot0)
	slot0._resonancelLevel = FightRoundSequence.roundTempData.ResonanceLevel

	if slot0._resonancelLevel and slot0._resonancelLevel ~= 0 then
		if lua_resonance.configDict[slot0._resonancelLevel] then
			slot0:showResonanceObj()

			slot0._resonancelConfig = slot2
			slot0._resonancelNameText.text = slot2 and slot2.name
			slot0._resonancelLevelText.text = "Lv." .. slot0._resonancelLevel

			for slot6 = 1, 3 do
				gohelper.setActive(gohelper.findChild(slot0.viewGO, "effect_lv/effect_lv" .. slot6), slot6 == slot0._resonancelLevel)
			end

			if slot0._resonancelLevel > 3 then
				gohelper.setActive(gohelper.findChild(slot0.viewGO, "effect_lv/effect_lv3"), true)
			end
		else
			slot0:hideResonanceObj()
		end
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
