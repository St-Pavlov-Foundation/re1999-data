module("modules.logic.versionactivity2_7.towergift.view.DestinyStoneGiftPickChoiceListItem", package.seeall)

slot0 = class("DestinyStoneGiftPickChoiceListItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gorole = gohelper.findChild(slot0.viewGO, "role")
	slot0._godestiny = gohelper.findChild(slot0.viewGO, "#go_destiny")
	slot0._golocked = gohelper.findChild(slot0.viewGO, "#go_destiny/locked")
	slot0._simagelockStone = gohelper.findChildSingleImage(slot0.viewGO, "#go_destiny/locked/#image_stone")
	slot0._gounlocked = gohelper.findChild(slot0.viewGO, "#go_destiny/unlock")
	slot0._simageunlockStone = gohelper.findChildSingleImage(slot0.viewGO, "#go_destiny/unlock/#image_stone")
	slot0._txtlevel = gohelper.findChildText(slot0.viewGO, "#go_destiny/unlock/#txt_level")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "select")
	slot0._btnclick = gohelper.findChildButton(slot0.viewGO, "go_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0:addEventCb(DestinyStoneGiftPickChoiceController.instance, DestinyStoneGiftPickChoiceEvent.onCustomPickListChanged, slot0.updateSelect, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0:addEventCb(DestinyStoneGiftPickChoiceController.instance, DestinyStoneGiftPickChoiceEvent.onCustomPickListChanged, slot0.updateSelect, slot0)
end

function slot0._btnclickOnClick(slot0)
	DestinyStoneGiftPickChoiceListModel.instance:setCurrentSelectMo(slot0._mo)
end

function slot0.updateSelect(slot0)
	gohelper.setActive(slot0._goselect, DestinyStoneGiftPickChoiceListModel.instance:isSelectedMo(slot0._mo.stoneId))
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refreshUI()
	slot0:updateSelect()
end

function slot0.refreshUI(slot0)
	if not slot0._mo then
		return
	end

	slot0:_refreshHeroItem()
	slot0:_refreshStone()
end

function slot0._refreshHeroItem(slot0)
	if not slot0.herocomponent then
		slot0.herocomponent = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gorole, DestinyStoneGiftPickChoiceListHeroItem)

		slot0.herocomponent:init(slot0._gorole)
	end

	slot1 = SummonCustomPickChoiceMO.New()

	slot1:init(tonumber(slot0._mo.heroId))
	slot0.herocomponent:onUpdateMO(slot1)
end

function slot0._refreshStone(slot0)
	slot1 = slot0._mo.isUnLock

	gohelper.setActive(slot0._golocked, not slot1)
	gohelper.setActive(slot0._gounlocked, slot1)

	if slot1 then
		slot0._txtlevel.text = GameUtil.getRomanNums(slot0._mo.stonelevel)
	else
		slot0._txtlevel.text = ""
	end

	slot2, slot3 = slot0._mo.stoneMo:getNameAndIcon()

	slot0._simagelockStone:LoadImage(slot3)
	slot0._simageunlockStone:LoadImage(slot3)
end

return slot0
