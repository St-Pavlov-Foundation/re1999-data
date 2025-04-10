module("modules.logic.fight.view.magiccircle.FightShuZhenView", package.seeall)

slot0 = class("FightShuZhenView", BaseView)

function slot0.onInitView(slot0)
	slot0._topLeftRoot = gohelper.findChild(slot0.viewGO, "root/topLeftContent")
	slot0._obj = gohelper.findChild(slot0.viewGO, "root/topLeftContent/#go_shuzhentips")
	slot0._detail = gohelper.findChild(slot0.viewGO, "root/#go_shuzhendetails")
	gohelper.onceAddComponent(slot0._detail, typeof(UnityEngine.Animator)).enabled = true
	slot0._detailHeightObj = gohelper.findChild(slot0.viewGO, "root/#go_shuzhendetails/details")
	slot0._detailTitle = gohelper.findChildText(slot0.viewGO, "root/#go_shuzhendetails/details/#scroll_details/Viewport/Content/#txt_title")
	slot0._detailRound = gohelper.findChildText(slot0.viewGO, "root/#go_shuzhendetails/details/#scroll_details/Viewport/Content/#txt_title/#txt_round")
	slot0._detailText = gohelper.findChildText(slot0.viewGO, "root/#go_shuzhendetails/details/#scroll_details/Viewport/Content/#txt_details")
	slot0._detailClick = gohelper.getClickWithDefaultAudio(gohelper.findChild(slot0._detail, "#btn_shuzhendetailclick"))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._detailClick:AddClickListener(slot0._onDetailClick, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.AddMagicCircile, slot0._onAddMagicCircile, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.DeleteMagicCircile, slot0._onDeleteMagicCircile, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.UpdateMagicCircile, slot0._onUpdateMagicCircile, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnClickMagicCircleText, slot0.OnClickMagicCircleText, slot0)
end

function slot0.removeEvents(slot0)
	slot0._detailClick:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0:hideObj()
	gohelper.setActive(slot0._detail, false)
	SkillHelper.addHyperLinkClick(slot0._detailText, slot0.onClickShuZhenHyperDesc, slot0)

	slot0.detailRectTr = slot0._detail:GetComponent(gohelper.Type_RectTransform)
	slot0.viewGoRectTr = slot0.viewGO:GetComponent(gohelper.Type_RectTransform)
	slot4 = gohelper.Type_RectTransform
	slot0.scrollRectTr = gohelper.findChildComponent(slot0.viewGO, "root/#go_shuzhendetails/details/#scroll_details", slot4)
	slot0.topLeftRootTr = slot0._topLeftRoot.transform
	slot0.detailTr = slot0._detail.transform

	for slot4, slot5 in pairs(FightEnum.MagicCircleUIType2Name) do
		gohelper.setActive(gohelper.findChild(slot0._obj, "layout/" .. slot5), false)
	end
end

slot0.TipIntervalX = 10

function slot0.onClickShuZhenHyperDesc(slot0, slot1, slot2)
	slot0.commonBuffTipAnchorPos = slot0.commonBuffTipAnchorPos or Vector2()

	slot0.commonBuffTipAnchorPos:Set(-(recthelper.getWidth(slot0.viewGoRectTr) / 2 - recthelper.getAnchorX(slot0.detailRectTr) - recthelper.getWidth(slot0.scrollRectTr) - uv0.TipIntervalX), 312.24)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(slot1, slot0.commonBuffTipAnchorPos, CommonBuffTipEnum.Pivot.Left)
end

function slot0.OnClickMagicCircleText(slot0, slot1, slot2)
	recthelper.setAnchorY(slot0.detailTr, recthelper.rectToRelativeAnchorPos(slot2, slot0.topLeftRootTr).y - slot1 + recthelper.getAnchorY(slot0.topLeftRootTr))
	gohelper.setActive(slot0._detail, true)

	slot6 = FightModel.instance:getMagicCircleInfo() and slot5.magicCircleId and lua_magic_circle.configDict[slot5.magicCircleId]

	if slot5 and slot6 then
		slot0._detailTitle.text = slot6.name
		slot0._detailRound.text = formatLuaLang("x_round", slot5.round == -1 and "∞" or slot5.round)
		slot0._detailText.text = SkillHelper.buildDesc(slot6.desc)
	end
end

function slot0._onDetailClick(slot0)
	gohelper.setActive(slot0._detail, false)
end

function slot0.addMagic(slot0)
	slot0:clearFlow()

	slot0.flow = FlowSequence.New()
	slot0.magicItem = nil

	slot0.flow:addWork(FightMagicCircleRemoveWork.New(slot0.magicItem))
	slot0.flow:addWork(FunctionWork.New(slot0.createMagicItem, slot0))
	slot0.flow:start()
end

function slot0.removeMagic(slot0)
	slot0:clearFlow()

	slot0.flow = FlowSequence.New()
	slot0.magicItem = nil

	slot0.flow:addWork(FightMagicCircleRemoveWork.New(slot0.magicItem))
	slot0.flow:registerDoneListener(slot0.hideObj, slot0)
	slot0.flow:start()
end

slot0.UiType2Class = {
	[FightEnum.MagicCircleUIType.Normal] = FightMagicCircleNormal,
	[FightEnum.MagicCircleUIType.Electric] = FightMagicCircleElectric
}

function slot0.createMagicItem(slot0)
	if not FightModel.instance:getMagicCircleInfo() then
		return
	end

	if not slot1.magicCircleId then
		return
	end

	if not lua_magic_circle.configDict[slot1.magicCircleId] then
		return
	end

	slot0:showObj()

	slot0.magicItem = (slot0.UiType2Class[slot2.uiType] or FightMagicCircleNormal).New()

	slot0.magicItem:init(gohelper.findChild(slot0._obj, "layout/" .. FightEnum.MagicCircleUIType2Name[slot3]))
	slot0.magicItem:onCreateMagic(slot1, slot2)
end

function slot0.onOpen(slot0)
	slot0:addMagic()
end

function slot0._onAddMagicCircile(slot0)
	slot0:addMagic()
end

function slot0._onDeleteMagicCircile(slot0)
	slot0:removeMagic()
end

function slot0._onUpdateMagicCircile(slot0)
	if not FightModel.instance:getMagicCircleInfo() then
		return slot0:removeMagic()
	end

	if not slot1.magicCircleId then
		return slot0:removeMagic()
	end

	if not lua_magic_circle.configDict[slot1.magicCircleId] then
		return slot0:removeMagic()
	end

	if slot2.uiType == (slot0.magicItem and slot0.magicItem:getUIType()) then
		slot0.magicItem:onUpdateMagic(slot1, slot2)
	else
		slot0:addMagic()
	end
end

function slot0.hideObj(slot0)
	gohelper.setActive(slot0._obj, false)
end

function slot0.showObj(slot0)
	gohelper.setActive(slot0._obj, true)
end

function slot0.clearFlow(slot0)
	if slot0.flow then
		slot0.flow:stop()
		slot0.flow:destroy()

		slot0.flow = nil
	end
end

function slot0.onClose(slot0)
	slot0:clearFlow()

	if slot0.magicItem then
		slot0.magicItem:destroy()

		slot0.magicItem = nil
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
