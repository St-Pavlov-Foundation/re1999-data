module("modules.logic.weekwalk_2.view.WeekWalk_2HeartBuffItem", package.seeall)

slot0 = class("WeekWalk_2HeartBuffItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goSelect = gohelper.findChild(slot0.viewGO, "#go_Select")
	slot0._imageBuffIcon = gohelper.findChildImage(slot0.viewGO, "#image_BuffIcon")
	slot0._goEquiped = gohelper.findChild(slot0.viewGO, "#go_Equiped")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if slot0._isSelected then
		return
	end

	slot0._view:selectCell(slot0._index, true)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goEquiped, false)
end

function slot0._editableAddEvents(slot0)
	slot0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnBuffSetupReply, slot0._onBuffSetupReply, slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0._onBuffSetupReply(slot0)
	slot0:_checkEquiped()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._config = slot1

	slot0:_checkEquiped()
	UISpriteSetMgr.instance:setWeekWalkSprite(slot0._imageBuffIcon, slot0._config.icon)
	ZProj.UGUIHelper.SetGrayscale(slot0._imageBuffIcon.gameObject, WeekWalk_2BuffListModel.instance.prevBattleSkillId == slot0._config.id)
end

function slot0.onSelect(slot0, slot1)
	slot0._isSelected = slot1

	gohelper.setActive(slot0._goSelect, slot0._isSelected)

	if slot0._isSelected then
		WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnBuffSelectedChange, slot0._config)
	end
end

function slot0._checkEquiped(slot0)
	if not WeekWalk_2BuffListModel.instance.isBattle then
		return
	end

	gohelper.setActive(slot0._goEquiped, WeekWalk_2BuffListModel.getCurHeroGroupSkillId() == slot0._config.id)
end

function slot0.onDestroyView(slot0)
end

return slot0
