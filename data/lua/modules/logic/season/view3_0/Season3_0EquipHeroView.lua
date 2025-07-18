﻿module("modules.logic.season.view3_0.Season3_0EquipHeroView", package.seeall)

local var_0_0 = class("Season3_0EquipHeroView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg1")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/right/#btn_equip")
	arg_1_0._btnopenhandbook = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/right/#btn_openhandbook")
	arg_1_0._btnopenhandbook2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_empty/#btn_openhandbook2")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_empty")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._btnequipOnClick, arg_2_0)
	arg_2_0._btnopenhandbook:AddClickListener(arg_2_0._btnhandbookOnClick, arg_2_0)
	arg_2_0._btnopenhandbook2:AddClickListener(arg_2_0._btnhandbookOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnequip:RemoveClickListener()
	arg_3_0._btnopenhandbook:RemoveClickListener()
	arg_3_0._btnopenhandbook2:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg1:LoadImage(ResUrl.getSeasonIcon("full/hechengye_bj.jpg"))

	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._animEventWrap = arg_4_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_4_0._animEventWrap:AddEventListener("switch", arg_4_0.handleSwitchAnimFrame, arg_4_0)

	arg_4_0._goNormalRight = gohelper.findChild(arg_4_0._gonormal, "right")
	arg_4_0._slotItems = {}
end

function var_0_0.onDestroyView(arg_5_0)
	arg_5_0._simagebg1:UnLoadImage()
	arg_5_0._animEventWrap:RemoveAllEventListener()

	for iter_5_0, iter_5_1 in pairs(arg_5_0._slotItems) do
		gohelper.setActive(iter_5_1.goPos, true)

		if iter_5_1.icon then
			iter_5_1.icon:disposeUI()
			gohelper.destroy(iter_5_1.icon.viewGO)
		end
	end

	if arg_5_0._descItem and arg_5_0._descItem.simageBlackMask then
		arg_5_0._descItem.simageBlackMask:UnLoadImage()
	end

	Activity104EquipController.instance:onCloseView()
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = Activity104EquipItemListModel.MainCharPos
	local var_6_1 = arg_6_0.viewParam.actId
	local var_6_2 = arg_6_0.viewParam.slot or 1
	local var_6_3 = arg_6_0.viewParam.group or 1

	arg_6_0:addEventCb(Activity104EquipController.instance, Activity104EquipEvent.EquipUpdate, arg_6_0.handleEquipUpdate, arg_6_0)
	arg_6_0:addEventCb(Activity104EquipController.instance, Activity104EquipEvent.EquipChangeCard, arg_6_0.handleEquipCardChanged, arg_6_0)
	arg_6_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_6_0.handleSaveSucc, arg_6_0)
	Activity104EquipController.instance:onOpenView(var_6_1, var_6_3, var_6_0, var_6_2)
	arg_6_0:refreshUI()
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = Activity104EquipItemListModel.instance:getCount() == 0

	gohelper.setActive(arg_8_0._goempty, var_8_0)
	gohelper.setActive(arg_8_0._goNormalRight, not var_8_0)
	arg_8_0:refreshDescGroup()
	arg_8_0:refreshSlots()
end

function var_0_0.handleEquipUpdate(arg_9_0)
	arg_9_0:refreshDescGroup()
	arg_9_0:refreshSlots()
end

function var_0_0.refreshSlots(arg_10_0)
	for iter_10_0 = 1, Activity104EquipItemListModel.HeroMaxPos do
		arg_10_0:refreshSlot(iter_10_0)
	end
end

