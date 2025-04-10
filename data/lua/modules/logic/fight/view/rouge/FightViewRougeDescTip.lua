module("modules.logic.fight.view.rouge.FightViewRougeDescTip", package.seeall)

slot0 = class("FightViewRougeDescTip", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._desTips = slot0.viewGO
	slot0._clickTips = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._tipsContentObj = gohelper.findChild(slot0.viewGO, "Content")
	slot0._tipsContentTransform = slot0._tipsContentObj and slot0._tipsContentObj.transform
	slot0._tipsNameText = gohelper.findChildText(slot0.viewGO, "Content/#txt_title")
	slot0._tipsDescText = gohelper.findChildText(slot0.viewGO, "Content/#txt_details")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0._clickTips, slot0._onBtnTips, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, slot0._onClothSkillRoundSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RougeShowTip, slot0.onRougeShowTip, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onRougeShowTip(slot0, slot1)
	slot0:_showTips(slot1)
end

function slot0._editableInitView(slot0)
end

function slot0.onRefreshViewParam(slot0)
end

function slot0.hideTipObj(slot0)
	gohelper.setActive(slot0._desTips, false)
end

function slot0.showTipObj(slot0)
	gohelper.setActive(slot0._desTips, true)
end

function slot0._onBtnTips(slot0)
	slot0:hideTipObj()
end

function slot0._onClothSkillRoundSequenceFinish(slot0)
	slot0:hideTipObj()
end

function slot0._onRoundSequenceFinish(slot0)
	slot0:hideTipObj()
end

function slot0.onOpen(slot0)
	slot0:hideTipObj()
end

function slot0._showTips(slot0, slot1)
	if slot1 and slot1.config then
		gohelper.setActive(slot0._desTips, true)

		slot0._tipsNameText.text = slot2.name
		slot0._tipsDescText.text = HeroSkillModel.instance:skillDesToSpot(slot2.desc)

		if slot0._tipsContentTransform then
			slot3, slot4 = recthelper.rectToRelativeAnchorPos2(slot1.position, slot0.viewGO.transform)

			recthelper.setAnchorY(slot0._tipsContentTransform, slot4)
		end
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
