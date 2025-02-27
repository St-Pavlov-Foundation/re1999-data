module("modules.logic.weekwalk_2.view.WeekWalk_2HeartBuffView", package.seeall)

slot0 = class("WeekWalk_2HeartBuffView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnMask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Mask")
	slot0._simageTipsBG = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_TipsBG")
	slot0._txtBuffName = gohelper.findChildText(slot0.viewGO, "Root/Right/#txt_BuffName")
	slot0._imageBuffIcon = gohelper.findChildImage(slot0.viewGO, "Root/Right/#image_BuffIcon")
	slot0._txtEffectDesc = gohelper.findChildText(slot0.viewGO, "Root/Right/Scroll View/Viewport/#txt_EffectDesc")
	slot0._btnEquip = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/Right/#btn_Equip")
	slot0._btnUnLoad = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/Right/#btn_UnLoad")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnMask:AddClickListener(slot0._btnMaskOnClick, slot0)
	slot0._btnEquip:AddClickListener(slot0._btnEquipOnClick, slot0)
	slot0._btnUnLoad:AddClickListener(slot0._btnUnLoadOnClick, slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnMask:RemoveClickListener()
	slot0._btnEquip:RemoveClickListener()
	slot0._btnUnLoad:RemoveClickListener()
	slot0._btnClose:RemoveClickListener()
end

function slot0._btnUnLoadOnClick(slot0)
	slot0._selectedSkillId = nil

	slot0:_updateBuffStatus()
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnBuffSetup)

	if HeroGroupModel.instance.curGroupSelectIndex then
		Weekwalk_2Rpc.instance:sendWeekwalkVer2ChooseSkillRequest(HeroGroupModel.instance.curGroupSelectIndex)
	end
end

function slot0._btnMaskOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnEquipOnClick(slot0)
	if slot0._isPrevBattleSkill then
		GameFacade.showToast(ToastEnum.WeekWalk_2BuffCannotSetup)

		return
	end

	slot0._selectedSkillId = slot0._buffConfig.id

	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnBuffSetup, slot0._buffConfig)

	if HeroGroupModel.instance.curGroupSelectIndex then
		Weekwalk_2Rpc.instance:sendWeekwalkVer2ChooseSkillRequest(HeroGroupModel.instance.curGroupSelectIndex, {
			slot0._selectedSkillId
		}, slot0._onBuffSetupReply, slot0)
	end
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._txtBuffName.text = ""
	slot0._txtEffectDesc.text = ""

	gohelper.setActive(slot0._btnEquip, false)
	gohelper.setActive(slot0._btnUnLoad, false)
	gohelper.addUIClickAudio(slot0._btnEquip.gameObject, AudioEnum2_6.WeekWalk_2.play_ui_fight_artificial_equip)
	gohelper.addUIClickAudio(slot0._btnUnLoad.gameObject, AudioEnum2_6.WeekWalk_2.play_ui_fight_artificial_unequip)
end

function slot0._onBuffSelectedChange(slot0, slot1)
	slot0._buffConfig = slot1

	slot0:_updateBuffStatus()
end

function slot0._updateBuffStatus(slot0)
	slot0._txtBuffName.text = slot0._buffConfig.name
	slot0._txtEffectDesc.text = slot0._buffConfig.desc
	slot0._isPrevBattleSkill = WeekWalk_2BuffListModel.instance.prevBattleSkillId == slot0._buffConfig.id
	slot2 = slot0._isBattle and slot0._selectedSkillId ~= slot0._buffConfig.id

	gohelper.setActive(slot0._btnEquip, slot2)
	gohelper.setActive(slot0._btnUnLoad, slot0._isBattle and slot0._selectedSkillId == slot0._buffConfig.id and not slot0._isPrevBattleSkill)

	if slot2 then
		ZProj.UGUIHelper.SetGrayscale(slot0._btnEquip.gameObject, slot0._isPrevBattleSkill)
	end

	UISpriteSetMgr.instance:setWeekWalkSprite(slot0._imageBuffIcon, slot0._buffConfig.icon)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._isBattle = slot0.viewParam and slot0.viewParam.isBattle

	if slot0._isBattle then
		slot0._battleId = HeroGroupModel.instance.battleId
		slot0._layerId = WeekWalk_2Model.instance:getCurMapInfo().id
		slot0._selectedSkillId = WeekWalk_2BuffListModel.getCurHeroGroupSkillId()
	end

	slot0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnBuffSelectedChange, slot0._onBuffSelectedChange, slot0)
end

function slot0._onBuffSetupReply(slot0)
	slot0:closeThis()
	GameFacade.showToast(ToastEnum.WeekWalk_2BuffSetup)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