function var_0_0.refreshSlot(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getOrCreateSlot(arg_11_1)
	local var_11_1 = Activity104EquipItemListModel.instance.curEquipMap[arg_11_1]

	gohelper.setActive(var_11_0.goSelect, false)

	if var_11_1 == Activity104EquipItemListModel.EmptyUid then
		gohelper.setActive(var_11_0.goPos, false)
		gohelper.setActive(var_11_0.goEmpty, true)
		gohelper.setActive(var_11_0.goRareEffect, false)
	else
		gohelper.setActive(var_11_0.goPos, true)
		gohelper.setActive(var_11_0.goRareEffect, true)
		gohelper.setActive(var_11_0.goEmpty, false)

		local var_11_2 = arg_11_0:getOrCreateSlotIcon(var_11_0)
		local var_11_3 = Activity104EquipItemListModel.instance:getEquipMO(var_11_1)

		if var_11_3 then
			var_11_2:updateData(var_11_3.itemId)
		elseif Activity104EquipItemListModel.isTrialEquip(var_11_1) then
			local var_11_4 = string.splitToNumber(var_11_1, "#")

			var_11_2:updateData(var_11_4[1])
		end
	end
end

function var_0_0.refreshDescGroup(arg_12_0)
	local var_12_0 = Activity104EquipItemListModel.instance.curPos
	local var_12_1 = Activity104EquipItemListModel.instance.curSelectSlot
	local var_12_2 = Activity104EquipItemListModel.instance.curEquipMap[var_12_1]

	arg_12_0:refreshDesc(arg_12_0:getOrCreateDesc(), var_12_2)
end

function var_0_0.refreshDesc(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_2 == Activity104EquipItemListModel.EmptyUid then
		gohelper.setActive(arg_13_1.go, false)
	else
		gohelper.setActive(arg_13_1.go, true)
		arg_13_1.simageBlackMask:LoadImage(ResUrl.getSeasonIcon("black4.png"))

		local var_13_0 = Activity104EquipItemListModel.instance:getEquipMO(arg_13_2)
		local var_13_1 = var_13_0 and var_13_0.itemId

		if not var_13_1 and Activity104EquipItemListModel.isTrialEquip(arg_13_2) then
			var_13_1 = string.splitToNumber(arg_13_2, "#")[1]
		end

		if var_13_1 then
			local var_13_2 = SeasonConfig.instance:getSeasonEquipCo(var_13_1)

			if var_13_2 then
				arg_13_1.txtName.text = string.format("[%s]", var_13_2.name)

				local var_13_3 = SeasonEquipMetaUtils.getCareerColorDarkBg(var_13_1)

				arg_13_0:refreshProps(var_13_2, arg_13_1, var_13_3)
				arg_13_0:refreshSkills(var_13_2, arg_13_1, var_13_3)
			else
				logError(string.format("can't find season equip config, id = [%s]", var_13_1))
			end
		else
			logError(string.format("can't find season equip MO, itemUid = [%s]", arg_13_2))
		end
	end
end

function var_0_0.refreshProps(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = {}
	local var_14_1 = false

	if arg_14_1 and arg_14_1.attrId ~= 0 then
		local var_14_2 = SeasonEquipMetaUtils.getEquipPropsStrList(arg_14_1.attrId)

		for iter_14_0, iter_14_1 in ipairs(var_14_2) do
			local var_14_3 = arg_14_0:getOrCreatePropText(iter_14_0, arg_14_2)

			gohelper.setActive(var_14_3.go, true)

			var_14_3.txtDesc.text = iter_14_1

			SLFramework.UGUI.GuiHelper.SetColor(var_14_3.txtDesc, arg_14_3)

			var_14_0[var_14_3] = true
			var_14_1 = true
		end
	end

	for iter_14_2, iter_14_3 in pairs(arg_14_2.propItems) do
		if not var_14_0[iter_14_3] then
			gohelper.setActive(iter_14_3.go, false)
		end
	end

	gohelper.setActive(arg_14_2.goAttrParent, var_14_1)
end

function var_0_0.refreshSkills(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = SeasonEquipMetaUtils.getSkillEffectStrList(arg_15_1)
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_2 = arg_15_0:getOrCreateSkillText(iter_15_0, arg_15_2)

		gohelper.setActive(var_15_2.go, true)

		var_15_2.txtDesc.text = iter_15_1

		SLFramework.UGUI.GuiHelper.SetColor(var_15_2.txtDesc, arg_15_3)

		var_15_1[var_15_2] = true
	end

	for iter_15_2, iter_15_3 in pairs(arg_15_2.skillItems) do
		if not var_15_1[iter_15_3] then
			gohelper.setActive(iter_15_3.go, false)
		end
	end
end

function var_0_0.getOrCreatePropText(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_2.propItems[arg_16_1]

	if not var_16_0 then
		var_16_0 = arg_16_0:getUserDataTb_()
		var_16_0.go = gohelper.cloneInPlace(arg_16_2.goAttrDesc, "propname_" .. tostring(arg_16_1))
		var_16_0.txtDesc = gohelper.findChildText(var_16_0.go, "txt_attributedesc")
		arg_16_2.propItems[arg_16_1] = var_16_0
	end

	return var_16_0
end

function var_0_0.getOrCreateSkillText(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_2.skillItems[arg_17_1]

	if not var_17_0 then
		var_17_0 = arg_17_0:getUserDataTb_()
		var_17_0.go = gohelper.cloneInPlace(arg_17_2.goSkillDesc, "skill_" .. tostring(arg_17_1))
		var_17_0.txtDesc = gohelper.findChildText(var_17_0.go, "txt_skilldesc")
		arg_17_2.skillItems[arg_17_1] = var_17_0
	end

	return var_17_0
end

function var_0_0.getOrCreateSlot(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._slotItems[arg_18_1]

	if not var_18_0 then
		var_18_0 = arg_18_0:getUserDataTb_()
		var_18_0.go = gohelper.findChild(arg_18_0.viewGO, "#go_normal/left/equipSlot/slot" .. tostring(arg_18_1))
		var_18_0.goEmpty = gohelper.findChild(var_18_0.go, "go_empty")
		var_18_0.goPos = gohelper.findChild(var_18_0.go, "go_equip/go_pos")
		var_18_0.goSelect = gohelper.findChild(var_18_0.go, "go_equip/go_select")
		var_18_0.goRareEffect = gohelper.findChild(var_18_0.go, "go_rareeffect")
		arg_18_0._slotItems[arg_18_1] = var_18_0
	end

	return var_18_0
end

function var_0_0.getOrCreateSlotIcon(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1.icon

	if not var_19_0 then
		local var_19_1 = arg_19_0.viewContainer:getSetting().otherRes[2]
		local var_19_2 = arg_19_0:getResInst(var_19_1, arg_19_1.goPos, "icon")

		var_19_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_19_2, Season3_0CelebrityCardEquip)
		arg_19_1.icon = var_19_0
	end

	return var_19_0
end

function var_0_0.getOrCreateDesc(arg_20_0)
	local var_20_0 = arg_20_0._descItem

	if not var_20_0 then
		var_20_0 = arg_20_0:getUserDataTb_()
		var_20_0.go = gohelper.findChild(arg_20_0.viewGO, "#go_normal/left/equipDesc/#go_equipDesc")
		var_20_0.goEffect = gohelper.findChild(var_20_0.go, "#go_effect")
		var_20_0.txtName = gohelper.findChildText(var_20_0.go, "#go_effect/txt_name")
		var_20_0.txtDesc = gohelper.findChildText(var_20_0.go, "#go_effect/scroll_desc/Viewport/#txt_desc")
		var_20_0.goAttrDesc = gohelper.findChild(var_20_0.go, "#go_effect/scroll_desc/Viewport/Content/attrlist/#go_attributeitem")
		var_20_0.goSkillDesc = gohelper.findChild(var_20_0.go, "#go_effect/scroll_desc/Viewport/Content/skilldesc/#go_skilldescitem")
		var_20_0.goAttrParent = gohelper.findChild(var_20_0.go, "#go_effect/scroll_desc/Viewport/Content/attrlist")
		var_20_0.simageBlackMask = gohelper.findChildSingleImage(var_20_0.go, "#go_effect/simage_blackmask")
		var_20_0.propItems = {}
		var_20_0.skillItems = {}
		arg_20_0._descItem = var_20_0
	end

	return var_20_0
end

function var_0_0.handleSaveSucc(arg_21_0, arg_21_1)
	if arg_21_0._isManualSave then
		GameFacade.showToast(Activity104EquipController.Toast_Save_Succ)
		arg_21_0:closeThis()
	end
end

function var_0_0.handleSwitchAnimFrame(arg_22_0)
	logNormal("refresh by switch anim frame")
	arg_22_0:refreshSlots()
	arg_22_0:refreshDescGroup()
end

function var_0_0.handleEquipCardChanged(arg_23_0, arg_23_1)
	arg_23_0._animator:Play("switch", 0, 0)
end

function var_0_0._btnequipOnClick(arg_24_0)
	arg_24_0._isManualSave = Activity104EquipController.instance:checkCanSaveSlot()

	if arg_24_0._isManualSave then
		Activity104EquipController.instance:saveShowSlot()
	end
end

function var_0_0._btnhandbookOnClick(arg_25_0)
	ViewMgr.instance:openView(ViewName.Season3_0EquipBookView, {
		actId = arg_25_0.viewParam.actId
	})
end

return var_0_0
