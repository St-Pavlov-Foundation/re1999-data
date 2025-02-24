module("modules.logic.weekwalk_2.view.WeekWalk_2HeartBuffView", package.seeall)

slot0 = class("WeekWalk_2HeartBuffView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnMask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Mask")
	slot0._simageTipsBG = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_TipsBG")
	slot0._txtBuffName = gohelper.findChildText(slot0.viewGO, "Root/Right/#txt_BuffName")
	slot0._simageBuffIcon = gohelper.findChildSingleImage(slot0.viewGO, "Root/Right/#simage_BuffIcon")
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

	if slot0._layerId and slot0._battleId then
		Weekwalk_2Rpc.instance:sendWeekwalkVer2ChooseSkillRequest(slot0._layerId, slot0._battleId)
	end
end

function slot0._btnMaskOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnEquipOnClick(slot0)
	slot0._selectedSkillId = slot0._buffConfig.id

	slot0:_updateBuffStatus()
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnBuffSetup, slot0._buffConfig)

	if slot0._layerId and slot0._battleId then
		Weekwalk_2Rpc.instance:sendWeekwalkVer2ChooseSkillRequest(slot0._layerId, slot0._battleId, {
			slot0._selectedSkillId
		})
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
end

function slot0._onBuffSelectedChange(slot0, slot1)
	slot0._buffConfig = slot1

	slot0:_updateBuffStatus()
end

function slot0._updateBuffStatus(slot0)
	slot0._txtBuffName.text = slot0._buffConfig.name
	slot0._txtEffectDesc.text = slot0._buffConfig.desc
	slot2 = WeekWalk_2BuffListModel.instance.prevBattleSkillId == slot0._buffConfig.id

	gohelper.setActive(slot0._btnEquip, slot0._isBattle and slot0._selectedSkillId ~= slot0._buffConfig.id and not slot2)
	gohelper.setActive(slot0._btnUnLoad, slot0._isBattle and slot0._selectedSkillId == slot0._buffConfig.id and not slot2)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._isBattle = slot0.viewParam and slot0.viewParam.isBattle

	if slot0._isBattle then
		slot1 = WeekWalk_2Model.instance:getCurMapInfo()
		slot2 = HeroGroupModel.instance.battleId
		slot0._battleInfo = slot1:getBattleInfoByBattleId(slot2)
		slot0._battleId = slot2
		slot0._layerId = slot1.id
		slot0._selectedSkillId = slot0._battleInfo:getChooseSkillId()
	end

	slot0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnBuffSelectedChange, slot0._onBuffSelectedChange, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
